Scene getLastScene() {
  return scenes.get(scenes.size()-1);
}

Scene getCurrentScene() {
  return scenes.get(currentScene);
}


class Scene{
  void run() {};
  void key_pressed() {};
  String title;
  PImage bg;
  
  Scene(String _title) {
    title = _title;
    
    
    //Schaut ob der momentane Szene eigentlich ein Level ist, falls es nicht ist
    //Setzt es den Hintergrund
    if(!(this instanceof Level)) {
      bg = loadImage("./media/background/" + title.toLowerCase() + ".png");
      bg.resize(width, height);
      scenes.add(this);
    };
    
    
  }
  
  Scene(String _title, int nothing) {
    title = _title;
    
    scenes.add(this);
  }
  
  Scene(String _title, String _bg) {
    title = _title;
    
    bg = loadImage("./media/backgrounds/" + bg);
    bg.resize(width, height);
    
    scenes.add(this);
  }
  
  boolean execute() {
    if(bg != null) background(bg);
    run();
    return false;
  }
}


//Start Szene
void start() {
  reset_levels();
  if(keyPressed) {
    switch(key) {
      case ENTER:
        currentScene = 1;
        break;
      case 'e':
        currentScene = 2;
        break;
    }
  }
}

int selected = 0;

//Level Auswahl Szene
void select() {
  reset_levels();
  //Setzt die 10 Inseln an den richtigen Platz mit Platz dazwischen
  for(int i = 0; i<=islands_select.length-1; i++) {
    //startPos + (i * Platz inzwischen)
    
    //Nutzt Mathe um etwas herauszufinden
    int x = 50+(i*300)-(int(i>4)*(300*5));
    int y = 200 + (500*int(i>4));
    
    if(selected == i) {
      imageMode(CENTER);
      image(selected_image, x+islands_select[i].width/2, y+islands_select[i].height/2);
    }
    
    imageMode(CORNER);
    image(islands_select[i], x, y);
  }
}

void select_pressed() {
  if(key == CODED) {
    switch(keyCode) {
      case LEFT:
        selected-= int(boolean(selected))*1;
        break;
      case RIGHT:
        selected = (selected+1) % islands.length;
        break;
    }
  }
  
  if(key == ENTER) {
        if(unlockedLevels.hasValue(selected)) {
        currentScene = currentScene+1+selected;
        }
  }
}

void loadingScreen() {
  background(scenes.get(nextScene).bg);
  
  
  
  if(frameCount > endFrame) {
    currentScene = nextScene;
  }
  
  rect(0, height-(frameCount-endFrame), width, height);
}

void gameOver() {
  
}

void gameOver_pressed() {
  
}
