/**  
 *  DBSU10 ProxAlert Hiders
 *  @author Iris Verwegen, group U05
 *  @since 06/02/2019
 */

import nl.tue.id.oocsi.*;
import processing.serial.*;
import java.util.*;

//The oocsi variable
OOCSI oocsi;

//The serial port for the arduino
Serial myPort;

//Boolean for if the buddy route is satisfied
boolean isBuddyUnlocked = false;

//Boolean for if the individual route is satisfied
boolean isUnlocked = false;

//int for distance to sensor1
int[] distance = new int[3];

//string to receive from arduino
String val = "1000X1000X1000";

//Timer for the heartbeat
int timer = 0;

//Timer for the individual route
long trigTimer = 0;

void setup () {  
  oocsi = new OOCSI(this, "U05", "oocsi.id.tue.nl");
  size(1666,900); // size of processing window
  noStroke();
  background(0);
  //run draw() ten times per second
  frameRate(10);
  //port for the arduino, for now at least
  myPort = new Serial(this, "COM3", 9600);
}

void draw() {
  timer += 1;
  trigTimer -= 1;
  //Send a heartbeat every minute
  if(timer == 600) {
    timer = 0;
    sendHeartbeat();
  }
  //Receive the data
  if(myPort.available() > 0) {
    if(val!=null) {
      String[] data = splitTokens(val,"X");      
      distance[0] = parseInt(data[0]);
      if (data.length > 1){
        distance[1] = parseInt(data[1]);
      }
      if (data.length > 2) {
        distance[2] = parseInt(data[2]);
      }
    }
  }
  
  //Check if module is unlocked
  
  //Is the person within 50-150cm of the sensor?
  if(distance[1] > 50 && distance[1] < 150) {
    //start the timer
    trigTimer = 100;
  }
  //is the person within 20cm of the other sensor within 10 seconds of the previous trigger?
  if(withinTimer() && distance[2] < 20 &&!isUnlocked) {
    isUnlocked = true;
    //send unlocked signal
    sendUnlocked();
  } else if(distance[0]<20 && distance[1]<20 && distance[0] > 0 && distance[1] > 0 && !isBuddyUnlocked) {
    isBuddyUnlocked = true;
    sendUnlocked();    
  }
}

boolean withinTimer(){
  return trigTimer > 0;
}

void sendHeartbeat() {
  oocsi.channel("urielHeartBeat").data("group",5).send();
}

//We can only be unlocked with buddy or individual. There is no reset at the moment.
void sendUnlocked() {
  if(isUnlocked) {
    oocsi.channel("urielUnlock").data("group",5).data("level",1).send(); //unlock code for individual
  } 
  if(isBuddyUnlocked){ //if we are unlocked with the buddy
    oocsi.channel("urielUnlock").data("group",5).data("level",0).send(); //unlock code for buddy
  }
}

void serialEvent(Serial myPort) {
  String temp = myPort.readStringUntil('\n');
  if (temp != null){
    val = temp;
  }
}
