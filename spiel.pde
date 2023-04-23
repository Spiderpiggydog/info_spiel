//Variabel Deklaration
import java.util.Map;
import processing.sound.*;
ArrayList<Bullet> bullets;

String[] data;
IntList unlockedLevels;

int currentScene = 0;
PImage[] islands = new PImage[10];
PImage[] islands_select = new PImage[10];

PImage[] characters;
PImage[] arms;
int character = 0;

ArrayList<Scene> scenes;

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
  
  frameRate(60);
  textAlign(CENTER, CENTER);
  size(1500, 1000);
  textSize(50);
  
  data = loadStrings("./data.txt");
  unlockedLevels = new IntList();
  
  
  characters = new PImage[5];
  arms = new PImage[5];
  bullets = new ArrayList<Bullet>();
  scenes = new ArrayList<Scene>();
  keys = new ArrayList<Character>();
  keycodes = new ArrayList<Integer>();
  
  enemy = loadImage("./media/sprites/enemy1.png");
  bullet = loadImage("./media/weapons/bullet1.png");
  arms[0] = loadImage("./media/sprites/Arm.png");
  
  
  
  for(String i:data[0].split(",")) {
     unlockedLevels.push(int(i));
  }
  
  
  for(int i = 0; i<=0; i++) {
    characters[i] = loadImage("./media/sprites/Player" + (i+1) + ".png");
  }
  
  for(int i = 1; i<=10; i++) {
    islands[i-1] = loadImage("./media/islands/island" + i + ".png");
    
    
    islands_select[i-1] = islands[i-1].copy();
    islands_select[i-1].resize(285, 157);
    
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
  new Scene("Start") {void run() {start();}};
  new Scene("Select") {void run() {select();}; void key_pressed() {select_pressed();}};
  new Level("1", 1);
  new Level("2", 2);
  
  //bgmusic = new SoundFile(this, "./media/music/start.wav");
  //bgmusic.play();
}



void draw() {
  
  background(200);
  getCurrentScene().execute();
  
  if(timer != 0) {
    timer -= 1;
  }
  //println(timer);
}

void keyPressed() {
  if(key == CODED && !keycodes.contains(keyCode)) {
    keycodes.add(keyCode);
  } else if(!keys.contains(key)) {
    keys.add(str(key).toLowerCase().charAt(0));
  }
  
  getCurrentScene().key_pressed();
}

void keyReleased() {
  if(key == CODED && keycodes.contains(keyCode)) keycodes.remove(keycodes.indexOf(keyCode));
  else if(keys.contains(key)) keys.remove(keys.indexOf(key));
}

boolean kpressed(char k) {
  return keys.contains(k);
}

boolean kcpressed(int k) {
  return keycodes.contains(k);
}
