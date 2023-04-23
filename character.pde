class Charakter {
  PVector pos, acc, dir, dir_pos;
  int speed = 3, angle = 0;
  PVector bounds;
  int w, h;
  boolean is_jumping;
  Gun currentGun;
  PImage currentSprite;
  
  Charakter(float x, float y, PImage island, PVector island_coords, String _currentGun) {
    acc = new PVector(0, 0);
    pos = new PVector(x, y);
    dir = PVector.fromAngle(angle);
    dir_pos = dir.copy();
    dir_pos.mult(30);
    w = island.width;
    h = island.height / 3;
    bounds = island_coords.copy();
    currentGun = guns.get(_currentGun);
    is_jumping = false;
    currentSprite = characters[character];
  }
  
  void run() {
    if(keyPressed) {
      if(kpressed('a')) {
        pos.x-=speed;
      }
      if(kpressed('d')) pos.x+=speed;
      if(kpressed('w')) pos.y-=speed;
      if(kpressed('s')) pos.y+=speed;
      if(kpressed(' ')) this.jump();
      if(kpressed('e')) currentGun.shoot(this, angle);
    
    if(key == CODED) {
      if(kcpressed(LEFT)) angle++;
      if(kcpressed(RIGHT)) angle--;
    }
    }
    
    
    if(bounds.x > pos.x || bounds.x + w < pos.x ||
       bounds.y > pos.y || bounds.y + h < pos.y) {
        
      } else {
        
      }
    
    noFill();
    rect(bounds.x, bounds.y, w, h);
    fill(255);
    
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
    image(arms[character], 0, 12);
    
    pop();
    imageMode(CORNER);
  }
  
  void jump() {
    /*
      if(!is_jumping) {
        acc.y -= 2;
        is_jumping = true;
      }
      */
  }
}
