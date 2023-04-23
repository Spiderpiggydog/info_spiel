class Enemy {
  PVector pos, acc;
  int speed = 1;
  int enemyHealth;
  PVector curIsland;
  float angle;
  int w, h;
  Boolean inAir = false;
  
  Enemy(float x, float y, PVector island, PImage is, int health) {
    pos = new PVector(x, y);
    acc = new PVector(0, 0);
    w = is.width;
    h = is.height;
    curIsland = island.copy();
    enemyHealth = health;
    
  }
  
  void run() {
    
    if(curIsland.x > pos.x || curIsland.x + w < pos.x ||
       curIsland.y > pos.y || curIsland.y + h < pos.y) {
      inAir = true;
      acc.add(-10, -0.5);
      
      
      
      
    } else {
      angle = frameCount%20>10 ?0.1:-0.1;
      pos.x -= speed;
    }
    
    if(inAir) {
      
      pos.add(acc);
      
      acc.y += 2;
      angle = -0.1;
      
      acc = acc.mult(0.8);
    }
    
    bullets.forEach(b -> {
      if(pos.dist(b.pos) < 20) {
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
