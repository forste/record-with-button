import ddf.minim.*;
import processing.serial.*;

Minim minim;
AudioRecorder recorder;
AudioInput in;
AudioPlayer player;
String fileName = "object";
Serial myPort;
boolean[] recording = { false, false, false };

void setup() {
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO);
  
  println(Serial.list());
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);
  
}
void draw() {
  while(myPort.available() > 0) {
    processCommands();
  }
}

void processCommands() {
  char command = myPort.readChar();
  int object = myPort.read() - 49;
  println("received command "+command+" on object "+object);
  
  switch(command) {
    case 'r' : 
      startRecording(object);
      break;
    case 's' :
      stopRecording(object);
      break;
    case 'p' :
      playRecording(object);
      break;
  }
}

void startRecording(int object) {
  if(recording[object]) {
    println("already recording object "+object);
    return;
  }
  println("recording object "+object);
  recorder = minim.createRecorder(in, getFilename(object), false);
  recorder.beginRecord();
  recording[object] = true;
}
void stopRecording(int object) {
  if(!recording[object]) {
    println("object "+object+" is not returning");
    return;
  }
  recording[object] = false;
  recorder.endRecord();
  recorder.save();
  println("Saved a recording for object "+object);
}

void playRecording(int object) {
  println("playing object "+object); 
  player = minim.loadFile(getFilename(object));
  player.play();
}

String getFilename(int object) {
  return fileName+"-"+object+".wav";
}


