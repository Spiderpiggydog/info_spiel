

class Gun {
  float fireRate, bulletSpeed, damage, bulletSpread, bulletAmount, bulletLife, bulletDamage, bulletHealth;
  float deathFrame;
  PImage image;
  SoundFile sound;
  
  Gun(JSONObject gunValues) {
    fireRate = gunValues.getInt("fireRate");
    bulletSpeed = gunValues.getInt("bulletSpeed");
    bulletDamage = gunValues.getInt("bulletDamage");
    bulletSpread = gunValues.getInt("bulletSpread");
    bulletAmount = gunValues.getInt("bulletAmount");
    bulletLife = gunValues.getInt("bulletLife");
    bulletHealth = gunValues.getInt("bulletHealth");
    
    sound = new SoundFile(spiel.this, "./media/music/" + gunValues.getString("name") + ".wav");
    image = loadImage("./media/weapons/" + gunValues.getString("name") + ".png");
  }
  
  void shoot(Charakter c, int bulletAngle) {
    if(timer == 0) {
      sound.play();
      for(int i = 0; i<=bulletAmount; i++) {
        PVector tempdir = c.dir.copy();
        
        tempdir.x += (random(-bulletSpread, bulletSpread) / 10);
        tempdir.y += (random(-bulletSpread, bulletSpread) / 10);
        new Bullet(c.pos, tempdir, bulletSpeed, bulletLife, bulletAngle, bulletDamage, bulletHealth);
      }
      timer = round(frameRate / fireRate);
    }
  }
  
}

class Bullet {
  PVector pos, dir;
  float speed, deathFrame, bulletDamage, bulletHealth;
  int bulletAngle;
  
  Bullet(PVector _pos, PVector _dir, float speed, float bulletLife, int angle, float damage, float health) {
    pos = _pos.copy();
    
    PVector anglevector = PVector.fromAngle(angle);
    anglevector.x *= 10;
    anglevector.y *= 22;
    
    pos.add(anglevector);
    dir = _dir.copy();
    dir.mult(speed);
    deathFrame = frameCount+bulletLife;;
    bulletAngle = angle;
    bulletDamage = damage;
    bulletHealth = health;
    bullets.add(this);
  }
  
  void run() {
   
   
    push();
    imageMode(CENTER);
    translate(pos.x, pos.y);
    rotate(radians(-bulletAngle));
    
    image(bullet, 0, 0);
    pop();
    
    pos.add(dir);
  }
}
