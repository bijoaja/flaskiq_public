# 📢 **Template Flask - FlaskIQ** 💪

## 📌 **DESCRIBE**

<b>FlaskIQ is a Flask project template designed to accelerate the development of web applications based on Python Flask efficiently and structurally. This template is suitable as a foundation for various types of applications, ranging from information systems, backend APIs, to analytical dashboards.With a tidy structure and ready-to-use features, developers can immediately focus on business logic without having to think about the repetitive initial setup.</b>

## **⚙️ Main Feature**
- 🔁 Modular and Scalable Folder Structure
- 🔐 Authentication & Authorization (Optional)
- 🌐 Dynamic Routing and Blueprints
- 📦 ORM Integration (SQLAlchemy / others)
- 📊 Support for API & HTML Templates (Jinja2)
- 🧪 Ready for Testing (Unit Test / Pytest)
- 🔧 Support for .env, Config Class, and Error Handling
- 🚀 Ready for Deployment (Gunicorn, Docker, etc.)
- 🤖 Support for AI Integration (openai, grok, local model, etc)

## **👨‍💻 Support for**
- Beginner to intermediate Flask developers
- Students for web-based final projects
- Researchers or Data Scientists who want to quickly create dashboards or APIs

## **📁 Project Structur**
```
template_flask/
├── app/
│   ├── __init__.py
│   ├── routes.py
│   ├── controller/
│   │   ├── feature/
│   │   ├   ├──*Controller.py
│   ├── model/
│   │   ├── __init__.py
│   │   ├── *model.py
│   ├── service/
│   │   ├── feature
│   │   ├   ├── *_service.py
│   ├── static/
│   │   ├── assets
│   │   ├   ├── CSS/img/js/etc
│   ├── templates/
│   │   ├   ├── base.html
│   │   ├   ├── 404.html
│   │   ├   ├── page/
│   │   ├── assets
├── utils/ ⚙️[TODO]
│   ├── __init__.py
│   ├── *.py
├── config.py
├── server.py
├── requirements.txt
├── .gitignore
├── .dockerignore
├── setup.sh
├── Makefile
├── .env.example
├── docker-compose.yml
└── README.md
```

## ⚙️ **Installation and Usage**
### 1️⃣ Clone Repository

```sh
 git clone https://github.com/bijoaja/flaskiq_public.git your_directory
 cd your_directory
```

### 2️⃣ Run Application

#### <h3> <li> Makefile
```sh
 make setup
```

#### <h3> <li> bash script

```sh
 sh setup.sh
```

<b> Application run on localhost `http://127.0.0.1:<your_port>/`
default port: 8080

## 🛠️ Tech stack

- **Server**: Flask, Flask-RESTful, Flask-JWT-Extended, Flask-SQLAlchemy
- **Database**: postgresql ORM
- **Authenthications**: JWT Token Authentication

## ⚙️ Requirements System
- **FLASK 3.1**
- **PYTHON3 12**
- **OLLAMA 0.9.7-rc0-rocm**

## 📡 Endpoint API (Summary)

| Endpoint        | Method    | Role                       | Description            |
| --------------- | --------- | -------------------------- | ---------------------  |
| `/    `         | GET       | ALL                        | Home view              |
| `/api/`         | GET       | ALL                        | Home API               |
| `/api/docs`     | GET       | ALL                        | Documentation API      |

## 🤝 Contribution

Developed by @bijoaja 💌.

## 📧 Contact

if you have questions or problems, please contact via email: [**BIJOAJA**](mailto\:joelbinsar@gmail.com).

---

# 📢 **Template Flask - FlaskIQ** 💪
