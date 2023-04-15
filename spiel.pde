//Variabel Deklaration
import java.util.Map;
import processing.sound.*;
ArrayList<Bullet> bullets;
int currentScene = 2;
PImage[] islands = new PImage[9];

ArrayList<Scene> scenes;

ArrayList<Character> keys;
ArrayList<Integer> keycodes;

HashMap<String,Gun> guns;

int timer = 0;

int framerate = 60;
ArrayList<Bullet> bulletsToRemove;

SoundFile bgmusic;
SoundFile gun;

//Haupt
void setup() {
  frameRate(60);
  bulletsToRemove  = new ArrayList<Bullet>();
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
  
  textSize(50);
  
  bullets = new ArrayList<Bullet>();
  textAlign(CENTER, CENTER);
  fullScreen();
  scenes = new ArrayList<Scene>();
  
  keys = new ArrayList<Character>();
  keycodes = new ArrayList<Integer>();
  
  for(int i = 1; i<=9; i++) {
    islands[i-1] = loadImage("./media/islands/" + i + ".png");
  }
  
  
  //Szenen erstellen
  new Scene("Start") {void run() {start();}};
  new Scene("Select") {void run() {select();}; void key_pressed() {select_pressed();}};
  new Level("level1", 1) {void run() {one();}; void key_pressed() {one_pressed();}};
  
  bgmusic = new SoundFile(this, "./media/music/start.wav");
  gun = new SoundFile(this, "./media/music/gun.wav");
  bgmusic.play();
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
