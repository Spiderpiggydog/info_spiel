class Level extends Scene {
  void run() {};
  void key_pressed() {};
  Charakter player;
  int y;
  PImage island;
  
  PVector[] islands;
  
  Level(String _title, int _island) {
    super(_title);
    
    islands = new PVector[3];
    
    
    
    y = 500;
    
    for(int i = 0; i<=2; i++) {
      islands[i] = new PVector(300 + i*400, y);
    }
    island = loadImage("./media/islands/" + _island + ".png");

    player = new Charakter(islands[1].x, 500, island, islands[1], "ar");
    
    bg = loadImage("./media/background/" + title.toLowerCase() + ".png");
    
    scenes.add(this);
  }
  
  void execute() {
    background(bg);
    
    for(PVector v:islands) {
      image(island, v.x, v.y);
    }
    
    
    run();
    player.run();
    bullets.forEach(x -> x.run());
    
    bullets.removeAll(bulletsToRemove);
    bulletsToRemove.clear();
  }
}

void one() {
  
}

void one_pressed() {
}
