import socket
from flask import Flask, request, jsonify
from flask_cors import CORS
from MeuIp import ip_server

app = Flask(__name__)
CORS(app)



status = False


@app.route('/desativar-ativar', methods=['POST'])
def desativar_ativar():
    global status
    dados = request.headers.get("stats")
    print(f"Dado recebido: {dados}")

    if dados == 'ativar':
        status = True
    if dados == 'desativar':
        status = False


    print(f"Status atual: {status}")
    return jsonify({'status': status})



@app.route('/status', methods=['GET'])
def verifica_status():
    global status
    return jsonify({'status': status})




if __name__ == "__main__":
    hostname = socket.gethostname()
    ip = socket.gethostbyname(hostname)
    print(f"Operando no ip: {ip}")

    Servidor_usado = ip_server()

    app.run(host=ip, port=5000, debug=False)