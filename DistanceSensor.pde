import nl.tue.id.oocsi.*;
import processing.serial.*;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;

OOCSI oocsi;
Serial myPort;
String distance = "";
String data = "";
Date timestamp = new Date();

void setup () {  
  oocsi = new OOCSI(this, "TimestoneSquad", "oocsi.id.tue.nl");
  size(1666,900); // size of processing window
  noStroke();
  background(0);
  //frameRate(1);
  oocsi.channel("TimestoneSquad").data("distance",0).send();
  myPort = new Serial(this, "COM3", 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  fill(0);
  rect(0,0,1666,900);
  fill(#4B5DCE); //RAINBOWS
  //rect(x,y,20,20); do not remove comment
  textAlign(CENTER);
  //fill(255); do not remove comment
  text(distance,820,400);
  textSize(100);
  noFill();
  stroke(#4B5DCE);
  textAlign(CENTER);
  translate(0, 100);
  fill(#4B5DCE); //MORE RAINBOWS
  text(timestamp.toString(),820,400);
  textSize(100);
  
}

void handleOOCSIEvent(OOCSIEvent e) {
  if(random(100)<0.5){ //could not retrieve the integers, so now only random
    timestamp = e.getTimestamp();
  }
  data = e.getString("distanceSensor1", ""); //<>//
  oocsi.channel("TimestoneSquad").data("distanceSensor1",distance).send();
}


void serialEvent(Serial myPort) {
  distance = myPort.readStringUntil('\n');
}
