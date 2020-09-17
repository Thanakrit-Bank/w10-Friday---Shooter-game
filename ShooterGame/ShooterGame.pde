public class Shooter {
  float posX, posY, size, direction;
  int speed, hp;
  boolean isDead = false;
  
  Shooter(){
    posX = width/2;
    posY = height/2;
    size = 50;
    direction = 0;
    speed = 1;
    hp = 3;
  }
  
  public void draw(){
    fill(15,76,129);
    strokeWeight(3);
    triangle(posX, posY - size/2, posX, posY + size/2, posX + 85, posY);
    circle(posX,posY,size);
    rect(posX+50, posY-10, 40, 20);
  }
  
  public float getPosX(){
    return posX;
  }
  
  public float getPosY(){
    return posY;
  }
  
  public float getDirection(){
    return direction;
  }
  
  void move(){
    
  }
  
}

public class Bullet {
  float posX = shooter.posX;
  float posY = shooter.posY;
  
  Bullet(){
    
  }
  
  public void draw(){
    rect(posX,posY,30,10);
  }
  
  void move(){
  }
  
}

public class Zombie {
  int posX = 0;
  int posY = 0;
  int speed = 1;
  int hp = 3;
  boolean isDead = false;

  void move(){
  }
  
}

Shooter shooter = new Shooter();
Bullet bullet1 = new Bullet();
float angle;

void setup() {
  size(800,800);
  background(255);
}

void draw(){
  background(255);
  shooter.draw();
}

void keyPressed(){
  switch (keyCode){
    case UP:
      angle += 1;
      
    case DOWN:
      angle -= 1;
      
    case LEFT:
      angle += 1;
      
    case RIGHT:
      angle -= 1;
  }
}
