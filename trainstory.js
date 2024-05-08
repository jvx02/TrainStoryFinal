let backgroundImage;
let satellite1, satellite2, clockImage;
let hourHand, minuteHand, secondHand;
let floatingImage, floatingImage1, sunButton;

let satellite1X, satellite1Y;
let satellite2X, satellite2Y;
let satelliteSpeed = 0.006;

let floatingImageX, floatingImageY;
let floatingImageSpeed = 2;

let floatingImage1X, floatingImage1Y;
let floatingImage1Speed = 2;

let minim;
let player;

function preload() {
  backgroundImage = loadImage("data/stars.gif");
  satellite1 = loadImage("data/Smiskis.png");
  satellite2 = loadImage("data/Natalie.png");
  clockImage = loadImage("data/Clock.png");
  hourHand = loadImage("data/hour_hand.png");
  minuteHand = loadImage("data/minute_hand.png");
  secondHand = loadImage("data/second_hand.png");
  floatingImage = loadImage("data/satellite-png-5.png");
  floatingImage1 = loadImage("data/Satellite22.png");
  sunButton = loadImage("data/sowsun.png");
}

function setup() {
  createCanvas(1920, 1080);
  satellite1.resize(150, 0);
  satellite2.resize(100, 0);
  clockImage.resize(700, 0);
  floatingImage.resize(100, 0);
  floatingImage1.resize(100, 0);
  sunButton.resize(100, 0);
  satellite1X = 0;
  satellite1Y = height / 2;
  satellite2X = width;
  satellite2Y = height / 2;
  floatingImageX = random(width);
  floatingImageY = random(height);
  floatingImage1X = random(width);
  floatingImage1Y = random(height);
  minim = new Minim(this);
  player = minim.loadFile("data/Super Mario Galaxy - Gateway Galaxy.mp3", 2048);
  player.play();
}

function draw() {
  image(backgroundImage, 0, 0, width, height);
  let satellite1Pos = moveSatellite(satellite1, satellite1X, satellite1Y, width / 2, height / 2);
  satellite1X = satellite1Pos.x;
  satellite1Y = satellite1Pos.y;
  let satellite2Pos = moveSatellite(satellite2, satellite2X, satellite2Y, width / 2, height / 2);
  satellite2X = satellite2Pos.x;
  satellite2Y = satellite2Pos.y;
  imageMode(CENTER);
  image(clockImage, width / 2, height / 2);
  let hourAngle = map(hour() % 12, 0, 12, 0, TWO_PI) - HALF_PI;
  let minuteAngle = map(minute(), 0, 60, 0, TWO_PI) - HALF_PI;
  let secondAngle = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  push();
  translate(width / 2, height / 2);
  rotate(hourAngle);
  image(hourHand, 0, 0, 150, 150);
  rotate(minuteAngle - hourAngle);
  image(minuteHand, 0, 0, 200, 200);
  rotate(secondAngle - minuteAngle);
  image(secondHand, 0, 0, 250, 250);
  pop();
  updateFloatingImage(floatingImage, floatingImageX, floatingImageY);
  updateFloatingImage(floatingImage1, floatingImage1X, floatingImage1Y);
  image(sunButton, width - sunButton.width - 20, height - sunButton.height - 20);
}

function mousePressed() {
  if (mouseX >= width - sunButton.width - 20 && mouseX <= width - 20 &&
      mouseY >= height - sunButton.height - 20 && mouseY <= height - 20) {
    console.log("Sun button clicked!");
    // Add your custom button click behavior here
  }
}

function moveSatellite(satellite, startX, startY, endX, endY) {
  let distance = dist(startX, startY, endX, endY);
  let step = min(satelliteSpeed * distance, distance);
  let newX = lerp(startX, endX, step / distance);
  let newY = lerp(startY, endY, step / distance);
  image(satellite, newX - satellite.width / 2, newY - satellite.height / 2);
  return createVector(newX, newY);
}

function updateFloatingImage(img, x, y) {
  x += random(-floatingImageSpeed, floatingImageSpeed);
  y += random(-floatingImageSpeed, floatingImageSpeed);
  x = constrain(x, 0, width - img.width);
  y = constrain(y, 0, height - img.height);
  image(img, x, y);
}
