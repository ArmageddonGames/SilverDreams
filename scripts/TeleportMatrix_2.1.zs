/////////////////////////////////
/// Teleportation Matrix Item ///
/// v2.1 - 7th May, 2015      ///
///////////////////////////////////////////////////////////////////////////////////////////////////////
/// This item stores (up to) six slots that the player may use to store a teleport destination and  ///
/// later return there, using a Tango dialogue menu.                                                ///
///                                                                                                 ///
/// The destination is stored as the coordinates where the player is located when he uses the 'SET" ///
/// command, (optionally) using MP, and the player may attempt to teleport back to that location at ///
/// any time using the 'GO' commands, that also (optionally) use MP. The warpAllowed boolean acts   ///
/// to allow the game designer the ability to easily disable the item at any time.                  ///
///                                                                                                 ///
/// The base configuration uses three sets, 1 & 2; 3 & 4; and 5 & 6 as pairs, assuming that the     ///
/// player will want to set his source, and destination points together to easily shift between     ///
/// two areas. The cost of each higher set doubles in both dice, and die type, making it costly     ///
/// to store, and use all six slots regularly, but allowing the base two at a modest cost.          ///
///////////////////////////////////////////////////////////////////////////////////////////////////////

//import "warpFunctions.zh"

int teleportMatrix[40]={
	100,22,104,152,50,
	0,0,88,96,1,
	0,0,88,96,1,
	0,0,88,96,1,
	0,0,88,96,1,
	0,0,88,96,1,
	0,0,88,96,1,
	0,0,88,96,1};


const int TEL_DMAP = 0;
const int TEL_SCREEN = 1;
const int TEL_X = 2;
const int TEL_Y = 3;
const int TEL_MAP = 4;

//Teleport Index Bases


const int TEL_1 = 0;
const int TEL_2 = 5;
const int TEL_3 = 10;
const int TEL_4 = 15;
const int TEL_5 = 20;
const int TEL_6 = 25;
const int TEL_START = 30;
const int TEL_HOME = 35;

//4 vals x 6

//1: DMAP, SCREEN, X, Y
//2: DMAP, SCREEN, X, Y
//3: DMAP, SCREEN, X, Y
//4: DMAP, SCREEN, X, Y
//5: DMAP, SCREEN, X, Y
//6: DMAP, SCREEN, X, Y

//Intended Costs in MP
//Teleport 1 & 2 = 4d6
//Teleport 3 & 4 = 8d8
//Teleport 5 & 6 = 16d10

const int TeleportMenu = 55; // FFC Slot for Teleport Item Menu

const int WARP_WAVE = 30;

const int SFX_TELEPORT = 67; //Sound effect for teleportation matrix effect.
const int TELEPORT_CIRCLE_COLOUR = 181; //Colour for teleport circle.
const int SFX_SET_TELEPORT = 98; //Menu Sound for Setting Teleport Destination
const int TELEPORT_WAVE = 60; //Duration of Teleport Wave Effect
const int SFX_WARP_ERROR = 80;
const int FLASH_LAYER = 6;
const int TELEPORT_OVERLAY = 5;
const int TELEPORT_SAFETY = 10;

const int WARP_DURATION = 80;

const int SFX_TELEPORT_TRANSITION = 100;

//Drawing Colours
const int WARP_GREEN = 45;
const int WARP_BLUE = 11;
const int WARP_YELLOW = 126;
const int WARP_TEAL = 88;
const int WARP_LTBLUE = 93; //or 88
const int WARP_LTGREEN = 44;
const int WARP_BRIGHTGREEN = 47;
const int WARP_PERIDOT = 97;
const int WARP_SMOKE = 73;

bool warpAllowed = true; //Shift this into game vars arrays and update functions.
bool isWarping = false; //Shift this into game vars arrays and update functions.
bool flashingGreen = false;
bool teleporting = false;
bool arriving = false;

