#include<TFT_eSPI.h>
#include<SPI.h>
#include<math.h>
#define LED_PIN 33 
TFT_eSPI tft = TFT_eSPI(); 
#define TFT_GREY 0x5AEB 
struct temperatureInfo {
    float pinValue;
    float temperature;
};
struct lightInfo {
  float pinValue;
  int pinNumber;
  char* lightStatus;
  bool ledAllumer;
};

bool autoControl = true;
bool lightControl = false;
void setup() {  
  Serial.begin(9600);
  tft.begin();
  tft.fillScreen(TFT_GREY);
  tft.setTextColor(TFT_WHITE,TFT_BLACK);  
  tft.setTextSize(3);
  // initialize serial communication at 9600 bits per second:
  pinMode(LED_PIN, OUTPUT);
  tft.setRotation(1);
  Serial.println("**********************************");
  connectToWiFi();
  Serial.println("************* Wifi connected **********");
  setup_routing();
  Serial.println("************* Server started ***********");  
}

void loop() {
 tft.setCursor(0, 0, 2);
 temperatureInfo t = temperatureHandler();
 tft.print(t.temperature ); tft.println(" °C");
 if (autoControl) {
   Serial.println("Auto control activated");
   lightInfo li = lightSensorHandler();
    tft.println(li.lightStatus );
    if (li.ledAllumer) {
      tft.println("lED Allumer");
    } else {
        tft.println("lED Eteint");
    }
 } else {
   Serial.println("Manually control activated");
   if (lightControl) {
     seLedOn();
   } else {
     setLedOff();     
   }
 }
 delay(1000);
}