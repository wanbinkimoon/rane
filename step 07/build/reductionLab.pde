int skip;
color simpleColor;
// ================================================================

// Called in liveImageLab
void reductionSetup(){
	skip = 8;
}

// ================================================================

// Floyd-Steinberg Dithering
// Called in liveImageLab
void reductionLoop(PImage img){
	if(!DEBUG) background(bgC);

	for (int x = 0; x < img.width; x += skip) {
		for (int y = 0; y < img.height; y += skip) {
			int index = x + y * img.width;
			color p = img.pixels[index];

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

void colorReduciton(color c){
	
	int factor = 4;

	float r = red(c);
	int simpleR = round(factor * r / 255) * (255 / factor);
	float g = green(c);
	int simpleG = round(factor * g / 255) * (255 / factor);
	float b = blue(c);
	int simpleB = round(factor * b / 255) * (255 / factor);
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