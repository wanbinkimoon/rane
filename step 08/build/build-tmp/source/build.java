import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 
import ddf.minim.analysis.*; 
import processing.video.*; 
import themidibus.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

int stageW      = 800;
int stageH      = 400;
int bgC       = 0xffFF9071;
String dataPATH = "../../data";

// ================================================================

boolean DEBUG = true;
boolean GRID = true;
boolean MIDI = false;

boolean showHint = false;
// ================================================================

public void settings(){ 
	// fullScreen(P3D, 2);
	// fullScreen(P3D, SPAN);
	size(stageW, stageH);
	pixelDensity(displayDensity());	
	canvasAdapt();
}

// ================================================================

public void setup() {
	background(bgC);
	midiSetup();
	// audioSettings();
	imageSettings();
	
}

// ================================================================
public void draw() {
	background(bgC);
	midiMapper();
	// audioDataUpdate();
	imageRender(0, 0);

	if(showHint){
		fill(75, 200); noStroke();
  	rect(0, 0, width, 48);

  	fill(0xff00AEFF);
  	textAlign(LEFT);
  	textSize(16);
  	String helpString = "Q: Quit    P: Save screenshot in ./render folder ";
  	text(helpString, 12, 28);
	}
}

// ================================================================

public void keyPressed(){	
	switch (key) {
		case 'q':
			exit();
			break;
		case 'p':
			screenShot();
			break;
		case 'h':
			showHelp();
			break;
	}
}

// ================================================================

boolean letsRender = false;
int     renderNum  = 0;
String  renderPATH = "../render/";

// ================================================================

public void screenShot(){
	letsRender = true;
	if (letsRender) {
		letsRender = false;
		save(renderPATH + renderNum + ".png");
		renderNum++;
	}
}

public void showHelp(){
	showHint = !showHint;
}




// ================================================================

Minim minim;
AudioInput audio;
FFT audioFFT;

// ================================================================

int audioRange  = 12;
int audioMax = 100;

float audioAmp = 258.0f;
float audioIndex = 0.015f;
float audioIndexAmp = audioIndex;
float audioIndexStep = 0.692f;

float[] audioData = new float[audioRange];

// ================================================================

public void audioSettings(){
  minim = new Minim(this);
  audio = minim.getLineIn(Minim.STEREO);

  audioFFT = new FFT(audio.bufferSize(), audio.sampleRate());
  audioFFT.linAverages(audioRange);

  audioFFT.window(FFT.NONE);
  // audioFFT.window(FFT.BARTLETT);
  // audioFFT.window(FFT.BARTLETTHANN);
  // audioFFT.window(FFT.BLACKMAN);
  // audioFFT.window(FFT.COSINE);
  // audioFFT.window(FFT.GAUSS);
  // audioFFT.window(FFT.HAMMING);
  // audioFFT.window(FFT.HANN);
  // audioFFT.window(FFT.LANCZOS);
  // audioFFT.window(FFT.TRIANGULAR);
}

// ================================================================

public void audioDataUpdate(){
  audioFFT.forward(audio.mix);
  updateAudio();
}

// ================================================================

  public void updateAudio(){
    for (int i = 0; i < audioRange; ++i) {
      float indexAvg = (audioFFT.getAvg(i) * audioAmp) * audioIndexAmp;
      float indexCon = constrain(indexAvg, audioMax, audioMax * 2);
      
      if(indexAvg > audioMax) audioData[i] = indexCon;
      else audioData[i] = 100;

      audioData[i] = audioData[i] / 100;
      audioIndexAmp += audioIndexStep;
    }

    audioIndexAmp = audioIndex;
  }

  // ================================================================
  
  public void audioMidiValueUpdate(){
    audioIndex = map(knob[6], 0, 100, 0.0f, 0.1f);
    audioIndexStep = map(knob[7], 0, 100, 0.0f, 0.1f);
  }
boolean CIRCLE = false;
boolean RECTANGLES = false;
boolean TRIANGLES = true;

