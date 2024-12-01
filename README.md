Este projeto visa controlar remotamente o estado de uma lâmpada (acesa ou apagada) usando um aplicativo móvel desenvolvido em Flutter. O sistema é composto por três partes principais:
App Flutter: Um aplicativo que permite ao usuário controlar a lâmpada via internet.

Backend: Um servidor com duas rotas (GET e POST) que permitem listar e atualizar o status da lâmpada.
ESP32: Um microcontrolador que se conecta a uma rede Wi-Fi e monitora o status da lâmpada, acionando o controle físico de acendimento e apagamento com base nas informações fornecidas pelo servidor.

Tecnologias Utilizadas
Flutter: Framework para desenvolvimento de aplicativos móveis.
ESP32: Microcontrolador utilizado para controlar a lâmpada fisicamente.
Dart: Linguagem de programação usada para desenvolver o aplicativo Flutter.
Python: Plataforma usada para desenvolver o backend.
flesk: Framework para criação do servidor backend em Servidor.py.
Wi-Fi: Para comunicação entre o ESP32, o backend e o aplicativo móvel.

Componentes do Sistema
App Flutter:
Interface para o usuário controlar a lâmpada.
Comunique-se com o backend para obter e atualizar o status da lâmpada.
Backend (Servidor.py com flask):

Duas rotas principais:
GET /status: Retorna o status atual da lâmpada (acesa ou apagada).
POST /status: Atualiza o status da lâmpada (liga ou desliga).

ESP32:
Conecta-se à rede Wi-Fi.
Consulta o backend para verificar o status da lâmpada.
Acende ou apaga a lâmpada fisicamente com base nas informações recebidas.

Componentes necessários:
1 Placa ESP32
1 Módulo de Relé
1 Lâmpada (com bocal que tenha as conexões "neutra" e "positiva")
Fios de conexão
Protoboard ou placa de circuito (opcional)

Passo a Passo para montagem:

1. Conectar o Relé ao ESP32
Pino IN do Relé: Conecte o pino IN do módulo de relé ao pino digital 4 do ESP32.
Pino GND do Relé: Conecte o pino GND do relé ao GND do ESP32.
Pino VCC do Relé: Conecte o pino VCC do relé ao pino 3V3 do ESP32.

2. Conectar o Relé à Lâmpada e à Rede Elétrica

Saída "COM" do Relé: Conecte o pino COM do relé à entrada positiva (fase) da tomada.
Saída "NO" do Relé: Conecte o pino NO (Normalmente Aberto) do relé à entrada positiva (fase) do bocal da lâmpada.
Nota: O pino NO do relé só fará a conexão com o pino COM quando o relé for acionado (ou seja, quando o comando para ligar a lâmpada for enviado).
Saída "Neutra" do Bocal: Conecte a saída neutra do bocal diretamente à linha neutra da tomada. Isso completa o circuito da lâmpada.

3. Conectar a Lâmpada ao Bocal
Conecte os dois fios da lâmpada aos terminais apropriados no bocal (geralmente, o fio positivo vai ao terminal "positivo" do bocal e o fio neutro ao terminal "neutro").

4. Verificar o Funcionamento do Circuito
Agora, ao ligar o ESP32, o módulo de relé estará pronto para controlar a lâmpada. Quando o comando de ligar (ou desligar) for enviado do seu dispositivo móvel, o ESP32 acionará o relé. O relé, por sua vez, fará a conexão entre os terminais NO e COM, permitindo que a lâmpada acenda ou apague.

Resumo das Conexões:
Relé:

COM: Conectado à fase da tomada.
NO: Conectado à fase do bocal da lâmpada.
GND: Conectado ao GND do ESP32.
VCC: Conectado ao pino 3V3 do ESP32.
IN: Conectado ao pino digital 4 do ESP32.
Lâmpada:

Positivo (fase): Conectado ao pino NO do relé e ao bocal.
Neutro: Conectado diretamente ao neutro da tomada e ao bocal.
