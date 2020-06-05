import "std.zh"
import "string.zh"
import "ffcscript.zh"

import "well/well_script.z"
import "well/hole lava.z"
import "well/GB cliff.z"

// ---------------------------------------------------------------------------------------------------------------------------------------------------

global script Slot_2
{
	void run(){

		// GB CLIFF
		int PushCounter = 0;						

		// PITS AND LAVA
		int olddmap = Game->GetCurDMap();
		int oldscreen = Game->GetCurDMapScreen();
		int startx = Link->X;
		int starty = Link->Y;
		int startdir = Link->Dir;
		Falling = 0;
		Warping = false;



		while(true){

			// HOLE LAVA .........................................................................................

			if(Link->Action != LA_SCROLLING){
				Update_HoleLava(startx, starty, olddmap, oldscreen, startdir);
				if(Link->Z==0 && !Falling && (oldscreen != Game->GetCurDMapScreen() || olddmap != Game->GetCurDMap())){
					olddmap = Game->GetCurDMap();
					oldscreen = Game->GetCurDMapScreen();
					startx = Link->X;
					starty = Link->Y;
					startdir = Link->Dir;
				}
			}

			// END HOLE LAVA .........................................................................................

			// GB CLIFF ..............................................................................................

			if(Link->Dir==DIR_UP&&!CanWalk(Link->X, Link->Y, DIR_UP, 1, false)&&Link->InputUp&&Screen->ComboT[ComboAt(Link->X+8, Link->Y+14)]==CT_CLIFF&&CheckCliffDirection(ComboAt(Link->X+8, Link->Y+14))&&Link->Action==LA_WALKING){
				PushCounter++;
				if(PushCounter>=CLIFF_PAUSE){
					Game->PlaySound(SFX_JUMP);
					Link->Jump = 2;
					int Y = Link->Y;
					for(int i=0; i<26; i++){
						Y -= 0.61;
						Link->Y = Y;
						WaitNoAction();
					}
					PushCounter = 0;
				}
			}
			else if(Link->Dir==DIR_DOWN&&!CanWalk(Link->X, Link->Y, DIR_DOWN, 1, false)&&Link->InputDown&&Screen->ComboT[ComboAt(Link->X+8, Link->Y+12)]==CT_CLIFF&&CheckCliffDirection(ComboAt(Link->X+8, Link->Y+12))&&Link->Action==LA_WALKING){
				PushCounter++;
				if(PushCounter>=CLIFF_PAUSE){
					Game->PlaySound(SFX_JUMP);
					Link->Jump = 1;
					int Combo = ComboAt(Link->X+8, Link->Y+12);
					int CliffHeight = 1;
					for(int i=1; i<11; i++){
						if(Screen->isSolid(ComboX(Combo)+8, ComboY(Combo)+8+16*i))
						CliffHeight++;
						else
						break;
					}
					Link->Z = CliffHeight*16;
					Link->Y += CliffHeight*16;
					while(Link->Z>0){
						WaitNoAction();
					}
					PushCounter = 0;
				}
			}
			else if(Link->Dir==DIR_LEFT&&!CanWalk(Link->X, Link->Y, DIR_LEFT, 1, false)&&Link->InputLeft&&Screen->ComboT[ComboAt(Link->X+4, Link->Y+8)]==CT_CLIFF&&CheckCliffDirection(ComboAt(Link->X+4, Link->Y+8))&&Link->Action==LA_WALKING){
				PushCounter++;
				if(PushCounter>=CLIFF_PAUSE){
					Game->PlaySound(SFX_JUMP);
					Link->Jump = 2;
					int X = Link->X;
					for(int i=0; i<26; i++){
						X -= 0.92;
						if(i==13){
							Link->Z += 16;
							Link->Y += 16;
						}
						Link->X = X;
						WaitNoAction();
					}
					while(Link->Z>0){
						WaitNoAction();
					}
					PushCounter = 0;
				}
			}
			else if(Link->Dir==DIR_RIGHT&&!CanWalk(Link->X, Link->Y, DIR_RIGHT, 1, false)&&Link->InputRight&&Screen->ComboT[ComboAt(Link->X+12, Link->Y+8)]==CT_CLIFF&&CheckCliffDirection(ComboAt(Link->X+12, Link->Y+8))&&Link->Action==LA_WALKING){
				PushCounter++;
				if(PushCounter>=CLIFF_PAUSE){
					Game->PlaySound(SFX_JUMP);
					Link->Jump = 2;
					int X = Link->X;
					for(int i=0; i<26; i++){
						X += 0.92;
						if(i==13){
							Link->Z += 16;
							Link->Y += 16;
						}
						Link->X = X;
						WaitNoAction();
					}
					while(Link->Z>0){
						WaitNoAction();
					}
					PushCounter = 0;
				}
			}
			else{
				PushCounter = 0;
			}

			// END GB CLIFF .........................................................................................


			Waitdraw();



			Waitframe();

		}
	}
}