// ================================================================

// Called in reductionLab
public void effecRender(int x, int y, int side, int c, int yOffset){
	if(CIRCLE)
		renderDots(x, y, side, c, yOffset);
	if(RECTANGLES)
		renderRects(x, y, side, c, yOffset);
	if(TRIANGLES)
		renderTriangles(x, y, side, c, yOffset);
}

// ================================================================

public void renderDots(int x, int y, int side, int c, int yOffset){
	int realColor = 0xffA73CCB;
	noStroke(); fill(realColor);


	// shaping 
	int padding = (side / 16);
	int realX = x + (side / 2);
	int realY = y + (side / 2);

	float b = brightness(c);
	int sideElab = PApplet.parseInt(map(b, 0 , 255, side, 0));
	int realSide = sideElab - padding;
	// rect(realX, realY + yOffset, realSide, realSide);
	ellipse(realX, realY + yOffset, realSide, realSide);
}

// ================================================================

public void renderRects(int x, int y, int side, int c, int yOffset){
	int realColor = 0xffA73CCB;
	noStroke(); fill(realColor);


	// shaping 
	int padding = (side / 16);
	int realX = x + (padding / 2);
	int realY = y + (padding / 2) + yOffset;

	float b = brightness(c);
	int sideElab = PApplet.parseInt(map(b, 0 , 255, side, 0));
	int realSide = sideElab - padding;
	rect(realX, realY, realSide, realSide);
}

// ================================================================

public void renderTriangles(int x, int y, int side, int c, int yOffset){
	int realColor = 0xffA73CCB;
	noStroke(); fill(realColor);

	// shaping 
	int padding = (side / 16);
	int realX = x + (padding / 2);
	int realY = y + (padding / 2);

	float b = brightness(c);
	int sideLab = PApplet.parseInt(map(b, 0 , 255, side, 0));

	int realSide = sideLab - padding;
	int x1triangle = realX; 
	int y1triangle = realY + realSide; 
	int x2triangle = realX; 
	int y2triangle = realY; 
	int x3triangle = realX + realSide; 
	int y3triangle = realY + realSide; 

	triangle(
		x1triangle,
		y1triangle + yOffset, 
		x2triangle, 
		y2triangle + yOffset, 
		x3triangle, 
		y3triangle + yOffset);
}


// ================================================================

Capture cam;
// PImage cuttedImg;

// ================================================================

int defaultWidth = 1280; // mac default 1280
int defaultHeight = 960; // mac default 960
float ratio = .5f;
int realWidth;
int realHeight;

// ================================================================

public void canvasAdapt(){
	realWidth = PApplet.parseInt(defaultWidth * ratio);
	realHeight = PApplet.parseInt(defaultHeight * ratio);
	size(realWidth, realHeight);
	if(DEBUG) {
		size(realWidth, realHeight * 2);
		println("CAM WIDTH : " + realWidth);
		println("CAM HEIGHT: " + realHeight);
	}
}

public void imageSettings(){
	cam = new Capture(this, realWidth, realHeight);
	cam.start();
	reductionSetup();
};

public void captureEvent(Capture video) {  
  cam.read();
}

public void imageRender(int x, int y){
  image(cam, x, y);
 	// cuttedImg = get(stageW, stageH, imgWidth, imgHeight);
	// image(cuttedImg, x, x);
	reductionLoop(cam);
}
 

// ================================================================

MidiBus myBus; 

// ================================================================

public void controllerChange(int channel, int number, int value) {  
	midiUpdate(channel, number, value);

	if(DEBUG && MIDI) {
  	// Receive a controllerChange
	  println();
	  println("Controller Change:");
	  println("--------");
	  println("Channel:" + channel);
	  println("Number:" + number);
	  println("Value:" + value);
	}
}

// ================================================================


int knobNumb = 16;
int[] knob = new int[knobNumb];
String knobTable;

// ================================================================

public void midiSetup(){
  MidiBus.list(); 
  myBus = new MidiBus(this, 0, 1);
}

