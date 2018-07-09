

// ================================================================

// Called in reductionLab
void effecRender(int x, int y, int side, color c, int yOffset){
	color realColor = #A73CCB;
	noStroke(); fill(realColor);
	if(brightness(c) < 20)
		bottomLef(x, y, side, c, yOffset);
	if(brightness(c) >= 20 && brightness(c) < 80)
		bottomRight(x, y, side, c, yOffset);
	if(brightness(c) >= 80 && brightness(c) < 120)
		topLeft(x, y, side, c, yOffset);
	if(brightness(c) >= 120)
		topRight(x, y, side, c, yOffset);
}

// ================================================================

void bottomLef(int x, int y, int side, color c, int yOffset){
	// shaping 
	int padding = (side / 16);
	int realX = x + (padding / 2);
	int realY = y + (padding / 2);

	float b = brightness(c);
	int sideLab = int(map(b, 0 , 255, side, 1));

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

void bottomRight(int x, int y, int side, color c, int yOffset){
	// shaping 
	int padding = (side / 16);
	int realX = x + (padding / 2);
	int realY = y + (padding / 2);

	float b = brightness(c);
	int sideLab = int(map(b, 0 , 255, side, 1));

	int realSide = sideLab - padding;
	int x1triangle = realX; 
	int y1triangle = realY + realSide; 
	int x2triangle = realX + realSide; 
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

void topLeft(int x, int y, int side, color c, int yOffset){
	// shaping 
	int padding = (side / 16);
	int realX = x + (padding / 2);
	int realY = y + (padding / 2);

	float b = brightness(c);
	int sideLab = int(map(b, 0 , 255, side, 1));

	int realSide = sideLab - padding;

	int x1triangle = realX + realSide; 
	int y1triangle = realY; 
	int x2triangle = realX + realSide;
	int y2triangle = realY + realSide; 
	int x3triangle = realX; 
	int y3triangle = realY; 

	triangle(
		x1triangle,
		y1triangle + yOffset, 
		x2triangle, 
		y2triangle + yOffset, 
		x3triangle, 
		y3triangle + yOffset);
}

void topRight(int x, int y, int side, color c, int yOffset){
	// shaping 
	int padding = (side / 16);
	int realX = x + (padding / 2);
	int realY = y + (padding / 2);

	float b = brightness(c);
	int sideLab = int(map(b, 0 , 255, side, 1));

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
