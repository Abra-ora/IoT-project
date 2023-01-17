#define LIGHT_SENSOR_PIN 36

lightInfo lightSensorHandler() {
 int analogValue = analogRead(LIGHT_SENSOR_PIN);
 lightInfo li = {analogValue, LIGHT_SENSOR_PIN, "null", false};
 if (analogValue < 40) {
   digitalWrite(LED_PIN, HIGH);
    li.lightStatus = "Dark";
    li.ledAllumer = true;
   return li;
  } else if (analogValue < 800) {
   digitalWrite(LED_PIN, HIGH);
   li.lightStatus = "Dim";
   li.ledAllumer = true;
   return li;
  } else if (analogValue < 2000) {
   digitalWrite(LED_PIN, LOW);
   li.lightStatus = "Light";
   li.ledAllumer = false;
   return li;
  } else if (analogValue < 3200) {

   digitalWrite(LED_PIN, LOW);
   li.lightStatus = "Bright";
   return li;
  } else {
   digitalWrite(LED_PIN, LOW);
   li.lightStatus = "Very Bright";
   return li;
  }
}

void setLedOff() {
   digitalWrite(LED_PIN, LOW);
}

void seLedOn() {
  digitalWrite(LED_PIN, HIGH);  
}

