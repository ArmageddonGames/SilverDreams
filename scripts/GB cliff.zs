
// GB cliff
const int CT_CLIFF 					= 146;		// CT_SCRIPT5 - CT used for the cliffs. Look in std_constants.zh for reference. It's Script 1 (142) by default.
const int CLIFF_PAUSE 				= 12;		// This is the number of frames (60ths of a second) Link must walk into the cliff before jumping

//gb cliff
bool CheckCliffDirection(int Combo){
		int Dir;
		if(Screen->ComboS[Combo]==0101b)
			Dir = DIR_UP;
		else if(Screen->ComboS[Combo]==1010b)
			Dir = DIR_DOWN;
		else if(Screen->ComboS[Combo]==0011b)
			Dir = DIR_LEFT;
		else if(Screen->ComboS[Combo]==1100b)
			Dir = DIR_RIGHT;
		else
			return false;
		if(Dir==Link->Dir)
			return true;
		return false;
}