int trigPin1 = 9;
int echoPin1 = 10;
int trigPin2 = 11;
int echoPin2 = 12;


long duration, distance;
long RightSensor,LeftSensor;
void setup() {
  Serial.begin(9600); 
   //pinMode(led, OUTPUT);
   pinMode(trigPin1, OUTPUT);
   pinMode(echoPin1, INPUT);
   pinMode(trigPin2, OUTPUT);
   pinMode(echoPin2, INPUT);
  // put your setup code here, to run once:

}

void loop() {
  SonarSensor(trigPin1, echoPin1);
  LeftSensor = distance;
  SonarSensor(trigPin2, echoPin2);
  RightSensor = distance;

  Serial.print(LeftSensor);
  Serial.print("X");
  Serial.println(RightSensor);
}

void SonarSensor(int trigPin, int echoPin) {
  digitalWrite(trigPin,LOW);
  delayMicroseconds(500);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(500);
  digitalWrite(trigPin,LOW);
  duration=pulseIn(echoPin, HIGH);
  distance =(duration/2)/29.1;
  //Serial.println(distance);
  //Serial.println("CM");
  delay(10);
}
