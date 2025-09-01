from flask import Blueprint, request, jsonify

test_bp = Blueprint("test", __name__)

@test_bp.route("/test", methods=["POST"])
def test():
    data = request.get_json()
    print("Mensaje recibido:", data)
    return jsonify({"status": "ok", "echo": data})
