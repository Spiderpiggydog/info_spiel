class Enemy {
  PVector pos, acc;
  int speed = 1;
  int enemyHealth;
  PVector[] islands;
  PVector curIsland, prevIsland;
  float angle;
  int w, h;
  Boolean inAir = false;
  
  Enemy(float x, float y, PVector[] island, PImage is, int health) {
    pos = new PVector(x, y);
    acc = new PVector(0, 0);
    w = is.width;
    h = is.height;
    islands = island.clone();
    curIsland = islands[2];
    prevIsland = islands[1];
    enemyHealth = health;
    
  }
  
  void run() {
    
    if((curIsland.x > pos.x || curIsland.x + w < pos.x ||
       curIsland.y > pos.y || curIsland.y + h < pos.y) && inAir == false) {
      
      inAir = true;
      acc.add(-7 - random(-3, 3), -10 - random(0, 3));
      
      
    }
    
    if(!(prevIsland.x > pos.x || prevIsland.x + w < pos.x ||
       prevIsland.y > pos.y || prevIsland.y + h < pos.y)) {
         acc.set(0, 0);
         inAir = false;
       }
    
    angle = frameCount%20>10 ?0.1:-0.1;
    pos.x -= speed;
    
    
    
    
    if(inAir) {
      acc.add(0, 0.4);
      pos.add(acc);
      
      if(frameCount % 25 == 0) {
        acc.add(-1, -2);
      }
      
      angle = -0.1;
    }
    
    
    
    bullets.forEach(b -> {
      //Headshots
      if(PVector.add(pos, new PVector(0, -18)).dist(b.pos) < 25) {
        enemyHealth -= b.bulletDamage*2;
        b.bulletHealth -= b.bulletDamage;
      };
      if(pos.dist(b.pos) < 20 || PVector.add(pos, new PVector(0, 20)).dist(b.pos) < 23) {
        enemyHealth -= b.bulletDamage;
        b.bulletHealth -= b.bulletDamage;
      };
    });
    
    push();
    imageMode(CENTER);
    translate(pos.x, pos.y);
    rotate(angle);
    image(enemy, 0, 0);
    pop();
    
    
  }
}
