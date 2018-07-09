

// ================================================================

// Called in reductionLab
void effecRender(int x, int y, int side, color c, int yOffset){
	color realColor = #A73CCB;
	float monochrome = 255 - brightness(c);
	float alpha = map(monochrome, 0, 255, 50, 255);
	noStroke(); fill(realColor, monochrome);

	if(brightness(c) < 20)
		dotGrid(x, y, side, c, yOffset, audioData[3]);
	if(brightness(c) >= 20 && brightness(c) < 80)
		dotGrid(x, y, side, c, yOffset, audioData[9]);
	if(brightness(c) >= 80 && brightness(c) < 120)
		dotGrid(x, y, side, c, yOffset, audioData[10]);
	if(brightness(c) >= 120)	
		dotGrid(x, y, side, c, yOffset, audioData[11]);
}

// ================================================================

void dotGrid(int x, int y, int side, color c, int yOffset, float audio){
	// shaping 
	int padding = (side / 16);
	int realX = x + (padding / 2);
	int realY = y + (padding / 2);

	float b = brightness(c) * audio;
	int sideLab = int(map(b, 0 , 255, side, side / 2));

	int realSide = sideLab - padding;
	ellipse(realX, realY + yOffset, realSide, realSide);
}


