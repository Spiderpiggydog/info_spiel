class Charakter {
  PVector pos, acc, dir, dir_pos;
  int speed = 3, angle = 0;
  PVector bounds, boundsNext;
  int w, h;
  boolean canJump;
  Gun currentGun;
  PVector prevPos;
  PImage currentSprite;
  
  Charakter(float x, float y, PImage island, PVector[] island_coords, String _currentGun) {
    acc = new PVector(0, 0);
    pos = new PVector(x, y);
    dir = PVector.fromAngle(angle);
    dir_pos = dir.copy();
    dir_pos.mult(30);
    w = island.width;
    h = island.height / 3;
    
    
    bounds = island_coords[1];
    boundsNext = island_coords[2];
    
    
    currentGun = guns.get(_currentGun);
    canJump = false;
    currentSprite = character;
  }
  
  void run() {
    
    prevPos = pos.copy();
    if(keyPressed) {
      if(kpressed('a')) {
        pos.x-=speed;
      }
      if(kpressed('d')) pos.x+=speed;
      if(kpressed('w')) pos.y-=speed;
      if(kpressed('s')) pos.y+=speed;
      if(kpressed('e')) currentGun.shoot(this, angle);
      
      if(kcpressed(LEFT)) angle+=2;
      if(kcpressed(RIGHT)) angle-=2;
    
    }
    
    if((prevPos.x != pos.x || prevPos.y != pos.y) && frameCount % 10 < 5) {
      currentSprite = character_walk;
      
    } else currentSprite = character;
    
    if(bounds.x > pos.x || bounds.x + w < pos.x ||
       bounds.y > pos.y+currentSprite.height/2 || bounds.y + h < pos.y+currentSprite.height/2) {
        acc.y += 1;
        
      } else if(!canJump){
        acc.y = 0;
      } else if(canJump) {
        if(keyPressed && key == ' ') this.jump();
      }
      
    if(!(boundsNext.x > pos.x || boundsNext.x + w < pos.x ||
       boundsNext.y > pos.y+currentSprite.height/2 || boundsNext.y + h < pos.y+currentSprite.height/2)) {
      canJump = false;
      acc.y = 0;
      acc.x = 0;
    }
    
    
    
    dir = PVector.fromAngle(radians(-angle));
    dir_pos = dir.copy();
    dir_pos.mult(30);
    pos.add(acc);
    line(pos.x, pos.y, pos.x+dir_pos.x, pos.y+dir_pos.y);
    imageMode(CENTER);
    image(currentSprite, pos.x, pos.y);
    
    push();
    translate(pos.x-12, pos.y+2);
    
    rotate(radians(-angle));
    image(currentGun.image, 20, 20);
    image(arm, 0, 12);
    pop();
    imageMode(CORNER);
    
    
  }
  
  void jump() {
    if(canJump) {
      acc.add(3, -5);
    }
  }
}
