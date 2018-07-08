import processing.video.*;

// ================================================================

Capture cam;
// PImage cuttedImg;

// ================================================================

int defaultWidth = 1280; // mac default 1280
int defaultHeight = 960; // mac default 960
float ratio = .5;
int realWidth;
int realHeight;

// ================================================================

void canvasAdapt(){
	realWidth = int(defaultWidth * ratio);
	realHeight = int(defaultHeight * ratio);
	size(realWidth, realHeight);
	if(DEBUG) {
		size(realWidth, realHeight * 2);
		println("CAM WIDTH : " + realWidth);
		println("CAM HEIGHT: " + realHeight);
	}
}

void imageSettings(){
	cam = new Capture(this, realWidth, realHeight);
	cam.start();
	reductionSetup();
};

void captureEvent(Capture video) {  
  cam.read();
}

void imageRender(int x, int y){
  image(cam, x, y);
 	// cuttedImg = get(stageW, stageH, imgWidth, imgHeight);
	// image(cuttedImg, x, x);
	reductionLoop(cam);
}