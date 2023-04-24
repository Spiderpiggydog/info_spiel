class Level extends Scene {
  void run() {};
  void key_pressed() {};
  Charakter player;
  int y;
  PImage island;
  
  ArrayList<Enemy> enemies;
  PVector[] islands_coords;
  PVector[] start_positions;
  int rounds = 4;
  int currentRound = 0;
  int enemyAmount, enemyHealth, enemiesKilled;
  
  Level(String _title, int enemyAmount, int enemyHealth) {
    super(_title);
    
    //Holt der Insel Grafik
    island = islands[int(_title)-1];
    
    //Initialisierungen
    islands_coords = new PVector[3];
    start_positions = new PVector[3];
    enemies = new ArrayList<Enemy>();
    
    //Setzt die Höhe für die Inseln
    y = 500;
    
    //Setzt die Inseln auseinander
    for(int i = 0; i<=2; i++) {
      islands_coords[i] = new PVector(10 + i*(island.width+350), y);
      start_positions[i] = islands_coords[i].copy(); //Kopiert die Koordinaten sodass sie später genutzt werden können
    }
    
    for(int i = 0; i<=enemyAmount; i++) {
      enemies.add(new Enemy(islands_coords[2].x+(i*20) + random(-5, 200), islands_coords[2].y, islands_coords, island, enemyHealth));
    }
    
    
    
    //Initialisiert ein neues Charakter
    player = new Charakter(islands_coords[1].x, 500, island, islands_coords, "shotgun");
    
    //Ladet den Hintergrund
    bg = loadImage("./media/background/hintergrund" + title.toLowerCase() + ".png");
    bg.resize(width, height);
    
    scenes.add(this);
    originalLevels.add(this.copy());
  }
  
  
  //andere Initialisierer für den Kopie Funktion, sodass es sich nicht zur Scenes ArrayList hinzufügt
  Level(String _title, int enemyAmount, int enemyHealth, int nothing) {
    super(_title);
    
    //Holt der Insel Grafik
    island = islands[int(_title)-1];
    
    //Initialisierungen
    islands_coords = new PVector[3];
    start_positions = new PVector[3];
    enemies = new ArrayList<Enemy>();
    
    //Setzt die Höhe für die Inseln
    y = 500;
    
    //Setzt die Inseln auseinander
    for(int i = 0; i<=2; i++) {
      islands_coords[i] = new PVector(10 + i*(island.width+350), y);
      start_positions[i] = islands_coords[i].copy(); //Kopiert die Koordinaten sodass sie später genutzt werden können
    }
    
    for(int i = 0; i<=enemyAmount; i++) {
      enemies.add(new Enemy(islands_coords[2].x+(i*20) + random(-5, 200), islands_coords[2].y, islands_coords, island, enemyHealth));
    }
    
    
    
    //Initialisiert ein neues Charakter
    player = new Charakter(islands_coords[1].x, 500, island, islands_coords, "shotgun");
    
    //Ladet den Hintergrund
    bg = loadImage("./media/background/hintergrund" + title.toLowerCase() + ".png");
    bg.resize(width, height);
  }
  
  Level copy() {
    return new Level(title + "", enemyAmount + 0, enemies.get(0).enemyHealth + 0, 0);
  }
  
  boolean execute() {
    background(bg);
    text(enemiesKilled + "/" + enemyAmount*currentRound, 30, 30);
    
    if(currentRound > rounds) {
      imageMode(CENTER);
      
      text("Drücke S für den nächsten Level", width/2, height/2-200);
      text("Level geschafft!", width/2, height/2);
      text("Drücke T für den Start Screen", width/2, height/2+200);
      
      
      if(!unlockedLevels.hasValue(currentScene + 1)) {
        unlockedLevels.push(currentScene+1);
      }
      
      if(keyPressed) {
        if(key == 's') currentScene++;
        if(key == 't') currentScene = 0;
      }
      
      return false;
    }
    
    
    if(dead) {
      imageMode(CENTER);
      text("Drücke S für den Level Auswahl", width/2, height/2-200);
      text("F fers Stärbu und HAHA", width/2, height/2);
      text("Drücke T für den Start Screen", width/2, height/2+200);
      
      if(keyPressed) {
        if(key == 's') {currentScene = 1;}
        if(key == 't') {currentScene = 0;}
        
      }
      return false;
    }
    
    if(player.pos.y+player.currentSprite.height/2 > height) dead = true;
    
    
    enemies.forEach(e -> {
      if(e.pos.dist(player.pos) < 50) {
        dead = true;
      }
    });
    
    
    
    //Zeigt die Inseln
    for(PVector v:islands_coords) {
      image(island, v.x, v.y);
      
      //Schaut ob der Spieler alle Gegner getötet hat und schiebt die Inseln nach vorne
      if(enemies.size() == 0) {
        v.x -= 2;
      }
      
      //Falls die Insel ausserhalb der Bildschirm ist auf der Linke seite, wird sie zu die andere Seite gesetzt
      if(v.x+island.width < 0) {
        v.x = width+110;
      }
    }
    
    //Wenn alle Gegner eliminiert sind, darf den Spieler zu der nächster Insel springen
    if(enemies.size() == 0) {
      player.canJump = true;
      imageMode(CENTER);
      text("Runde: " + currentRound + "/" + rounds, width/2, 100);
    }
    
    //Falls die mittlere Insel am Originalposition von der erste ist und alle Gegner eliminiert worden sind
    //werden die Inseln zu ihrer original Positionen gesetzt und eine Anzahl Gegner werden erneut gemacht
    //Soeben werden die Kollision für den Spieler erneut gesetzt
    if(islands_coords[1].x <= start_positions[0].x && enemies.size() == 0) {
      currentRound++;
      
      for(int i = 0; i<=2; i++) {
      islands_coords[i] = start_positions[i].copy();
      }
      
      player.canJump = false;
      player.bounds = islands_coords[1];
      player.boundsNext = islands_coords[2];
      
      for(int i = 0; i<=enemyAmount+(currentRound*2); i++) {
      enemies.add(new Enemy(islands_coords[2].x+(i*20) + random(-5, 200), islands_coords[2].y, islands_coords, island, 2));
      }
      
      
    }
    
    
    
    
    //Rennen das Charakter, Gegner und Schüsse
    player.run();
    enemies.forEach(e -> e.run());
    bullets.forEach(x -> x.run());
    
    
    //Entfernen ungebrauchte Gegenstände
    bullets.removeIf(b -> {return b.deathFrame < frameCount || b.bulletHealth <= 0;});
    enemies.removeIf(e -> {return e.enemyHealth <= 0 || e.pos.y > height;});
    
    return false;
  }
}
