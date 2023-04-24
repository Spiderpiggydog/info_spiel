//Variabel Deklaration
import java.util.Map;
import processing.sound.*;
ArrayList<Bullet> bullets;

String[] data;
IntList unlockedLevels;

int currentScene = 0;
PImage[] islands = new PImage[10];
PImage[] islands_select = new PImage[10];
PImage selected_image;
boolean dead = false;

PImage arm;
PImage character;
PImage character_walk;

ArrayList<Scene> scenes;
ArrayList<Level> originalLevels;
int nextScene = 0;
int endFrame = 0;

ArrayList<Character> keys;
ArrayList<Integer> keycodes;
PImage bullet;
PImage enemy;

HashMap<String,Gun> guns;

int timer = 0;

int framerate = 60;
ArrayList<Bullet> bulletsToRemove;

SoundFile bgmusic;

//Haupt
void setup() {
  
  prepareExitHandler();
  
  frameRate(60);
  textAlign(CENTER, CENTER);
  size(1500, 1000);
  textSize(50);
  
  data = loadStrings("./data.txt");
  unlockedLevels = new IntList();
  
  originalLevels = new ArrayList<Level>();
  bullets = new ArrayList<Bullet>();
  scenes = new ArrayList<Scene>();
  keys = new ArrayList<Character>();
  keycodes = new ArrayList<Integer>();
  
  enemy = loadImage("./media/sprites/enemy1.png");
  bullet = loadImage("./media/weapons/bullet1.png");
  arm = loadImage("./media/sprites/Arm.png");
  selected_image = loadImage("./media/islands/selector.png");
  character = loadImage("./media/sprites/Player.png");
  character_walk = loadImage("./media/sprites/Playerw.png");
  
  for(String i:data[0].split(",")) {
     unlockedLevels.push(int(i));
  }
  
  
  for(int i = 0; i<=0; i++) {
    
  }
  
  for(int i = 1; i<=10; i++) {
    islands[i-1] = loadImage("./media/islands/island" + i + ".png");
    
    
    islands_select[i-1] = islands[i-1].copy();
    islands_select[i-1].resize(200, 111);
    
    if(!unlockedLevels.hasValue(i-1)) {
      islands_select[i-1].filter(GRAY);
    }
  }
  
  
  
  
  
  //Gewehre importieren als JSON File
  guns = new HashMap<String,Gun>();
  
  JSONArray guns_file = loadJSONArray("./objects/Guns.json");

  for(int i = 0; i<=guns.size(); i++) {
    JSONObject _guns = guns_file.getJSONObject(i);
    Object[] keys = _guns.keys().toArray();
    
    for(int g = 0; i<= keys.length-1; i++) {
      String c = keys[i].toString();
      JSONObject cg = _guns.getJSONObject(c);

      
      guns.put(c, new Gun(cg));
    }
  }
  
  
  
  
  
  
  
  
  //Szenen erstellen
  //1 = Start, 2 = Select, 3 = Loading Screen, weiteren sind die Levels
  new Scene("Start") {void run() {start();}};
  new Scene("Select") {void run() {select();}; void key_pressed() {select_pressed();}};
  /*
  new Scene("loadingScreen", 1) {
    void run() {
      loadingScreen();
  }};
  */
  //new Scene("GameOver", "select.png") {};
  new Level("1", 3, 2);
  
  new Level("2", 3, 5);
  
  
  new Level("3", 4, 6);
  new Level("4", 5, 4);
  
  /*
  new Level("5");
  new Level("6");
  new Level("7");
  new Level("8");
  new Level("9");
  new Level("10");
  */
  //bgmusic = new SoundFile(this, "./media/music/start.wav");
  //bgmusic.play();
}

void changeScene(int _nextScene) {
  currentScene = 2;
  nextScene = _nextScene;
  endFrame = frameCount + 150;
}

void draw() {
  background(200);
  getCurrentScene().execute();
  
  if(timer != 0) {
    timer -= 1;
  }
  //println(timer);
}

void stop() {
  println(1);
}

void keyPressed() {
  if(key == CODED && !keycodes.contains(keyCode)) {
   
    keycodes.add(keyCode);
  }
  if(!keys.contains(key)) {
    keys.add(str(key).toLowerCase().charAt(0));
  }
  
  getCurrentScene().key_pressed();
}

void keyReleased() {
  if(key == CODED && keycodes.contains(keyCode)) keycodes.remove(keycodes.indexOf(keyCode));
  if(keys.contains(key)) keys.remove(keys.indexOf(key));
}

boolean kpressed(char k) {
  return keys.contains(k);
}

boolean kcpressed(int k) {
  return keycodes.contains(k);
}


void reset_levels() {
  if(dead) {
  for(int i = 0; i<=scenes.size()-1; i++) {
    if(scenes.get(i) instanceof Level) {
      scenes.remove(i);
      scenes.set(i, originalLevels.get(i-2));
      };
    }
    dead = false;
  }
}


//
private void prepareExitHandler () {

Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {

public void run () {


}

}));

}
