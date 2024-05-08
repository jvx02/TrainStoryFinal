PImage backgroundImage;
PImage satellite1, satellite2, clockImage;
PImage hourHand, minuteHand, secondHand;
PImage floatingImage, floatingImage1, sunButton;

float satellite1X, satellite1Y;
float satellite2X, satellite2Y;
float satelliteSpeed = 0.006;

float floatingImageX, floatingImageY;
float floatingImageSpeed = 2;

float floatingImage1X, floatingImage1Y;
float floatingImage1Speed = 2;

import ddf.minim.*;

Minim minim;
AudioPlayer player;

void setup() {
  size(1920, 1080);  // Set canvas size

  // Load images
  backgroundImage = loadImage("stars.gif");
  satellite1 = loadImage("Smiskis.png");
  satellite2 = loadImage("Natalie.png");
  clockImage = loadImage("Clock.png");
  hourHand = loadImage("hour_hand.png");
  minuteHand = loadImage("minute_hand.png");
  secondHand = loadImage("second_hand.png");
  floatingImage = loadImage("satellite-png-5.png");
  floatingImage1 = loadImage("Satellite22.png");
  sunButton = loadImage("sowsun.png");

  // Resize images
  satellite1.resize(150, 0);
  satellite2.resize(100, 0);
  clockImage.resize(700, 0);
  floatingImage.resize(100, 0);
  floatingImage1.resize(100, 0);
  sunButton.resize(100, 0);

  // Initialize positions
  satellite1X = 0;
  satellite1Y = height / 2;
  satellite2X = width;
  satellite2Y = height / 2;
  floatingImageX = random(width);
  floatingImageY = random(height);
  floatingImage1X = random(width);
  floatingImage1Y = random(height);

  minim = new Minim(this);
  player = minim.loadFile("Super Mario Galaxy - Gateway Galaxy.mp3", 2048);
  player.play();
}

void draw() {
  // Draw background
 image(backgroundImage,0,0, width, height); 

  // Animate satellites and update their positions
  PVector satellite1Pos = moveSatellite(satellite1, satellite1X, satellite1Y, width / 2, height / 2);
  satellite1X = satellite1Pos.x;
  satellite1Y = satellite1Pos.y;

  PVector satellite2Pos = moveSatellite(satellite2, satellite2X, satellite2Y, width / 2, height / 2);
  satellite2X = satellite2Pos.x;
  satellite2Y = satellite2Pos.y;

  // Draw clock
  imageMode(CENTER);
  image(clockImage, width / 2, height / 2);

  // Draw clock hands
  float hourAngle = map(hour() % 12, 0, 12, 0, TWO_PI) - HALF_PI;
  float minuteAngle = map(minute(), 0, 60, 0, TWO_PI) - HALF_PI;
  float secondAngle = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;

  pushMatrix();
  translate(width / 2, height / 2);
  rotate(hourAngle);
  image(hourHand, 0, 0, 150, 150);
  rotate(minuteAngle - hourAngle);
  image(minuteHand, 0, 0, 200, 200);
  rotate(secondAngle - minuteAngle);
  image(secondHand, 0, 0, 250, 250);
  popMatrix();

  // Update and draw floating images
  updateFloatingImage(floatingImage, floatingImageX, floatingImageY);
  updateFloatingImage(floatingImage1, floatingImage1X, floatingImage1Y);

  // Draw sun button in the bottom corner
  image(sunButton, width - sunButton.width - 20, height - sunButton.height - 20);
}

void mousePressed() {
  // Check if mouse is over the sun button
  if (mouseX >= width - sunButton.width - 20 && mouseX <= width - 20 &&
      mouseY >= height - sunButton.height - 20 && mouseY <= height - 20) {
    println("Sun button clicked!");
    // Add your custom button click behavior here
  }
}

PVector moveSatellite(PImage satellite, float startX, float startY, float endX, float endY) {
  float distance = dist(startX, startY, endX, endY);
  float step = min(satelliteSpeed * distance, distance);
  float newX = lerp(startX, endX, step / distance);
  float newY = lerp(startY, endY, step / distance);
  image(satellite, newX - satellite.width / 2, newY - satellite.height / 2);
  return new PVector(newX, newY);
}

void updateFloatingImage(PImage img, float x, float y) {
  x += random(-floatingImageSpeed, floatingImageSpeed);
  y += random(-floatingImageSpeed, floatingImageSpeed);
  x = constrain(x, 0, width - img.width);
  y = constrain(y, 0, height - img.height);
  image(img, x, y);
}