public void midiUpdate(int channel, int number, int value){
	if(number == 21) knob[0] = (int)map(value, 0, 127, 0, 100);
	if(number == 22) knob[1] = (int)map(value, 0, 127, 0, 100);
	if(number == 23) knob[2] = (int)map(value, 0, 127, 0, 100);
	if(number == 24) knob[3] = (int)map(value, 0, 127, 0, 100);
	if(number == 25) knob[4] = (int)map(value, 0, 127, 0, 100);
	if(number == 26) knob[5] = (int)map(value, 0, 127, 0, 100);
	if(number == 27) knob[6] = (int)map(value, 0, 127, 0, 100);
	if(number == 28) knob[7] = (int)map(value, 0, 127, 0, 100);
	if(number == 41) knob[8] = (int)map(value, 0, 127, 0, 100);
	if(number == 42) knob[9] = (int)map(value, 0, 127, 0, 100);
	if(number == 43) knob[10] = (int)map(value, 0, 127, 0, 100);
	if(number == 44) knob[11] = (int)map(value, 0, 127, 0, 100);
	if(number == 45) knob[12] = (int)map(value, 0, 127, 0, 100);
	if(number == 46) knob[13] = (int)map(value, 0, 127, 0, 100);
	if(number == 47) knob[14] = (int)map(value, 0, 127, 0, 100);
	if(number == 48) knob[15] = (int)map(value, 0, 127, 0, 100);
}

public void midiMonitor(){
	knobTable = "\n\n_________________________________________________________________________________________________________________________________\n|  001  |  002  |  003  |  004  |  005  |  006  |  007  |  008  |  009  |  010  |  011  |  012  |  013  |  014  |  015  |  016  |\n|  "+ String.format("%03d", knob[0]) +"  |  "+ String.format("%03d", knob[1]) +"  |  "+ String.format("%03d", knob[2]) +"  |  "+ String.format("%03d", knob[3]) +"  |  "+ String.format("%03d", knob[4]) +"  |  "+ String.format("%03d", knob[5]) +"  |  "+ String.format("%03d", knob[6]) +"  |  "+ String.format("%03d", knob[7]) +"  |  "+ String.format("%03d", knob[8]) +"  |  "+ String.format("%03d", knob[9]) +"  |  "+ String.format("%03d", knob[10]) +"  |  "+ String.format("%03d", knob[11]) +"  |  "+ String.format("%03d", knob[12]) +"  |  "+ String.format("%03d", knob[13]) +"  |  "+ String.format("%03d", knob[14]) +"  |  "+ String.format("%03d", knob[15]) +"  |\n_________________________________________________________________________________________________________________________________";
	println(knobTable);
}

// ================================================================

int padNumb = 8;
boolean[] pad = new boolean[padNumb];

// ================================================================

public void noteOn(int channel, int number, int value) {
	padSwitch(channel, number, value);

  // Receive a controllerChange
  // println();
  // println("Controller Change:");
  // println("--------");
  // println("Channel:" + channel);
  // println("Number:" + number);
  // println("Value:" + value);
}

public void padSwitch(int channel, int number, int value){

	if(arrow[0]) {
		for (int i = 0; i < padNumb; ++i) {
				pad[i] = false;
		}	
	}
	
	if(number ==  9) pad[0] = !pad[0];
	if(number == 10) pad[1] = !pad[1];
	if(number == 11) pad[2] = !pad[2];
	if(number == 12) pad[3] = !pad[3];
	if(number == 25) pad[4] = !pad[4];
	if(number == 26) pad[5] = !pad[5];
	if(number == 27) pad[6] = !pad[6];
	if(number == 28) pad[7] = !pad[7];

	// padMonitor();
}

public void padMonitor(){
	print("  0: " + pad[0]);
	print("  1: " + pad[1]);
	print("  2: " + pad[2]);
	print("  3: " + pad[3]);
	print("  4: " + pad[4]);
	print("  5: " + pad[5]);
	print("  6: " + pad[6]);
	print("  7: " + pad[7] + "\n");
	println();
	println("____________________\n");
	println();
}

