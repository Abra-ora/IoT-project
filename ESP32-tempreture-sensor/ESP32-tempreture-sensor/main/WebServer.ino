#include <WiFi.h>
#include <ESPAsyncWebServer.h>
#include <ArduinoJson.h>

const char *ssid = "Ddd";           // Enter SSID here
const char *password = "jdyd4777";  //Enter Password here

AsyncWebServer server(8080);

void connectToWiFi() {
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  uint32_t notConnectedCounter = 0;
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.print("Connected. IP: ");
  Serial.println(WiFi.localIP());
}

// setup API resources
void setup_routing() {
  getTemperature();
  getWifiInformation();
  getLightStatus();
  setControlStatus();
  setLightStatus();
  server.begin();
}

void getWifiInformation() {
  server.on("/api/wifi-info", HTTP_GET, [](AsyncWebServerRequest *request) {
    AsyncResponseStream *response = request->beginResponseStream("application/json");
    DynamicJsonDocument json(1024);
    json["status"] = "ok";
    json["ssid"] = WiFi.SSID();
    json["ip"] = WiFi.localIP().toString();
    serializeJson(json, *response);
    request->send(response);
  });
}
void getTemperature() {
  server.on("/api/temperature", HTTP_GET, [](AsyncWebServerRequest *request) {
    AsyncResponseStream *response = request->beginResponseStream("application/json");
    DynamicJsonDocument json(1024);
    json["status"] = "ok";
    json["temperature"] = temperatureHandler().temperature;
    json["pinNumber"] = TEMPERATURE_SENSOR_PIN;
    json["pinValue"] = temperatureHandler().pinValue;
    serializeJson(json, *response);
    request->send(response);
  });
}

 void setControlStatus() {
  server.on("/api/controle", HTTP_POST, [](AsyncWebServerRequest * request) 
  {
    int paramsNr = request->params(); 
    Serial.println(paramsNr);
    Serial.println();
    AsyncWebParameter* p = request->getParam(0);
     Serial.println("received value : " + p->value());
    if (p->value() == "true") {
      autoControl = false;
    } else {
      Serial.println("make the auto control false");
      autoControl = true;
    }
    request->send(200);
  });  
}

 void setLightStatus() {
  server.on("/api/light", HTTP_POST, [](AsyncWebServerRequest * request) 
  {
    int paramsNr = request->params(); 
    Serial.println(paramsNr);
    Serial.println();
    AsyncWebParameter* p = request->getParam(0);
    Serial.println("received value : " + p->value());
    if (p->value() == "true") {
      lightControl = true;
    } else {
      lightControl = false;
    } 
    request->send(200);
  });  
}

void getLightStatus() {
  server.on("/api/light", HTTP_GET, [](AsyncWebServerRequest *request) {
    AsyncResponseStream *response = request->beginResponseStream("application/json");
    DynamicJsonDocument json(1024);
    lightInfo li = lightSensorHandler();
    json["status"] = "ok";
    json["lightStatus"] = li.lightStatus;
    json["pinNumber"] = li.pinNumber;
    json["pinValue"] = li.pinValue;
    json["ledAllumer"] = li.ledAllumer;
    serializeJson(json, *response);
    request->send(response);
  });
}
