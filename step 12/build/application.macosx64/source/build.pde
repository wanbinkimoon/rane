int stageW      = 800;
int stageH      = 400;
color bgC       = #512E67;
String dataPATH = "../../data";

// new palette
// #F7BBEC #E38ED2 #DB69A9 #C75696 #9D3978 #512E67
// ================================================================

boolean DEBUG = false;
boolean GRID = true;
boolean MIDI = false;

boolean showHint = false;
// ============================================================

void settings(){ 
	// fullScreen(P3D, 2);
	// fullScreen(P3D, SPAN);
	size(stageW, stageH);
	pixelDensity(displayDensity());	
	canvasAdapt();
}

// ================================================================

void setup() {
	background(bgC);
	midiSetup();
	audioSettings();
	imageSettings();
	
}

// ================================================================
void draw() {
	background(bgC);
	midiMapper();
	audioDataUpdate();
	imageRender(0, 0);

	if(showHint){
		fill(75, 200); noStroke();
  	rect(0, 0, width, 48);

  	fill(#00AEFF);
  	textAlign(LEFT);
  	textSize(16);
  	String helpString = "Q: Quit    P: Save screenshot in ./render folder ";
  	text(helpString, 12, 28);
	}
}

// ================================================================

void keyPressed(){	
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

void screenShot(){
	letsRender = true;
	if (letsRender) {
		letsRender = false;
		save(renderPATH + renderNum + ".png");
		renderNum++;
	}
}

void showHelp(){
	showHint = !showHint;
}