void setTeleport(int base) {
	teleportMatrix[TEL_DMAP + base] = Game->GetCurDMap(); 
	teleportMatrix[TEL_SCREEN + base] = Game->GetCurScreen();
	teleportMatrix[TEL_X + base] = Link->X;
	teleportMatrix[TEL_Y + base] = Link->Y;
	teleportMatrix[TEL_MAP + base] = Game->GetCurMap();
}

void ActivateTeleport(int base, int warpDuration) {
	int startHP = Link->HP;
	int goDMAP = teleportMatrix[TEL_DMAP + base];
	int goSCREEN = teleportMatrix[TEL_SCREEN + base];
	int goX = teleportMatrix[TEL_X + base];
	int goY = teleportMatrix[TEL_Y + base];
	int goMap = teleportMatrix[TEL_MAP + base];
	
	if ( Link->Action == LA_NONE && warpAllowed ) {
		Game->PlaySound(SFX_TELEPORT_TRANSITION);
		freezeAction();
		teleporting = true;
		arriving = true;
		for(int i = warpDuration; i > 0; i--){ //Duration of song/effect.
			NoAction(); //Freeze Link
			//Game->PlaySound(SFX_TELEPORT_TRANSITION);
			//Create animation.
			Screen->Circle ( 6, Link->X+8, Link->Y+8, 20*i/warpDuration, WARP_TEAL, 1, 0, 0, 0, false, 100 );
			
			flashingGreen = false;
			
			//if ( !flashingGreen ) {
			//	Screen->Rectangle(5, 0, 0, 256, 172, WARP_GREEN, 1, 0, 0, 0, true, 20);
			//	flashingGreen = true;
			//	Waitframe();
			//}
			
				
		
			
			do {
			for ( int j = 1; j > 0; j--){
				DrawScreenToLayer(teleportMatrix[TEL_MAP + base], teleportMatrix[TEL_SCREEN + base], 4, 75);
				Screen->Rectangle(5, 0, 0, 256, 172, WARP_GREEN, 1, 0, 0, 0, true, 25);
				Screen->Circle ( 6, Link->X+8, Link->Y+8, 20*i/warpDuration, 1, 1, 0, 0, 0, false, 100 );
				flashingGreen = true;
				Waitframe();
			}
				
			}
			while(teleporting && !flashingGreen);
				
			do {	
				for ( int j = 1; j > 0; j--){
				DrawScreenToLayer(teleportMatrix[TEL_MAP + base], teleportMatrix[TEL_SCREEN + base], 4, 80);
				Screen->Rectangle(5, 0, 0, 256, 172, WARP_LTGREEN, 1, 0, 0, 0, true, 10);
				Screen->Circle ( 6, Link->X+8, Link->Y+8, 20*i/warpDuration, WARP_TEAL, 1, 0, 0, 0, false, 100 );
				flashingGreen = false;
				
				Waitframe();
				}
				
			}
			while(teleporting && flashingGreen);

			
			//DrawTeleport( goMap, goSCREEN, TELEPORT_OVERLAY );
			//Screen->Circle ( 7, Link->X+8, Link->Y+8, 20*i/warpDuration, TELEPORT_CIRCLE_COLOUR, 1, 0, 0, 0, false, 64 );
			//DrawScreenToLayer(teleportMatrix[TEL_MAP + base], teleportMatrix[TEL_SCREEN + base], 4, 75);
			if ( Link->HP < startHP ) {
				return; //If Link is hurt, quit
			}
			Waitframe();
		}
		
		//while(teleporting && !ringOn ){
		//isWarping = true;
		//Screen->Wavy = WARP_WAVE;
			Link->Invisible = true;
			
			//DrawScreenToLayer(teleportMatrix[TEL_MAP + base], teleportMatrix[TEL_SCREEN + base], 4, 85);
			Screen->Wavy =60;
			Link->PitWarp( goDMAP, goSCREEN );
			Link->X = goX;
			Link->Y = goY;
			//Screen->Wavy =20;
			//for (int w = 100; w >0; w--){
			//	Screen->Circle ( 6, Link->X+8, Link->Y+8, 20*w/warpDuration, WARP_TEAL, 1, 0, 0, 0, false, 100 );
			//	Waitframe();
			//}
			//Game->PlaySound(SFX_TELEPORT_TRANSITION);
			
	
			//for ( int k = TELEPORT_SAFETY; k > 0; k--){
			//	Waitframe();
			//}
			teleporting = false;
			unfreezeAction();
			Waitframe();
			teleporting = false;
			flashingGreen = false;
		//}
		
		if ( !ringOn ) {
			Link->Invisible = false;
		}
			
		while ( teleporting && ringOn ) {
			Screen->Wavy =20;
			//Game->PlaySound(SFX_TELEPORT_TRANSITION);
			DrawScreenToLayer(teleportMatrix[TEL_MAP + base], teleportMatrix[TEL_SCREEN + base], 4, 85);
			Link->PitWarp( goDMAP, goSCREEN );
			Link->X = goX;
			Link->Y = goY;
			for (int w = 15; w >0; w--){
				Screen->Circle ( 6, Link->X+8, Link->Y+8, 20*w/warpDuration, WARP_TEAL, 1, 0, 0, 0, false, 100 );
				Waitframe();
			}
		
			teleporting = false;
		
			for ( int k = TELEPORT_SAFETY; k > 0; k--){
				Waitframe();
			}
			unfreezeAction();
		}
		
		//return;
	}
            
        else {
            Game->PlaySound(SFX_WARP_ERROR);
            isWarping = false;
		NotEnoughMP();
            //return;
        }
	
}

