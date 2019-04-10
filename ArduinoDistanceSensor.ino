/**  
 *  DBSU10 ProxAlert Hiders
 *  @author Iris Verwegen, group U05
 *  @since 06/02/2019
 */

int trigPin1 = 5;
int echoPin1 = 6;
int trigPin2 = 2;
int echoPin2 = 3;
int trigPin3 = 9;
int echoPin3 = 8;


long duration, distance;
long cornerSensor,cornerParallelSensor, parallelSensor;
void setup() {
  Serial.begin(9600); 
   pinMode(trigPin1, OUTPUT);
   pinMode(echoPin1, INPUT);
   pinMode(trigPin2, OUTPUT);
   pinMode(echoPin2, INPUT);
   pinMode(trigPin3, OUTPUT);
   pinMode(echoPin3, INPUT);

}

void loop() {
  //cornerSensor
  SonarSensor(trigPin1, echoPin1);
  cornerSensor = distance;
  //cornerSensor parallel
  SonarSensor(trigPin2, echoPin2);
  cornerParallelSensor = distance;
  //parallel sensor
  SonarSensor(trigPin3, echoPin3);
  parallelSensor = distance;

  Serial.print(cornerSensor);
  Serial.print("X");
  Serial.print(cornerParalleltSensor);
  Serial.print("X");
  Serial.print(parallelSensor);
  Serial.println("X");
}

void SonarSensor(int trigPin, int echoPin) {
  digitalWrite(trigPin,LOW);
  delayMicroseconds(500);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(500);
  digitalWrite(trigPin,LOW);
  duration=pulseIn(echoPin, HIGH);
  distance =(duration/2)/29.1;
  delay(10);
}
