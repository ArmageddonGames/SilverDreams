import "std.zh"
import "string.zh"
import "ffcscript.zh"
import "std_functions_addon.zh"

//bottomless pits and lava
int Falling;
bool Warping;

// ---------------------------------------------------------------------------------------------------------------------------------------------------

//bottomless pits and lava
const int BIG_LINK                  = 0;   		// Set this constant to 1 if using the Large Link Hit Box feature.
const int CT_HOLELAVA               = 128; 		// CT to use for pit holes and lava. "No Ground Enemies by default"
const int CF_PIT                    = 101; 		// CF to register combos as pits.
const int CF_LAVA                   = 102; 		// CF to register combos as lava.
const int WPS_LINK_FALL             = 90;  		// The weapon sprite to display when Link falls into a pit. "Sprite 88 by default"
const int WPS_LINK_LAVA             = 89;  		// The weapon sprite to display when Link drowns in lava. "Sprite 89 by default"
const int SFX_LINK_FALL             = 61;  		// The sound to play when Link falls into a pit. "SFX_FALL by default"
const int SFX_LINK_LAVA             = 55;  		// The sound to play when Link drowns in Lava. "SFX_SPLASH by default.
const int CMB_AUTOWARP              = 888; 		// The first of your four transparent autowarp combos.
const int HOLELAVA_DAMAGE           = 8;   		// Damage in hit points to inflict on link. "One Heart Container is worth 16 hit points"

// GB cliff
const int CT_CLIFF 					= 146;		// CT_SCRIPT5 - CT used for the cliffs. Look in std_constants.zh for reference. It's Script 1 (142) by default.
const int CLIFF_PAUSE 				= 12;		// This is the number of frames (60ths of a second) Link must walk into the cliff before jumping

// ---------------------------------------------------------------------------------------------------------------------------------------------------

// D0 is the warp type. 0 for no warp, 1-4 = sidewarps A-D.
// D1 is a boolean and is used to determine whether or not to move Link to the ffcs position. 0 false, 1 true.
// D2 is the amount of damage to do to Link when he falls.

ffc script Holelava
{
	void run(int warp, bool position, int damage)
	{
		while(true)
		{
			while(!Warping) Waitframe();
			if(warp > 0)
			{
				this->Data = CMB_AUTOWARP+warp-1;
				this->Flags[FFCF_CARRYOVER] = true;
				Waitframe();
				this->Data = FFCS_INVISIBLE_COMBO;
				this->Flags[FFCF_CARRYOVER] = false;
				Link->Z = Link->Y;
				Warping = false;
				Link->DrawXOffset -= Cond(Link->DrawXOffset < 0, -1000, 1000);
				Link->HitXOffset -= Cond(Link->HitXOffset < 0, -1000, 1000);
				Quit();
			}
			if(position)
			{
				Link->X = this->X;
				Link->Y = this->Y;
			}
			else
			{
				Link->X = this->InitD[6];
				Link->Y = this->InitD[7];
			}
			if(damage)
			{
				Link->HP -= damage;
				Link->Action = LA_GOTHURTLAND;
				Link->HitDir = -1;
				Game->PlaySound(SFX_OUCH);
			}
			Link->DrawXOffset -= Cond(Link->DrawXOffset < 0, -1000, 1000);
			Link->HitXOffset -= Cond(Link->HitXOffset < 0, -1000, 1000);
			Warping = false;
			Waitframe();
		}
	}
}

// ---------------------------------------------------------------------------------------------------------------------------------------------------

void Update_HoleLava(int x, int y, int dmap, int scr, int dir){
	lweapon hookshot = LoadLWeaponOf(LW_HOOKSHOT);
	if(hookshot->isValid()) return;

	if(Falling)
	{
		if(IsSideview()) Link->Jump=0;
		Falling--;
		if(Falling == 1)
		{
			int buffer[] = "Holelava";
			if(CountFFCsRunning(Game->GetFFCScript(buffer)))
			{
				ffc f = Screen->LoadFFC(FindFFCRunning(Game->GetFFCScript(buffer)));
				Warping = true;
				if(f->InitD[1]==0)
				{
					f->InitD[6] = x;
					f->InitD[7] = y;
				}
			}
			else
			{
				Link->X = x;
				Link->Y = y;
				Link->Dir = dir;
				Link->DrawXOffset -= Cond(Link->DrawXOffset < 0, -1000, 1000);
				Link->HitXOffset -= Cond(Link->HitXOffset < 0, -1000, 1000);
				Link->HP -= HOLELAVA_DAMAGE;
				Link->Action = LA_GOTHURTLAND;
				Link->HitDir = -1;
				Game->PlaySound(SFX_OUCH);
				if(Game->GetCurDMap()!=dmap || Game->GetCurDMapScreen()!=scr)
				Link->PitWarp(dmap, scr);
			}
			NoAction();
			Link->Action = LA_NONE;
		}
	}
	else if(Link->Z==0 && OnPitCombo() && !Warping)
	{
		Link->DrawXOffset += Cond(Link->DrawXOffset < 0, -1000, 1000);
		Link->HitXOffset += Cond(Link->HitXOffset < 0, -1000, 1000);
		int comboflag = OnPitCombo();
		SnaptoGrid();
		Game->PlaySound(Cond(comboflag == CF_PIT, SFX_LINK_FALL, SFX_LINK_LAVA));
		lweapon dummy = CreateLWeaponAt(LW_SCRIPT10, Link->X, Link->Y);
		dummy->UseSprite(Cond(comboflag == CF_PIT, WPS_LINK_FALL, WPS_LINK_LAVA));
		dummy->DeadState = dummy->NumFrames*dummy->ASpeed;
		dummy->DrawXOffset = 0;
		dummy->DrawYOffset = 0;
		Falling = dummy->DeadState;
		NoAction();
		Link->Action = LA_NONE;
	}
}


