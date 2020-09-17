public class Shooter {
  float posX, posY, size, direction;
  int speed, hp;
  boolean isDead, isMove;
  
  Shooter(){
    posX = width/2;
    posY = height/2;
    size = 50;
    direction = 0;
    speed = 1;
    hp = 3;
    isDead = false;
    isMove = false;
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
  
  public void setBullet(int amount){
    bullet = new Bullet[amount];
    for (int i=0; i<amount; i++){
      bullet[i] = new Bullet(posX +(40*i), posY);
    }
  }
  
  void move(){
    if (keyPressed == true){
       switch (keyCode){
          case UP:
            // move up
            shooter.posY -= 1;
            break;
            
          case DOWN:
            // move down
            shooter.posY += 1;
            break;
            
          case LEFT:
            // move left
            shooter.posX -= 1;
            break;
            
          case RIGHT:
            // move right
            shooter.posX += 1;
            break;
      }
    }
    if (isMove == false){
      if (posX != width/2 || posY != height/2){
        isMove = true;
        this.setBullet(10);
      }
    }
    else if (isMove == true){
      if (bullet[bullet.length/2].posX >= width-30){
        this.setBullet(10);
      }
    }
    
  }
  
}

public class Bullet {
  float posX, posY;
  
  Bullet(float positionX, float positionY){
    posX = positionX + 90;
    posY = positionY;
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

Shooter shooter;
Bullet[] bullet;

void setup() {
  size(800,800);
  background(255);
  
  shooter = new Shooter();
}

void draw(){
  background(255);
  shooter.draw();
  shooter.move();
  
  if (shooter.isMove == true){
    for (Bullet bullet1 : bullet) {
      bullet1.draw();
      bullet1.move();
    }
  }
  
}