///Mess around with CollDetection off, and move LinkX/Y prior to warp?

void DrawTeleport(int destDMAP, int destScreen, int layer){
	//freezeAction();
	
	//for ( int i = WARP_DURATION; i > 0; i--) {
	
		
		DrawScreenToLayer(destDMAP, destScreen, layer, 80); //Draw to layer 5.
		if ( !flashingGreen ) {
			
			for ( int j = ( WARP_DURATION / 6 ); j > 0; j--){
				Screen->Rectangle(FLASH_LAYER, 0, 0, 256, 172, WARP_GREEN, 1, 0, 0, 0, true, 50);
				//Screen->Rectangle(FLASH_LAYER, 0, 0, 256, 172, WARP_GREEN, 1, 0, 0, 0, true, 50);
				Waitframe();
			}
			flashingGreen = true;
		}
		else if ( flashingGreen ) {
			for ( int j = ( WARP_DURATION / 6 ); j > 0; j--){
				Screen->Rectangle(FLASH_LAYER, 0, 0, 256, 172, WARP_PERIDOT, 1, 0, 0, 0, true, 50);
				//Screen->Rectangle(FLASH_LAYER, 0, 0, 256, 172, WARP_PERIDOT, 0, 0, 0, true, 50);
				Waitframe();
			}
			flashingGreen = false;
		} //Can we just draw a rectangle and another wi5thout these loops, oe after the other?
		//DOn't these last only one frame or something?
		flashingGreen = false;
		Waitframe();
	//}
}
		
void DrawScreenToLayer(int sourceMap, int sourceScreen, int layer, int drawOpacity){
	Screen->DrawLayer(layer, sourceMap, sourceScreen, 0, 0, 0, 0, drawOpacity);
	Screen->DrawLayer(layer, sourceMap, sourceScreen, 1, 0, 0, 0, drawOpacity);
	Screen->DrawLayer(layer, sourceMap, sourceScreen, 2, 0, 0, 0, drawOpacity);
	Screen->DrawLayer(layer, sourceMap, sourceScreen, 3, 0, 0, 0, drawOpacity);
	Screen->DrawLayer(layer, sourceMap, sourceScreen, 4, 0, 0, 0, drawOpacity);
	Screen->DrawLayer(layer, sourceMap, sourceScreen, 5, 0, 0, 0, drawOpacity);
}

void DrawScreenToLayer(int sourceMap, int sourceScreen, int layerMin, int layerMax, int drawOpacity){
	for (int i = layerMin; i < layerMax; i++){
		Screen->DrawLayer(0, sourceMap, sourceScreen, i, 0, 0, 0, drawOpacity);
	}
}

