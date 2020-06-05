
///////////////////////////////////
/// Timed Pressure Plates       ///
/// v1.0 - 26th January, 2017   ///
/// By: ZoriaRPG                ///
/// Requested By: Shadowblitz16 ///
///////////////////////////////////

//Settings

//Flags to Use
const int CF_PRESSPLATE 	= 101; //Flag used to denote a pressure plate.
const int CF_PRESSPLATE_DOOR 	= 102; //Flag for combo to change when all pressure plates are triggered.

const int PRESSUREPLATES_ADVANCE_WHEN_TRIGGERED = 1; //Overrides 'advance' option in the ffc, globally. 

ffc script multipressplates{
	//D0: THe Screen->D register to use. 
	//D1: The sound for stepping on a pressure plate.
	//D2: the sound to play for doors opening.
	//D3: The number of pressure plates on the screen, required to trigger the doors. 
	//D4: Duration of pressure plate sequence timer. 
	//D5: Set to '1' if you want the trigger to be permanent. 
	//D6: Split between integer and decimal:
	//	Integer Side, Set to '1' to advance pressure plates when triggered.
	//	Decimal Side, Set to '1' to clear *inherent* flags on pressure plate combos. 
	//Rats. Here's how those value splitting things work.
	//D7: Set to a combo ID if you wish this ffc to turn into that combo when all triggers are triggered.
	
	//Too bad FFCs aren;t solid, but it can be used for something such as an additional trigger. 
	void run(int reg, int sfx, int shuttersfx, int numplates, int PRESSUREPLATE_DUR, int perm, int advance_clear_inherent, int change_this_into){
		int advance = (advance_clear_inherent << 0); //Integer side
		int clear_inherent = ( advance_clear_inherent - ( advance_clear_inherent << 0 ) * 10000); //decimal side. 
		int platetimers[32];
		int platelocations[32];
		int w; //a general sp. 
		for ( ; w < 32; w++ ) {
			platelocations[w] = -1;
			platetimers[w] = -1; 
		}
		int ffram[32];
		w = 0; int q; 
		int loc;
		//int doortimers[32];
		//int doorlocations[32];
		
		//Allow the change to persist if D4 is set.
		if ( perm && Screen->D[reg] >= numplates ) {
			
			for ( q = 0; q < 176; q++ ) {
				//find the door flag
				if ( ComboFI(ComboX(q), ComboY(q), CF_PRESSPLATE_DOOR) ) Screen->ComboD[q]++;
				//if ( shuttersfx ) Game->PlaySound(shuttersfx);
				
			}
			this->Data = 0; this->Script = 0; Quit();
			
		}
		//If D4 is not set, revert on screen reload. 
		else { 
			Screen->D[reg] = 0;
		}
		
		//Main loop
		while(true){
			//Check the pressure plate timers, reduce them if needed.
			for ( q = 0; q < 32; q++ ) {
				if ( platetimers[q] > 0 ) platetimers[q]--;
				//If a timer is '0', change its combo back to a trigger.
				if ( platetimers[q] == 0 ) {
					//if we changed a plate at a location...
					if ( platelocations[q] != -1 ) { //-1 is 'unchanged'
						Screen->ComboD[ platelocations[q] ]--; //change it back
						if ( sfx ) Game->PlaySound(sfx);
						Screen->ComboF[ platelocations[q] ] = CF_PRESSPLATE;
						if ( Screen->D[reg] > 0 ) Screen->D[reg]--;
						//Screen->ComboI[ platelocations[q] ] = CF_PRESSPLATE;
					}
					platetimers[q] = -1; //mark it as an unchanged status, for the next cycle. 
				}
			}
			//Update the location of Link's trigger point.
			loc = ComboAt(Link->X+8, Link->Y+8);
			//If he steps on a combo with either a placed, or inherent flag of the triggering type...
			if ( ComboFI(Link->X+8, Link->Y+8, CF_PRESSPLATE) ) {
				Screen->D[reg]++; //increment Screen->D[reg]
				if ( sfx ) Game->PlaySound(sfx); //play a sound, if set
				Screen->ComboF[loc] = CF_NONE; //clear the flags off the combo. 
				if ( clear_inherent ) Screen->ComboI[loc] = CF_NONE;  
								//You may want to remove the clearing of inherent 
								//flags if you use combos that have other types applies
								//and rely solely on placed flags for this. 
				if ( PRESSUREPLATES_ADVANCE_WHEN_TRIGGERED || advance ) Screen->ComboD[loc]++; //Move to the next combo if we allow that.
				platelocations[w] = loc; platetimers[w] = PRESSUREPLATE_DUR; w++;  //Update the locations, and timers. 
				//store the location and set a timer for it. 
				
				//This reads the setting, and if the assigned value is not '0'
				//it advances the pressure plate combo by '1'.
				continue; //return tot he head of the loop. 
			}
			//If Link has triggered all of the plates...
			if ( Screen->D[reg] >= numplates ) {
				for ( q = 0; q < 176; q++ ) { //cycle through the combos looking for the combo to change. 
					//find the door flag; note that you can change any combo to another.
					//It need not be a door; only a combo with the flag that we specify. 
					//It could equally be a chest, or something.
					if ( ComboFI(ComboX(q), ComboY(q), CF_PRESSPLATE_DOOR) ) Screen->ComboD[q]++;
					//If a sound is set, for the doors/secret trigger, play it.
					if ( shuttersfx ) Game->PlaySound(shuttersfx);
					if ( change_this_into ) this->Data = change_this_into;
				}

				break; //then exit the scope of the while loop.
			}
			Waitframe();
		}
		//If we have exited the scope of the while loop, clear and exit the script. 
		this->Script = 0; 
		if ( this->Data != change_this_into ) this->Data = 0; 
		Quit();
	}
}