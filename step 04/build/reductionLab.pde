int skip;

// ================================================================

void reductionSetup(){
	skip = 30;
}

// ================================================================

// Floyd-Steinberg Dithering
void reductionLoop(PImage img){
	for (int x = 0; x < img.width; x += skip) {
		for (int y = 0; y < img.height; y += skip) {
			int index = x + y * img.width;
			color p = img.pixels[index];
			float r = red(p);
			float g = green(p);
			float b = blue(p);

			int yOffset = DEBUG ? img.height : 0;
			noStroke(); fill(p);
			rect(x, y + yOffset, skip, skip);

			if(DEBUG && index == 0) {
				println("r: " + r);
				println("g: " + g);
				println("b: " + b);
				println("\n");
				noFill(); stroke(255);
				rect(x, y, skip, skip);
			}	
			if(DEBUG && GRID) {
				noFill(); stroke(255);
				rect(x, y, skip, skip);
			}
		}
	}
}