void DrawScreenToLayer(int sourceMap, int sourceScreen, int layerMin, int layerMax, int drawOpacity, int destLayer){
	for (int i = layerMin; i < layerMax; i++){
		Screen->DrawLayer(destLayer, sourceMap, sourceScreen, i, 0, 0, 0, drawOpacity);
	}
}

///! Experimental

void FlickerRectangle(int colourOne, int colourTwo, int flashOnLayer, int opacity, int duration){
	bool flashingNow = false;
	for ( int i = duration; i > 0; i--){
		if ( !flashingNow ) {
			for ( int j = ( duration / 6 ); j > 0; j--){
				Screen->Rectangle(flashOnLayer, 0, 0, 256, 172, colourOne, 1, 0, 0, 0, true, opacity);
				Waitframe();
			}
			flashingNow = true;
		}
		else if ( flashingNow ) {
			for ( int j = ( duration / 6 ); j > 0; j--){
				Screen->Rectangle(flashOnLayer, 0, 0, 256, 172, colourTwo, 1, 0, 0, 0, true, opacity);
				Waitframe();
			}
			flashingGreen = false;
		} 
		//Can we just draw a rectangle and another, that flicker between two colours, without these loops?
		//Don't these normally last only one frame, or something?
		Waitframe();
	}
}

void TeleportScreen(int sourceMap, int SourceScreen, int drawToLayer, int drawOpacity, int layersDeep, int effectColourOne, int effectColourTwo, int effectLayer, int effectOpacity){
	Screen->Rectangle(effectLayer, 0, 0, 256, 172, effectColourOne, 1, 0, 0, 0, true, effectOpacity);
	DrawScreenToLayer(sourceMap, SourceScreen, drawToLayer, drawOpacity, layersDeep);
	Screen->Rectangle(effectLayer, 0, 0, 256, 172, effectColourTwo, 1, 0, 0, 0, true, effectOpacity);
}


///! End Experimental


item script teleportationMatrix{
	void run(int dieType, int dice){
		int totalCost = rollDice(dieType, dice);
		int args[2]={dieType,dice};
		RunFFCScript(TeleportMenu, args);
	}
}

