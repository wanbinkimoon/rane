void midiMapper(){
	skip = int(map(knob[0], 0, 100, 2, 100));
	reductionFactor = int(map(knob[1], 0, 100, 4, 100));

	if(pad[0]){
		CIRCLE = true;
		RECTANGLES = false;
		TRIANGLES = false;
	}	
	if(pad[1]){
		CIRCLE = false;
		RECTANGLES = true;
		TRIANGLES = false;
	}	
	if(pad[2]){
		CIRCLE = false;
		RECTANGLES = false;
		TRIANGLES = true;
	}
}