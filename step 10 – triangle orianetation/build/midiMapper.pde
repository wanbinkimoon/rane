void midiMapper(){
	skip = int(map(knob[8], 0, 100, 2, 100));
	reductionFactor = int(map(knob[9], 0, 100, 4, 100));
}