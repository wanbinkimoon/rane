

// ================================================================

// Called in reductionLab
void effecRender(int x, int y, int side, color c, int yOffset){
	color realColor = #A73CCB;
	float monochrome = 255 - brightness(c);
	float alpha = map(monochrome, 0, 255, 50, 255);
	float bMap = map(brightness(c), 0, 255, 0, 6);

	noStroke(); fill(realColor, monochrome);

	// if(brightness(c) < 20)
	// 	dotGrid(x, y, side, c, yOffset, audioData[3], );
	// if(brightness(c) >= 20 && brightness(c) < 80)
	if(bMap < 1)
		dotGrid(x, y, side, c, yOffset, audioData[10], #9D3978);
	if(bMap >= 1 && bMap < 2)
		dotGrid(x, y, side, c, yOffset, audioData[9], #C75696);
	if(bMap >= 2 && bMap < 3)
		dotGrid(x, y, side, c, yOffset, audioData[0], #DB69A9);
	if(bMap >= 3 && bMap < 4)
		dotGrid(x, y, side, c, yOffset, audioData[2], #E38ED2);
	if(bMap >= 4 && bMap < 5)
		dotGrid(x, y, side, c, yOffset, audioData[1], #F7BBEC);
	if(bMap >= 5)	
		dotGrid(x, y, side, c, yOffset, audioData[3], #F7BBEC);
}

// ================================================================

void dotGrid(int x, int y, int side, color c, int yOffset, float audio, color renderC){
	fill(renderC);
	// shaping 
	int padding = (side / 16);
	int realX = x + (padding / 2);
	int realY = y + (padding / 2);

	float b = audio * 100;
	int sideLab = int(map(b, 0 , 255, 0, side));

	int realSide = sideLab - padding;
	ellipse(realX, realY + yOffset, realSide, realSide);
}


