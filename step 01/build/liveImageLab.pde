import processing.video.*;

// ================================================================

Capture cam;

// ================================================================

int imgWidth = 400;
int imgHeight = 400;
// ================================================================

void imageSettings(){
	cam = new Capture(this, imgWidth, imgHeight);
	cam.start();
};

void imageRender(int x, int y){
  if (cam.available())
    cam.read();

  image(cam,x , y);
}