ffc script TeleportMenu{
    void run(int dice, int dieType){
	
	int teleportOneCost = rollDice(dice, dieType);
	int teleportTwoCost = rollDice( (dice * 2 ), ( dieType * 2 ) );
	int teleportThreeCost = rollDice( (dice * 4 ), ( dieType * 4 ) );
	
	
	int teleportSetOneCost = ( teleportOneCost * 0.5 );
	int teleportSetTwoCost = ( teleportTwoCost * 0.5 );
	int teleportSetThreeCost = ( teleportThreeCost * 0.5 );

	//int line1[]="@choice(0)Set@tab(56)Go@26";
	    
        int line2[]="@choice(1)Set 1@tab(56)@choice(7)Go 1@26";
        
        int line3[]="@choice(2)Set 2@tab(56)@choice(8)Go 2@26";

        int line4[]="@choice(3)Set 3@tab(56)@choice(9)Go 3@26";
        
        int line5[]="@choice(4)Set 4@tab(56)@choice(10)Go 4@26";
        
        int line6[]="@choice(5)Set 5@tab(56)@choice(11)Go 5@26";
        
        int line7[]="@choice(6)Set 6@tab(56)@choice(12)Go 6@26";
	int line8[]="@domenu(1)@suspend()";


        
        
        SetUpWindow(WINDOW_SLOT_1, WINDOW_STYLE_1, 16, 16, SIZE_LARGE);
        Tango_LoadString(WINDOW_SLOT_1, line2);
        //Tango_AppendString(WINDOW_SLOT_1, line1);
        //Tango_AppendString(WINDOW_SLOT_1, line2);
        Tango_AppendString(WINDOW_SLOT_1, line3);
        Tango_AppendString(WINDOW_SLOT_1, line4);
        Tango_AppendString(WINDOW_SLOT_1, line5);
        Tango_AppendString(WINDOW_SLOT_1, line6);
        Tango_AppendString(WINDOW_SLOT_1, line7);
	Tango_AppendString(WINDOW_SLOT_1, line8);
        Tango_ActivateSlot(WINDOW_SLOT_1);
        
        
        while(!Tango_MenuIsActive()){
            
            Waitframe();
        }
        
        // Save the state of the text slot and menu. The bitmap won't change,
        // so it doesn't need saved.
        int slotState[274];
        int menuState[60];
        int cursorPos;
        Tango_SaveSlotState(WINDOW_SLOT_1, slotState);
        Tango_SaveMenuState(menuState);
        
        bool done=false;
        int choice;
        while(true)
        {
        if ( Link->PressEx1 ){
          
            Quit();
        }
        
                //if ( done == false && menuOpen == false ) {
                //    menuOpen = true;
                //}
                //if ( done == true && menuOpen == true ){
                //    menuOpen = false;
                //}
            while(Tango_MenuIsActive())
            {
               
                cursorPos=Tango_GetMenuCursorPosition();
                
                Waitframe();
            }
            
            choice=Tango_GetLastMenuChoice();
            
            if(choice==1) // Set Teleport One
            {
		Trace(teleportSetOneCost);
		if ( Link->MP >= teleportSetOneCost ) {
			Link->MP -= teleportSetOneCost;
			setTeleport(TEL_1);
			Game->PlaySound(SFX_SET_TELEPORT);
			done=true;
		}
		else {
			Game->PlaySound(SFX_WARP_ERROR);
			NotEnoughMP();
		}
            }
            else if(choice==2) // Set Teleport Two
            {
                if ( Link->MP >= teleportSetOneCost ) {
			Link->MP -= teleportSetOneCost;
			setTeleport(TEL_2);
			Game->PlaySound(SFX_SET_TELEPORT);
			done=true;
		}
		else {
			Game->PlaySound(SFX_WARP_ERROR);
			NotEnoughMP();
		}
            }
            else if(choice==3) // Set Teleport Three
            {
                if ( Link->MP >= teleportSetTwoCost ) {
			Link->MP -= teleportSetTwoCost;
			setTeleport(TEL_3);
			Game->PlaySound(SFX_SET_TELEPORT);
			done=true;
		}
		else {
			Game->PlaySound(SFX_WARP_ERROR);
			NotEnoughMP();
		}
            }
            else if(choice==4){ // Set Teleport Four
               if ( Link->MP >= teleportSetTwoCost ) {
			Link->MP -= teleportSetTwoCost;
			setTeleport(TEL_4);
			Game->PlaySound(SFX_SET_TELEPORT);
			done=true;
		}
		else {
			Game->PlaySound(SFX_WARP_ERROR);
			NotEnoughMP();
		}
            }
             else if(choice==5) // Set Teleport Five
            {
                if ( Link->MP >= teleportSetThreeCost ) {
			Link->MP -= teleportSetThreeCost;
			setTeleport(TEL_5);
			Game->PlaySound(SFX_SET_TELEPORT);
			done=true;
		}
		else {
			Game->PlaySound(SFX_WARP_ERROR);
			NotEnoughMP();
		}
            }
             else if(choice==6) // Set Teleport Six
            {
                if ( Link->MP >= teleportSetThreeCost ) {
			Link->MP -= teleportSetThreeCost;
			setTeleport(TEL_6);
			Game->PlaySound(SFX_SET_TELEPORT);
			done=true;
		}
		else {
			Game->PlaySound(SFX_WARP_ERROR);
			NotEnoughMP();
		}
            }
            else if(choice==7) // GO Teleport One
            {
		Trace(teleportOneCost);
		if ( Link->MP >= teleportOneCost ) {
			Link->MP -= teleportOneCost;
			ActivateTeleport(TEL_1,TELEPORT_WAVE);
			done=true;
		}
		else {
			Game->PlaySound(SFX_WARP_ERROR);
			NotEnoughMP();
		}
            }
             else if(choice==8) // GO Teleport Two
            {
               if ( Link->MP >= teleportOneCost ) {
			Link->MP -= teleportOneCost;
			ActivateTeleport(TEL_2,TELEPORT_WAVE);
			done=true;
		}
		else {
			Game->PlaySound(SFX_WARP_ERROR);
			NotEnoughMP();
		}
            }
             else if(choice==9) // GO Teleport Three
            {
                if ( Link->MP >= teleportTwoCost ) {
			Link->MP -= teleportTwoCost;
			ActivateTeleport(TEL_3,TELEPORT_WAVE);
			done=true;
		}
		else {
			Game->PlaySound(SFX_WARP_ERROR);
			NotEnoughMP();
		}
            }
             else if(choice==10) // GO Teleport Four
            {
                if ( Link->MP >= teleportTwoCost ) {
			Link->MP -= teleportTwoCost;
			ActivateTeleport(TEL_4,TELEPORT_WAVE);
			done=true;
		}
		else {
			Game->PlaySound(SFX_WARP_ERROR);
			NotEnoughMP();
		}
            }
            else if(choice==11) // GO Teleport Five
            {
               if ( Link->MP >= teleportThreeCost ) { 
			Link->MP -= teleportThreeCost;
			ActivateTeleport(TEL_5,TELEPORT_WAVE);
			done=true;
		}
		else {
			Game->PlaySound(SFX_WARP_ERROR);
			NotEnoughMP();
		}
            }
            
            else if(choice==12) // GO Teleport Six
            {
                if ( Link->MP >= teleportThreeCost ) {
			Link->MP -= teleportThreeCost;
			ActivateTeleport(TEL_6,TELEPORT_WAVE);
			done=true;
		}
		else {
			Game->PlaySound(SFX_WARP_ERROR);
			NotEnoughMP();
		}
            }
                
            else if (Link->PressEx1){
              
                Quit();
            }
            else{
               
                done=true;
            }
            
            // If we need to return to the top-level menu,
            // restore the state and loop again.
            if(done){
                
                break;
            }
            else
            {
                Tango_RestoreSlotState(WINDOW_SLOT_1, slotState);
                Tango_RestoreMenuState(menuState);
                Tango_SetMenuCursorPosition(cursorPos);
            }
        }
        
        Tango_ClearSlot(WINDOW_SLOT_1);
    }
}

