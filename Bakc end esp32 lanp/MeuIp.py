import socket
hostname = socket.gethostname()
ip = socket.gethostbyname(hostname)

def ip_server():

    Servidor = False
    if Servidor:
        Servidor = "https://snappose.ai"
        return Servidor
    else:
        Servidor = f"http://{ip}:5000"
        return Servidor