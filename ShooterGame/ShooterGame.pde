public class Shooter {
  float posX, posY, size, direction;
  int speed, hp;
  boolean isDead, isMove;
  
  Shooter(){
    posX = width/4;
    posY = height/2;
    size = 50;
    direction = 0;
    speed = 1;
    hp = 3;
    isDead = false;
    isMove = false;
  }
  
  public void draw(){
    float rightrim1X = posX - (cos(direction+radians(90)) * size/2);
    float rightrim1Y = posY - (sin(direction+radians(90)) * size/2);
    
    float leftrim1X = posX - (cos(direction-radians(90)) * size/2);
    float leftrim1Y = posY - (sin(direction-radians(90)) * size/2);
    
    float midrim1X = posX - (cos(direction+radians(180)) * 5*size/3);
    float midrim1Y = posY - (sin(direction+radians(180)) * 5*size/3);
    
    
    fill(15,76,129);
    strokeWeight(3);
    triangle(rightrim1X, rightrim1Y, leftrim1X, leftrim1Y, midrim1X, midrim1Y);
    circle(posX,posY,size);
    rect(posX - (cos(direction+radians(170)) * size), posY - (sin(direction+radians(170)) * size), 40 * cos(direction+radians(180)), 20 * sin(direction+radians(180)));
    line(posX, posY, posX - (cos(direction+radians(170)) * size), posY - (sin(direction+radians(170)) * size));
  }
  
  public float getX(){
    return posX;
  }
  
  public float getY(){
    return posY;
  }
  
  public float getDirection(){
    return direction;
  }
  
  public void setZombie(int amount){
    for (int i=0; i<amount; i++){
      Zombie z = new Zombie();
      zombies.add(z);
    }
  }
  
  public void setBullet(int amount){
    for (int i=0; i<amount; i++){
      Bullet b = new Bullet(posX +(40*i), posY, 0);
      bullets.add(b);
    }
  }
  
  void move(char keyInput){
    if (keyInput == ' '){
      if (bullets.get(bullets.size()/2).posX >= width-30){
        this.setBullet(1);
      }
    }
    else{
      if (posX != width/4 || posY != height/2){
        this.setBullet(1);
        this.setZombie(3);
      }
    }
  }
  
  void dead() {
    if (hp < 1) {
      // pass
    }
  }
  
}

public class Bullet {
  float posX, posY, direction;
  
  Bullet(float positionX, float positionY, float direction){
    posX = positionX + 90;
    posY = positionY;
    BULLETS_COUNT += 1;
  }
  
  public void draw(){
    fill(235,200,21);
    rect(posX,posY,30,10);
  }
  
  public void move(){
    posX += 10;
  }
  
  public float getPosX(){
    return posX;
  }
  
  void damage() {
    // if () {
      // pass
    //}
  }
}

public class Zombie {
  float posX, posY, direction=0;
  int speed, size, zombie_lives;
  
  static final int COUNT=0;
  Zombie(){
    posX = random(width);
    posY = random(height);
    size = 60;
    speed = 1;
    zombie_lives = 1;
    ZOMBIES_COUNT += 1;
    
  }
  
  public void draw(){
    fill(48,119,81);
    strokeWeight(3);
    circle(posX,posY,size);
    point(posX,posY);
    

    float rightrim1X = posX - (cos(direction+radians(90)) * size/2);
    float rightrim1Y = posY - (sin(direction+radians(90)) * size/2);
    float rightrim2X = posX - (cos(direction+radians(13)) * size);
    float rightrim2Y = posY - (sin(direction+radians(13)) * size);
    line(rightrim1X, rightrim1Y, rightrim2X, rightrim2Y);

    float leftrim1X = posX - (cos(direction-radians(90)) * size/2);
    float leftrim1Y = posY - (sin(direction-radians(90)) * size/2);
    float leftrim2X = posX - (cos(direction-radians(13)) * size);
    float leftrim2Y = posY - (sin(direction-radians(13)) * size);
    line(leftrim1X, leftrim1Y, leftrim2X, leftrim2Y);
  }

  public void move(float shooterX, float shooterY){
    direction = (atan2(posY - shooterY, posX - shooterX));
    
    float dist = dist(posX, posY, shooterX, shooterY);
    if(posX <= shooterX){
      posX += dist/500;
    }
    else if (posX >= shooterX){
      posX -= dist/500;
    }
    if(posY <= shooterY){
      posY += dist/500;
    }
    else if (posY >= shooterY){
      posY -= dist/500;
    }
  }
  
  Boolean die() {
    if (zombie_lives < 1) {
      return true;
    }
    return false;
  }
  
  void kill(){
    
  }
  
}

Shooter shooter;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
int BULLETS_COUNT = 0;
ArrayList<Zombie> zombies = new ArrayList<Zombie>();
int ZOMBIES_COUNT = 0;

void setup() {
  size(800,800);
  background(255);
  
  shooter = new Shooter();
  
}

void draw(){
  background(255);
  shooter.move(key);
  shooter.draw();
  
  if (shooter.isMove == true){
    for (Bullet bullet1 : bullets) {
      bullet1.draw();
      bullet1.move();
    }
    for (Zombie zombie1 : zombies) {
      zombie1.draw();
      zombie1.move(shooter.getX(), shooter.getY());
    }
  }
}
void keyPressed()
{
  switch (keyCode){
    case UP:
      // move forward
      shooter.posX += 6 * cos(shooter.direction);
      shooter.posY += 6 * sin(shooter.direction);
      break;
      
    case DOWN:
      // move backward
      shooter.posX -= 6 * cos(shooter.direction);
      shooter.posY -= 6 * sin(shooter.direction);
      break;
      
    case LEFT:
      // turn left
      shooter.direction = radians(degrees(shooter.direction) - 3);
      break;
      
    case RIGHT:
      // turn right
      shooter.direction = radians(degrees(shooter.direction) + 3);
      break;
  }
  print(shooter.direction);
}
