#define TEMPERATURE_SENSOR_PIN 37

#define AConst 0.001129148
#define BConst 0.000234125
#define CConst 8.76741E-08

float Vo, V1;
float R1 = 10000; // value of R1 on board
float R2, T;

float  Ro = 50000;
float  B = 3950;
float  To = 298.15;
float SERIES_RESISTOR = 10000;


temperatureInfo temperatureHandlerTemp() {
 float V1 = analogRead(TEMPERATURE_SENSOR_PIN);
 Vo = V1 / 1000.0;
 R2 = R1 * (Vo / (3.3 - Vo)); 
 T =  1 / ((1 / To) + ((log10(R2 / Ro)) / B))  - 273.15;
 temperatureInfo t = {V1, T};
 return t;
}

temperatureInfo temperatureHandler() {
 float V1 = analogRead(TEMPERATURE_SENSOR_PIN);
 float resistance = (float)SERIES_RESISTOR / ((4095 / (float)V1) - 1);
 float lnR = log(resistance);
 float temp = (1 / (AConst + (BConst * lnR) + (CConst * lnR * lnR * lnR)))-273.15;
 temperatureInfo t = {V1, temp};
 return t;
}