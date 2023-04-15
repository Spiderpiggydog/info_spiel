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
    bg = loadImage("./media/background/" + title.toLowerCase() + ".png");
    
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
  for(int i = 0; i<=islands.length-1; i++) {
    int x = 100+(i*400)-(int(i>4)*2000);
    int y = 200 + (500*int(i>4));
    if(selected == i) {
      rect(x, y, islands[i].width, islands[i].height);
    }
    image(islands[i], x, y);
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