bool NotEnoughMP(){

    int lineBreak[]="@26";
    int menuEnd[]="@domenu(1)@suspend()";

    
    int line2[]="You do not have enough MP to do that.@26";
    int line1[]="@choice(1)Done@26@26";


    
    SetUpWindow(WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32, SIZE_LARGE);
        Tango_LoadString(WINDOW_SLOT_2, line1);
        Tango_AppendString(WINDOW_SLOT_2, line2);
        Tango_AppendString(WINDOW_SLOT_2, menuEnd);
        Tango_ActivateSlot(WINDOW_SLOT_2);
    
    
    while(!Tango_MenuIsActive()){
        
        Waitframe();
    }
    
    // Save the state again...
    int slotState[274];
    int menuState[60];
    int cursorPos;
    Tango_SaveSlotState(WINDOW_SLOT_2, slotState);
    Tango_SaveMenuState(menuState);
    
    int done=0;
    int choice;
    while(true)
    {
    
        while(Tango_MenuIsActive())
        {
            
            cursorPos=Tango_GetMenuCursorPosition();
          
            Waitframe();
        }
        
        choice=Tango_GetLastMenuChoice();
        if(choice==0) // Canceled
            done=2;
            
        else if(choice == 1) 
        {
            done=2;
        }
         
        else if (Link->PressEx1){
                done = 2;
        }
        else
            done=2;

        

        
        if(done>0){
            
            break;
        }
        else
        {
            Tango_RestoreSlotState(WINDOW_SLOT_2, slotState);
            Tango_RestoreMenuState(menuState);
            Tango_SetMenuCursorPosition(cursorPos);
        }
    }
    
    Tango_ClearSlot(WINDOW_SLOT_2);
    
    if(done==1)
        return true; // Tell parent menu to close
    else
        return false; // Tell parent not to close
}

const int ESCAPE_START = 0;
const int ESCAPE_HOME = 0;