// ================================================================

int arrowNumb = 4;
boolean[] arrow = new boolean[arrowNumb];

// ================================================================

public void rawMidi(byte[] data) {
	int number = (int)(data[1] & 0xFF);
	int value = (int)(data[2] & 0xFF);

	arrowSwitch(number);

  // Receive some raw data
  // data[0] will be the status byte
  // data[1] and data[2] will contain the parameter of the message (e.g. pitch and volume for noteOn noteOff)
 //  println();
 //  println("Raw Midi Data:");
 //  println("--------");
 //  println("Status Byte/MIDI Command:"+(int)(data[0] & 0xFF));
	// println("Number: " + number);	
	// println("Value: " + value);	
}


public void arrowSwitch(int number){
	if(number == 114) arrow[0] = !arrow[0];
	if(number == 115) arrow[1] = !arrow[1];
	if(number == 116) arrow[2] = !arrow[2];
	if(number == 117) arrow[3] = !arrow[3];

	arrowMonitor();
}

public void arrowMonitor(){
	print("  0: " + arrow[0]);
	print("  1: " + arrow[1]);
	print("  2: " + arrow[2]);
	print("  3: " + arrow[3]);
	println();
	println("____________________\n");
	println();
}
public void midiMapper(){
	skip = PApplet.parseInt(map(knob[0], 0, 100, 2, 100));
	reductionFactor = PApplet.parseInt(map(knob[1], 0, 100, 4, 100));

	if(pad[0]){
		CIRCLE = true;
		RECTANGLES = false;
		TRIANGLES = false;
	}	
	if(pad[1]){
		CIRCLE = false;
		RECTANGLES = true;
		TRIANGLES = false;
	}	
	if(pad[2]){
		CIRCLE = false;
		RECTANGLES = false;
		TRIANGLES = true;
	}
}

float xoff = 0.0f;
float n;
float noiseSpeed = .01f;

// ================================================================

public void noiseUpdate(){
 	xoff += noiseSpeed;
  n = noise(xoff);
}
int skip;
int simpleColor;
int reductionFactor;

// ================================================================

// Called in liveImageLab
public void reductionSetup(){
	skip = 8;
}

// ================================================================

// Floyd-Steinberg Dithering
// Called in liveImageLab
public void reductionLoop(PImage img){
	if(!DEBUG) background(bgC);

	for (int x = 0; x < img.width; x += skip) {
		for (int y = 0; y < img.height; y += skip) {
			int index = x + y * img.width;
			int p = img.pixels[index];

			colorReduciton(p);
			int yOffset = DEBUG ? img.height : 0;
			effecRender(x, y, skip, simpleColor, yOffset);

			if(DEBUG && GRID) {
				noFill(); stroke(255);
				rect(x, y, skip, skip);
				if(false) {
					noStroke(); fill(255);
					int gridIndex = (x / skip) + ((img.width / skip) * (y / skip));
					// the magic number in the y operator is the fontSize divdedby 2
					text(gridIndex, x + 4, y + 4 + (skip / 2)); 
				}
			}			
		}
	}
}

// ================================================================

public void colorReduciton(int c){
	reductionFactor = 4;

	float r = red(c);
	int simpleR = round(reductionFactor * r / 255) * (255 / reductionFactor);
	float g = green(c);
	int simpleG = round(reductionFactor * g / 255) * (255 / reductionFactor);
	float b = blue(c);
	int simpleB = round(reductionFactor * b / 255) * (255 / reductionFactor);
	simpleColor = color(simpleR, simpleG, simpleB);
	
	if(DEBUG && false) {
		println("r: " + r);
		println("simpleR: " + simpleR);
		println("g: " + g);
		println("simpleG: " + simpleG);
		println("b: " + b);
		println("simpleB: " + simpleB);
		println("\n");
	}
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
