int stageW      = 800;
int stageH      = 400;
color bgC       = #2F2F2F;
String dataPATH = "../../data";

// ================================================================

void settings(){ 
	// fullScreen(P3D, 2);
	// fullScreen(P3D, SPAN);
	size(stageW, stageH);
	pixelDensity(displayDensity());	
}

// ================================================================

void setup() {
	background(bgC);

	// midiSetup();
	audioSettings();
	imageSettings();
}

// ================================================================
void draw() {
	background(bgC);
	audioDataUpdate();
	imageRender(0, 0);
}

// ================================================================

void keyPressed(){	
	switch (key) {
		case 'q':
			exit();
		case 'p':
			screenShot();
		break;
	}
}

// ================================================================

boolean letsRender = false;
int     renderNum  = 0;
String  renderPATH = "../render/";

// ================================================================

void screenShot(){
	letsRender = true;
	if (letsRender) {
		letsRender = false;
		save(renderPATH + renderNum + ".png");
		renderNum++;
	}
}