void escapeSpell(int base, int warpDuration) {
	flashingGreen = false;
	int startHP = Link->HP;
	int goDMAP = teleportMatrix[TEL_DMAP + base];
	int goSCREEN = teleportMatrix[TEL_SCREEN + base];
	int goX = teleportMatrix[TEL_X + base];
	int goY = teleportMatrix[TEL_Y + base];
	int goMap = teleportMatrix[TEL_MAP + base];
	
	
	if ( base == ESCAPE_START ){
		startHP = Link->HP;
		goDMAP = 0;
		goSCREEN = 0;
		goX = 88;
		goY = 96;
		goMap = 1;
	}
	
	
	if ( base == ESCAPE_HOME ){
		startHP = Link->HP;
		goDMAP = 0;
		goSCREEN = 0;
		goX = 88;
		goY = 96;
		goMap = 1;
	}
	
	if ( Link->Action == LA_NONE && warpAllowed ) {
		Game->PlaySound(SFX_TELEPORT_TRANSITION);
		freezeAction();
		teleporting = true;
		arriving = true;
		for(int i = warpDuration; i > 0; i--){ //Duration of song/effect.
			NoAction(); //Freeze Link
			Screen->Circle ( 6, Link->X+8, Link->Y+8, 20*i/warpDuration, WARP_TEAL, 1, 0, 0, 0, false, 100 );
			flashingGreen = false;
			do {
			for ( int j = 1; j > 0; j--){
				DrawScreenToLayer(goMap, goSCREEN, 4, 85);
				Screen->Rectangle(5, 0, 0, 256, 172, WARP_GREEN, 1, 0, 0, 0, true, 25);
				Screen->Circle ( 6, Link->X+8, Link->Y+8, 20*i/warpDuration, 1, 1, 0, 0, 0, false, 100 );
				flashingGreen = true;
				Waitframe();
			}
				
			}
			while(teleporting && !flashingGreen);
				
			do {	
				for ( int j = 1; j > 0; j--){
				DrawScreenToLayer(goMap, goSCREEN, 4, 85);
				Screen->Rectangle(5, 0, 0, 256, 172, WARP_LTGREEN, 1, 0, 0, 0, true, 10);
				Screen->Circle ( 6, Link->X+8, Link->Y+8, 20*i/warpDuration, WARP_TEAL, 1, 0, 0, 0, false, 100 );
				flashingGreen = false;
				
				Waitframe();
				}
				
			}
			while(teleporting && flashingGreen);

			if ( Link->HP < startHP ) {
				return; //If Link is hurt, quit
			}
			flashingGreen = false;
			Waitframe();
		}
		

			Link->Invisible = true;
			
			//DrawScreenToLayer(teleportMatrix[TEL_MAP + base], teleportMatrix[TEL_SCREEN + base], 4, 85);
			Screen->Wavy =60;
			Link->PitWarp( goDMAP, goSCREEN );
			Link->X = goX;
			Link->Y = goY;

			teleporting = false;
			unfreezeAction();
			Waitframe();
			teleporting = false;

		
		if ( !ringOn ) {
			Link->Invisible = false;
		}
			
		while ( teleporting && ringOn ) {
			Screen->Wavy =20;
			//Game->PlaySound(SFX_TELEPORT_TRANSITION);
			DrawScreenToLayer(goMap, goSCREEN, 4, 85);
			Link->PitWarp( goDMAP, goSCREEN );
			Link->X = goX;
			Link->Y = goY;
			for (int w = 15; w >0; w--){
				Screen->Circle ( 6, Link->X+8, Link->Y+8, 20*w/warpDuration, WARP_TEAL, 1, 0, 0, 0, false, 100 );
				Waitframe();
			}
		
			teleporting = false;
		
			for ( int k = TELEPORT_SAFETY; k > 0; k--){
				Waitframe();
			}
			unfreezeAction();
		}
		
		//return;
	}
            
        else {
            Game->PlaySound(SFX_WARP_ERROR);
            isWarping = false;
		NotEnoughMP();
            //return;
        }
	
}