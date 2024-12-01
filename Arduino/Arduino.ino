#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>

// Defina o nome da rede Wi-Fi e a senha
const char* ssid = "teste";
const char* password = "**********";

// Defina a URL para a requisição GET
const char* url = "http://50.19.176.239:5000/status";

// Defina o pino para controlar a lâmpada
const int lampPin = 4;  // Usando GPIO 4 (ou outro pino que preferir)

void setup() {
  // Inicializa a comunicação serial
  Serial.begin(115200);
  Serial.println("Iniciando ESP32...");

  // Configura o pino da lâmpada como saída
  pinMode(lampPin, OUTPUT);
  digitalWrite(lampPin, LOW); // Inicialmente, a lâmpada está apagada

  // Conecta ao Wi-Fi
  WiFi.begin(ssid, password);
  Serial.println("Conectando ao Wi-Fi...");

  // Aguarda até conectar
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  // Exibe o status de conexão
  Serial.println("\nConexão estabelecida!");
  Serial.print("Endereço IP: ");
  Serial.println(WiFi.localIP());
}

void loop() {
  // Cria um objeto HTTPClient para fazer a requisição GET
  HTTPClient http;

  // Verifica se o ESP32 está conectado ao Wi-Fi
  if (WiFi.status() == WL_CONNECTED) {
    // Inicia a requisição GET
    http.begin(url);
    int httpCode = http.GET(); // Realiza a requisição GET

    // Verifica o código de resposta
    if (httpCode > 0) {
      // Se a requisição for bem-sucedida, exibe o código de status e o conteúdo da resposta
      Serial.printf("Código de status: %d\n", httpCode);
      String payload = http.getString(); // Obtém o corpo da resposta
      Serial.println("Resposta da requisição:");
      Serial.println(payload); // Exibe o conteúdo da resposta no terminal

      // Usando ArduinoJson para parsear a resposta JSON
      DynamicJsonDocument doc(1024); // Aloca memória para o documento JSON

      // Tenta analisar a resposta JSON
      DeserializationError error = deserializeJson(doc, payload);
      if (error) {
        Serial.print("Falha ao analisar JSON: ");
        Serial.println(error.f_str());
        return;
      }

      // Extrai o valor de "status" da resposta JSON
      bool status = doc["status"]; // Pega o valor booleano do campo "status"

      // Verifica o valor do status
      if (status) {
        // Se o status for "true", acende a lâmpada
        digitalWrite(lampPin, LOW);
        Serial.println("Lâmpada acesa");
      } else {
        // Se o status for "false", apaga a lâmpada
        digitalWrite(lampPin, HIGH);
        Serial.println("Lâmpada apagada");
      }
    } else {
      // Se a requisição falhar, exibe o erro
      Serial.printf("Erro na requisição: %s\n", http.errorToString(httpCode).c_str());
    }

    // Finaliza a conexão HTTP
    http.end();
  } else {
    // Caso o ESP32 não esteja conectado ao Wi-Fi
    Serial.println("Wi-Fi desconectado!");
  }

  delay(10000); // Espera 10 segundos antes de realizar outra requisição
}