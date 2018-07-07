
import processing.video.*;

// ================================================================

Capture cam;
// PImage cuttedImg;

// ================================================================

int defaultWidth = 1280; // mac default 1280
int defaultHeight = 960; // mac default 720
float ratio = .5;
int realWidth;
int realHeight;
int imgWidth = 400; 
int imgHeight = 400;

// ================================================================

void canvasAdapt(){
	realWidth = int(defaultWidth * ratio);
	realHeight = int(defaultHeight * ratio);

	println("CAM WIDTH: "+realWidth);
	println("CAM HEIGHT: "+realHeight);

	if(DEBUG) size(realWidth, realHeight * 2);
}

void imageSettings(){
	cam = new Capture(this, realWidth, realHeight);
	cam.start();
};



void captureEvent(Capture video) {  
  cam.read();
}

void imageRender(int x, int y){
  image(cam, x, y);
 // 	cuttedImg = get(stageW, stageH, imgWidth, imgHeight);
	// image(cuttedImg, x, x);
}