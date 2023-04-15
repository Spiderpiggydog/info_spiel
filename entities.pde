class Charakter {
  PVector pos, acc, dir, dir_pos;
  int speed = 3, angle = 90;
  PVector bounds;
  int w, h;
  boolean is_jumping;
  Gun currentGun;
  
  Charakter(float x, float y, PImage island, PVector island_coords, String _currentGun) {
    acc = new PVector(0, 0);
    pos = new PVector(x, y);
    dir = new PVector(sin(angle), cos(angle));
    dir_pos = dir.copy();
    dir_pos.mult(30);
    w = island.width;
    h = island.height / 3;
    bounds = island_coords.copy();
    currentGun = guns.get(_currentGun);
    is_jumping = false;
    
  }
  
  void run() {
    if(keyPressed) {
      if(kpressed('a')) pos.x-=speed;
      if(kpressed('d')) pos.x+=speed;
      if(kpressed('w')) pos.y-=speed;
      if(kpressed('s')) pos.y+=speed;
      if(kpressed(' ')) this.jump();
      if(kpressed('e')) currentGun.shoot(this);
    
    if(key == CODED) {
      if(kcpressed(LEFT)) angle++;
      if(kcpressed(RIGHT)) angle--;
    }
    }
    
    
    if(bounds.x > pos.x || bounds.x + w < pos.x ||
       bounds.y > pos.y || bounds.y + h < pos.y) {
        acc.y += 1;
      } else {
        if(is_jumping) {
          acc.y -= acc.y / 1.1;
          is_jumping = false;
        }
        
      }
    
    noFill();
    rect(bounds.x, bounds.y, w, h);
    fill(255);
    
    dir.set(sin(radians(angle)), cos(radians(angle)));
    dir_pos = dir.copy();
    dir_pos.mult(30);
    pos.add(acc);
    line(pos.x, pos.y, pos.x+dir_pos.x, pos.y+dir_pos.y);
    circle(pos.x, pos.y, 30);
  }
  
  void jump() {
      if(!is_jumping) {
        acc.y -= 2;
        is_jumping = true;
      }
  }
}

class Gun {
  float fireRate, bulletSpeed, damage, bulletSpread, bulletAmount, bulletLife;
  float deathFrame;
  
  Gun(JSONObject gunValues) {
    fireRate = gunValues.getInt("fireRate");
    bulletSpeed = gunValues.getInt("bulletSpeed");
    bulletSpread = gunValues.getInt("bulletSpread");
    bulletAmount = gunValues.getInt("bulletAmount");
    bulletLife = gunValues.getInt("bulletLife");
    
  }
  
  void shoot(Charakter c) {
    if(timer == 0) {
      gun.play();
      for(int i = 0; i<=bulletAmount; i++) {
        PVector tempdir = c.dir.copy();
        
        tempdir.x += (random(-bulletSpread, bulletSpread) / 10);
        tempdir.y += (random(-bulletSpread, bulletSpread) / 10);
        new Bullet(c.pos, tempdir, bulletSpeed, bulletLife);
      }
      timer = round(frameRate / fireRate);
    }
  }
  
}

class Bullet {
  PVector pos, dir;
  float speed, deathFrame;
  
  Bullet(PVector _pos, PVector _dir, float speed, float bulletLife) {
    pos = _pos.copy();
    dir = _dir.copy();
    dir.mult(speed);
    deathFrame = frameCount+bulletLife;;
    bullets.add(this);
  }
  
  void run() {
    
    if(deathFrame < frameCount) bulletsToRemove.add(this);
    line(pos.x, pos.y, PVector.add(pos, dir).x, PVector.add(pos, dir).y);
    pos.add(dir);
  }
}
