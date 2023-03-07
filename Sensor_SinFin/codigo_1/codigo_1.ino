//Definir el pin de entrada del sensor de velocidad
int sensorPin = 2;
char buffer[10];
//Definir el número de marcas o ranuras en la rueda del encoder
int N = 20;

//Inicializar la variable que almacena el tiempo transcurrido
volatile unsigned long time_elapsed = 0;

//Definir la función de interrupción
void sensorInterrupt() {
  static unsigned long last_time = 0;
  unsigned long current_time = micros();
  time_elapsed = current_time - last_time;
  last_time = current_time;
}

void setup() {
  //Inicializar el puerto serie para imprimir valores
  Serial.begin(9600);
  
  //Configurar el pin del sensor de velocidad como entrada
  pinMode(sensorPin, INPUT);

  //Configurar la interrupción para el pin del sensor de velocidad
  attachInterrupt(digitalPinToInterrupt(sensorPin), sensorInterrupt, CHANGE);
}

void loop() {
  //Calcular las RPM
  float rpm = (60.0 / time_elapsed) * N;
  
  //Imprimir las RPM
  //dtostrf(rpm, 6, 2, buffer); // convierte el valor a una cadena con 2 decimales y una longitud total de 6 caracteres

  Serial.println(buffer); // imprime la cadena resultante

  
  //Esperar un tiempo antes de tomar otra medición
  delay(100);
}