int OnPitCombo(){
	int comboLoc = ComboAt(Link->X+8, Link->Y + Cond(BIG_LINK==0, 12, 8));
	if(Screen->ComboT[comboLoc] != CT_HOLELAVA)
	return 0;
	else if(Screen->ComboI[comboLoc] == CF_PIT || Screen->ComboI[comboLoc] == CF_LAVA)
	return Screen->ComboI[comboLoc];
	else if(Screen->ComboF[comboLoc] == CF_PIT || Screen->ComboF[comboLoc] == CF_LAVA)
	return Screen->ComboF[comboLoc];
	else
	return 0;
}


void SnaptoGrid(){
	int x = Link->X;
	int y = Link->Y + Cond(BIG_LINK==0, 8, 0);
	int comboLoc = ComboAt(x, y);

	//X Axis
	if(Screen->ComboT[comboLoc] == CT_HOLELAVA && Cond(x % 16 == 0, true, Screen->ComboT[comboLoc+1] != CT_HOLELAVA))
	Link->X = ComboX(comboLoc);
	else if(Screen->ComboT[comboLoc+1] == CT_HOLELAVA && Cond(x % 16 == 0, true, Screen->ComboT[comboLoc] != CT_HOLELAVA))
	Link->X = ComboX(comboLoc+1);
	if(Cond(y % 16 == 0, false, Screen->ComboT[comboLoc+16] == CT_HOLELAVA) && Cond(x % 16 == 0, true, Screen->ComboT[comboLoc+17] != CT_HOLELAVA))
	Link->X = ComboX(comboLoc+16);
	else if(Cond(y % 16 == 0, false, Screen->ComboT[comboLoc+17] == CT_HOLELAVA) && Cond(x % 16 == 0, true, Screen->ComboT[comboLoc+16] != CT_HOLELAVA))
	Link->X = ComboX(comboLoc+17);

	//Y Axis
	if(Screen->ComboT[comboLoc] == CT_HOLELAVA && Cond(y % 16 == 0, true, Screen->ComboT[comboLoc+16] != CT_HOLELAVA))
	Link->Y = ComboY(comboLoc);
	else if(Screen->ComboT[comboLoc+16] == CT_HOLELAVA && Cond(y % 16 == 0, true, Screen->ComboT[comboLoc] != CT_HOLELAVA))
	Link->Y = ComboY(comboLoc+16);
	if(Cond(x % 16 == 0, false, Screen->ComboT[comboLoc+1] == CT_HOLELAVA) && Cond(y % 16 == 0, true, Screen->ComboT[comboLoc+17] != CT_HOLELAVA))
	Link->Y = ComboY(comboLoc+1);
	else if(Cond(x % 16 == 0, false, Screen->ComboT[comboLoc+17] == CT_HOLELAVA) && Cond(y % 16 == 0, true, Screen->ComboT[comboLoc+1] != CT_HOLELAVA))
	Link->Y = ComboY(comboLoc+17);
}


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

			if(Link->Dir==DIR_UP&&NoWalk(Link->X, Link->Y, DIR_UP, 1, true)&&Link->InputUp&&Screen->ComboT[ComboAt(Link->X+8, Link->Y+14)]==CT_CLIFF&&CheckCliffDirection(ComboAt(Link->X+8, Link->Y+14))&&Link->Action==LA_WALKING){
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
			else if(Link->Dir==DIR_DOWN&&NoWalk(Link->X, Link->Y, DIR_DOWN, 1, true)&&Link->InputDown&&Screen->ComboT[ComboAt(Link->X+8, Link->Y+12)]==CT_CLIFF&&CheckCliffDirection(ComboAt(Link->X+8, Link->Y+12))&&Link->Action==LA_WALKING){
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
			else if(Link->Dir==DIR_LEFT&&NoWalk(Link->X, Link->Y, DIR_LEFT, 1, true)&&Link->InputLeft&&Screen->ComboT[ComboAt(Link->X+4, Link->Y+8)]==CT_CLIFF&&CheckCliffDirection(ComboAt(Link->X+4, Link->Y+8))&&Link->Action==LA_WALKING){
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
			else if(Link->Dir==DIR_RIGHT&&NoWalk(Link->X, Link->Y, DIR_RIGHT, 1, true)&&Link->InputRight&&Screen->ComboT[ComboAt(Link->X+12, Link->Y+8)]==CT_CLIFF&&CheckCliffDirection(ComboAt(Link->X+12, Link->Y+8))&&Link->Action==LA_WALKING){
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