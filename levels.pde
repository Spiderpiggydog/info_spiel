class Level extends Scene {
  void run() {};
  void key_pressed() {};
  Charakter player;
  int y;
  PImage island;
  
  ArrayList<Enemy> enemies;
  PVector[] islands_coords;
  
  Level(String _title, int _island) {
    super(_title);
    island = islands[_island-1];
    
    
    islands_coords = new PVector[3];
    
    
    
    y = 500;
    
    for(int i = 0; i<=2; i++) {
      islands_coords[i] = new PVector(20 + i*(island.width+400), y);
    }
    
    enemies = new ArrayList<Enemy>();
    
    for(int i = 0; i<=10; i++) {
      enemies.add(new Enemy(islands_coords[2].x+100, islands_coords[2].y, islands_coords[2], island, 15));
    }
    
    player = new Charakter(islands_coords[1].x, 500, island, islands_coords[1], "shotgun");
    
    
    bg = loadImage("./media/background/hintergrund" + title.toLowerCase() + ".png");
    
  }
  
  void execute() {
    background(bg);
    
    
    for(PVector v:islands_coords) {
      image(island, v.x, v.y);
    }
    
    enemies.forEach(e -> e.run());
    
    
    run();
    player.run();
    bullets.forEach(x -> x.run());
    
    bullets.removeIf(b -> {return b.deathFrame < frameCount || b.bulletHealth <= 0;});
    enemies.removeIf(e -> {return e.enemyHealth <= 0;});
  }
}
