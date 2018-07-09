// boolean CIRCLE = false;
boolean RECTANGLES = false;
boolean TRIANGLES = false;

// ================================================================

// Called in reductionLab
void effecRender(int x, int y, int side, color c, int yOffset){
	// CIRCLE = brightness(c) < 60;
	// if(CIRCLE)
	// 	renderDots(x, y, side, c, yOffset);

	TRIANGLES = brightness(c) > 125;
	if(TRIANGLES)
		renderTriangles(x, y, side, c, yOffset);
	RECTANGLES = brightness(c) < 125;
	if(RECTANGLES)
		renderRects(x, y, side, c, yOffset);
}

// ================================================================

void renderTriangles(int x, int y, int side, color c, int yOffset, int angle){
	color realColor = #A73CCB;
	noStroke(); fill(realColor);

	// shaping 
	int padding = (side / 16);
	int realX = x + (padding / 2);
	int realY = y + (padding / 2);

	float b = brightness(c);
	int sideLab = int(map(b, 0 , 255, side, 2));

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

void renderRects(int x, int y, int side, color c, int yOffset){
	color realColor = #A73CCB;
	noStroke(); fill(realColor);

	// shaping 
	int padding = (side / 8);
	int realX = x + (padding / 2);
	int realY = y + (padding / 2) + yOffset;

	float b = brightness(c);
	int sideElab = int(map(b, 0 , 255, side, 0));
	int realSide = sideElab - padding;
	rect(realX, realY, realSide, realSide);
}

// ================================================================

// void renderDots(int x, int y, int side, color c, int yOffset){
// 	color realColor = #A73CCB;
// 	noStroke(); fill(realColor);

// 	// shaping 
// 	int padding = (side / 16);
// 	int realX = x + ((side / 3) * 2);
// 	int realY = y + ((side / 3) * 2);

// 	float b = brightness(c);
// 	int sideElab = int(map(b, 0 , 255, side, 0));
// 	int realSide = sideElab - padding;
// 	// rect(realX, realY + yOffset, realSide, realSide);
// 	ellipse(realX, realY + yOffset, realSide, realSide);
// }
