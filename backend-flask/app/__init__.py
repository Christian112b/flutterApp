from flask import Flask
from flask_cors import CORS

def create_app():
    app = Flask(__name__)
    CORS(app)

    # Importa y registra tus rutas
    from routes.test import test_bp
    app.register_blueprint(test_bp, url_prefix="/api")

    from routes.login import login_bp
    app.register_blueprint(login_bp, url_prefix="/api")



    return app
