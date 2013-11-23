int pin = 2;

void setup() {
  Serial.begin(9600);
  pinMode(pin, INPUT);
}

boolean buttonPressed; 
void loop() {
  if(digitalRead(pin) == HIGH && !buttonPressed) {
    buttonPressed = true;
    //Serial.println("button pressed");
    Serial.print("r1");
  } else if(digitalRead(pin) == LOW && buttonPressed) {
    buttonPressed = false;
    Serial.print("s1");
    Serial.print("p1");
    //Serial.println("button not pressed");
  }
  delay(250);
}
