#!/bin/bash

# Exit on any error
set -e

echo "🚀 Menjalankan setup project FlaskIQ..."

# 1. Pull terbaru
echo "📥 Melakukan git pull..."
git pull

# 2. Salin .env jika belum ada
if [ ! -f .env ]; then
  echo "📄 Menyalin .env.example ke .env..."
  cp .env.example .env
else
  echo "✅ File .env sudah ada, dilewati."
fi

# 3. 🔹 INPUT: Integrasi OLLAMA
read -p "🤖 Apakah Anda ingin mengaktifkan integrasi Ollama (AI)? [y/n]: " enable_ai
enable_ai=$(echo "$enable_ai" | tr '[:upper:]' '[:lower:]')

if [[ "$enable_ai" == "y" || "$enable_ai" == "yes" ]]; then
  export USE_OLLAMA=true
else
  export USE_OLLAMA=false
fi

# 4. Export variabel dari .env
if [ -f .env ]; then
  echo "📦 Memuat variabel dari .env..."
  set -o allexport
  source "$(pwd)/.env"
  set +o allexport
else
  echo "❌ File .env tidak ditemukan setelah pengecekan."
  exit 1
fi

# 👉 OVERRIDE nilai dari input tetap harus diulang
export USE_OLLAMA=$USE_OLLAMA
sed -i.bak "s/^USE_OLLAMA=.*/USE_OLLAMA=$USE_OLLAMA/" .env

# 5. Pull image flaskiq
echo "🐳 Pull image flaskiq..."
docker pull bijoaja/flaskiq:latest

# 6. Jalankan container
echo "▶️ Menjalankan container..."
if [ "$USE_OLLAMA" = "true" ]; then
  echo "🧠 OLLAMA AKTIF — AI akan dijalankan..."
  docker-compose up -d flaskiq_web flaskiq_db flaskiq_ai
else
  echo "🚫 OLLAMA NONAKTIF — hanya menjalankan web dan database..."
  docker-compose up -d flaskiq_web flaskiq_db
fi

# 7. Tunggu beberapa detik agar service siap
echo "⏳ Menunggu service siap..."
sleep 10

# 7. Jika AI aktif, cek model dan koneksi
if [ "$USE_OLLAMA" = "true" ]; then
  echo "🔍 Mengecek status flaskiq_ai (Ollama)..."
  docker-compose exec flaskiq_ai ps aux | grep ollama || echo "⚠️ Ollama belum aktif sepenuhnya."

  echo "🔎 Mengecek apakah model 'mistral' sudah tersedia..."
  MODEL_EXISTS=$(curl -s http://localhost:11434/api/tags | grep '"name": "mistral"')
  if [ -n "$MODEL_EXISTS" ]; then
    echo "✅ Model 'mistral' sudah tersedia."
  else
    echo "📦 Model belum tersedia. Pulling secara manual..."
    docker-compose exec flaskiq_ai ollama pull mistral || {
      echo "❌ Gagal menjalankan 'ollama pull mistral'"
      exit 1
    }
  fi

  echo "🧠 Mengetes koneksi ke AI..."
  if docker-compose exec flaskiq_web which curl >/dev/null 2>&1; then
    docker-compose exec flaskiq_web curl -s http://flaskiq_ai:11434/api/generate -H "Content-Type: application/json" -d '{
      "model": "mistral",
      "prompt": "Halo, siapa kamu?",
      "stream": false
    }' || echo "⚠️ Koneksi dari container gagal."
  else
    echo "⚠️ curl tidak tersedia di flaskiq_web, tes koneksi dari host..."
    curl -s http://localhost:11434/api/generate -H "Content-Type: application/json" -d '{
      "model": "mistral",
      "prompt": "Halo, siapa kamu?",
      "stream": false
    }' || echo "⚠️ Koneksi dari host gagal."
  fi
else
  echo "ℹ️ Melewati setup AI karena OLLAMA tidak diaktifkan."
fi

# 8. Setup database
echo "🛠️ Inisialisasi database..."
docker-compose exec flaskiq_web flask db init || echo "⚠️ Sudah di-init, dilewati."

echo "🛠️ Migrasi database..."
docker-compose exec flaskiq_web flask db migrate -m "add: init db"

echo "🛠️ Upgrade database..."
docker-compose exec flaskiq_web flask db upgrade

echo "✅ Setup selesai! 🎉"
