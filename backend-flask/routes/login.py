from flask import Blueprint, request, jsonify

login_bp = Blueprint("login", __name__)

@login_bp.route("/login", methods=["POST"])
def login():
    data = request.json
    user = data.get("username")
    password = data.get("password")

    if user == "admin" and password == "1234":
        return jsonify({"success": True, "message": "Login exitoso"})
    else:
        return jsonify({"success": False, "message": "Credenciales inválidas"}), 401

