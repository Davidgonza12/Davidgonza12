volatile long contador = 0;
int sensor = 3;
int interrupciones_por_revolucion = 20;

void setup() {
  pinMode(sensor, INPUT);
  Serial.begin(115200);
  attachInterrupt(digitalPinToInterrupt(sensor), interrupcion, RISING);
}

void loop() {
  static unsigned long lastTime = 0;
  unsigned long currentTime = millis();
  
  if(currentTime - lastTime >= 1000) {
    int rpm = contador * 3; /// interrupciones_por_revolucion;
    Serial.println(rpm);
    contador = 0;
    lastTime = currentTime;
  }
}

void interrupcion() {
  contador++;
}

