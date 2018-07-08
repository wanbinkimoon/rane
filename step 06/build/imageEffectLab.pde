// Called in reductionLab
void effecRender(int x, int y, int side, color c, int yOffset){
		color realColor = #A73CCB;
		noStroke(); fill(realColor);


		// shaping 
		int padding = (side / 16);
		int realX = x + (padding / 2);
		int realY = y + (padding / 2);

		float b = brightness(c);
		int sideElab = int(map(b, 0 , 255, side, 0));
		int realSide = sideElab - padding;
		// rect(realX, realY + yOffset, realSide, realSide);
		ellipse(realX, realY + yOffset, realSide, realSide);
}