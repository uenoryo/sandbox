import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class csv extends PApplet {

public void setup(){
    background(255);
    
    fill(0);

    String rows[] = loadStrings("business.csv");

    int max = 0;
    String name = "";

    for (int i = 0; i < rows.length; i++) {
        // 1行目はカラム名なので除外
        if (i == 0) {
            continue;
        }

        String cells[] = split(rows[i], ',');
        if (PApplet.parseInt(cells[3]) > max) {
            max = PApplet.parseInt(cells[3]);
            name = cells[2];
        }
    }

    text(name, 20, 20);
}

public void draw() {
    //
}
// void setup(){
//     background(255);
//     size(800, 400);
//     fill(0);

//     String csvDataLine[] = loadStrings("business.csv");

//     //1行目
//     text(csvDataLine[0], 10,20);

//     //2行目
//     text(csvDataLine[1], 10,40);

//     //3行目
//     text(csvDataLine[2], 10,60);
// }

// void draw(){
//     //
// }
// void setup(){
//     background(255);
//     size(800, 800);
//     fill(0);

//     String rows[] = loadStrings("business.csv");

//     for (int i = 0; i < rows.length; i++) {
//         text(rows[i], 20, i*20 + 20);
//     }
// }

// void draw(){
//     //
// }
// void setup(){
//     background(255);
//     size(800, 800);
//     fill(0);

//     String rows[] = loadStrings("business.csv");

//     for (int i = 0; i < rows.length; i++) {
//         String cells[] = split(rows[i], ',');

//         for (int j = 0; j < cells.length; j++) {
//             text(cells[j], j*100, i*20 + 20);
//         }
//     }
// }

// void draw() {
//     //
// }
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "csv" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
