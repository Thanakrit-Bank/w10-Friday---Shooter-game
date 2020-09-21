public class Shooter {
  float posX, posY, size, direction;
  int speed;
  boolean isEnd; // for check the shooter was killed or not
  
  Shooter(){
    posX = width/4;
    posY = height/2;
    size = 50;
    direction = 0;
    speed = 1;
    isEnd = false;
  }
  
  public void draw(){
    if (isEnd == false){
      
      // calculate position for 3 angles of traingle 
      float rightrim1X = posX - (cos(direction+radians(90)) * size/2);
      float rightrim1Y = posY - (sin(direction+radians(90)) * size/2);
      
      float leftrim1X = posX - (cos(direction-radians(90)) * size/2);
      float leftrim1Y = posY - (sin(direction-radians(90)) * size/2);
      
      float midrim1X = posX - (cos(direction+radians(180)) * 5*size/3);
      float midrim1Y = posY - (sin(direction+radians(180)) * 5*size/3);
      
      fill(15,76,129); // green color
      strokeWeight(3); 
      
      // draw the shooter
      triangle(rightrim1X, rightrim1Y, leftrim1X, leftrim1Y, midrim1X, midrim1Y);
      circle(posX,posY,size);
      rect(posX - (cos(direction+radians(170)) * size), posY - (sin(direction+radians(170)) * size), 40 * cos(direction+radians(180)), 20 * sin(direction+radians(180)));
      line(posX, posY, posX - (cos(direction+radians(170)) * size), posY - (sin(direction+radians(170)) * size));
    }
    else {
      // when isEnd == True that is the shooter was killed by zombie
      println("Game Over");
    }
  }
  
  public float getX(){
    // get poition X
    return posX;
  }
  
  public float getY(){
    // get position Y
    return posY;
  }
  
  public float getDirection(){
    return direction;
  }
  
  public void move(String keyInput){
    if (keyInput == "up"){
      
      // move forward
      this.posX += 6 * cos(this.direction);
      this.posY += 6 * sin(this.direction);
    }
    else if (keyInput == "down"){
      
      // move backward
      this.posX -= 6 * cos(this.direction);
      this.posY -= 6 * sin(this.direction);
    }
      
    else if (keyInput == "left"){
      
      // turn left
      this.direction = radians(degrees(this.direction) - 3);
    }
    else if (keyInput == "right"){
      // turn right
      this.direction = radians(degrees(this.direction) + 3);
    }
    else if (keyInput == "spacebar"){
      // the shooter is shoot bullet
      for (int i=0; i<1; i++){
        bullets.get(i).draw();
      }
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
  
  public float getPosY(){
    return posY;
  }
  
  // zombie take damage
  void damage() {
    
  }
}

public class Zombie {
  float posX, posY, direction=0;
  int speed, size, zombie_lives;
  
  static final int COUNT=0;
  Zombie(){
    posX = random(width)+100;
    posY = random(height)+100;
    size = 60;
    speed = 1;
    zombie_lives = 1;
    ZOMBIES_COUNT += 1;
    
  }
  
  void draw(){
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
  
  public float getX(){
    return posX;
  }
  
  public float getY(){
    return posY;
  }
  
  // delete size object (pop list)
  Boolean dead() {
    if (zombie_lives < 1) {
      size = size - size;
    }
    return false;
  }
  
  void kill(){
    
  }
  
}

Shooter shooter;
ArrayList<Bullet> bullets;
int BULLETS_COUNT;
ArrayList<Zombie> zombies;
int ZOMBIES_COUNT;

void setup() {
  size(800,800);
  background(255); // set background color : white
  
  BULLETS_COUNT = 0;
  ZOMBIES_COUNT = 0;
  
  shooter = new Shooter(); // create object of the Shooter
  bullets = new ArrayList<Bullet>(20);
  zombies = new ArrayList<Zombie>(100);
  for (int i=0; i<1; i++){
      Zombie z = new Zombie();
      zombies.add(z);
  }
 
}

void draw(){
  background(255);
  shooter.draw();
  
  /*
    for (Zombie zombie1 : zombies) {
      zombie1.draw();
      zombie1.move(shooter.getX(), shooter.getY());
    }
   */

}

void keyPressed(){
  switch (keyCode){
    case UP:
      // move forward
      shooter.move("up");
      break;
      
    case DOWN:
      // move backward
      shooter.move("down");
      break;
      
    case LEFT:
      // turn left
      shooter.move("left");
      break;
      
    case RIGHT:
      // turn right
      shooter.move("right");
      break;
      
    case 32:
      // spacebar
      shooter.move("spacebar");
      break;
  }
}
