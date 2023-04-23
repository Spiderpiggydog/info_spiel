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
    
    if(!(this instanceof Level)) {
      bg = loadImage("./media/background/" + title.toLowerCase() + ".png");
      bg.resize(width, height);
    };   
    
    scenes.add(this);
  }
  
  void execute() {
    background(bg);
    run();
  }
}



void start() {
  if(keyPressed) {
    switch(key) {
      case ' ':
        currentScene = 1;
        break;
      case 'e':
        currentScene = 2;
        break;
    }
  }
}

int selected = 0;
void select() {
  for(int i = 0; i<=islands_select.length-1; i++) {
    int x = 100+(i*350)-(int(i>4)*(350*5));
    int y = 200 + (500*int(i>4));
    
    if(selected == i) {
      noFill();
      rect(x, y, islands_select[i].width, islands_select[i].height);
    }
    
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
        currentScene = currentScene+1+selected;
  }
}

void shop() {
  
}

void shop_pressed() {

}
