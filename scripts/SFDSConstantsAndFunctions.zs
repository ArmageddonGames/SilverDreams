const int DRUNK_TIME = 3600;  // how long to make Link drunk for per beer.
const int DRUNK_EFFECT_CHANCE = 10; // percent chance that Link will be affected by Drunkeness effect that frame.  Multiplied by DRUNK_TIME, so more drunk means more drunk.
 
// set these to whatever you want drawn over Link to indicate the drunk effect.
// they are currently set to draw directly over Link, so most of the tile should be transparent.
 
const int DRUNK_ICON_LAYER = 7; // which layer to draw drunk effect onto.
const int DRUNK_ICON_COMBO = 888; // which combo to use for drunk effect, can be an animated combo.
const int DRUNK_ICON_CSET = 0; // the cset of the drunk effect combo.
 
const int CR_BEER = 7; //The number of beers counter. This is the Script1 counter. 
const int CR_DRUNKENESS = 8; //The counter to use for confusion. This is the Script2 counter. 
 
const int LM_DRUNKACT = 0; // index to Link->Misc[] array, if any other scripts use this change it accordingly
const int LM_DRUNKACTTIME = 1; // index to Link->Misc[] array, if any other scripts use this change it accordingly

//Generic Trigger Constants and Functions
const int LWEAPON_MISC_SOURCE = 0;
int LastItemUsed = 0;


//Extra Item constants

//Farore's Wind constants
const int SFX_FARORESWINDSET = 59; //Default Whistle Whirlwind
const int SFX_FARORESWINDWARP = 39; //Default Farores Wind

const int CMB_AUTOW2 = 504; //An invisible "Auto Warp A" combo
const int CMB_WARPPOINT = 1016; //The combo for the warp point
const int WPS_FARORESWINDSET = 13; //The Weapon/Misc sprite for setting the warp point (appears above Link)
const int WPS_FARORESWINDWARP = 36; //The Weapon/Misc sprite for Link's warp animation

//Global array - gets saved across sessions
int fwData[5] = {-1, -1, -1, -1, 0};
const int FWD_DMAP = 0;
const int FWD_SCREEN = 1;
const int FWD_X = 2;
const int FWD_Y = 3;
const int FWD_ACTIVE = 4; //If 1, call set or warp function

//Magic Container Pieces
const int I_MCPNONE = 131;
const int I_MCPDUMMY = 130;
const int I_MCPIECE1 = 132;
const int I_MCPIECE2 = 133;
const int I_MCPIECE3 = 134;
const int I_MCPIECE4 = 211;

//Link Items
const int Brian = 17; 
const int Justin = 18;
const int Gabe = 61;
const int Bullhorn = 128;
const int BullhornDummy = 72;
const int Microphone = 73;
const int MicrophoneDummy = 71;
const int DummyGuitar2 = 77;
const int DummyGuitar3 = 80;
const int DummyGuitar4 = 78;
const int SmokeBreak = 65;
const int BSong1 = 23;
const int BSong1Dummy = 50;
const int BSong2 = 3;
const int BSong2Dummy = 63;
const int BSong3 = 48;
const int BSong3Dummy = 14;
const int BSong4 = 13;
const int BSong4Dummy = 57;
const int BSong5 = 10;
const int BSong5Dummy = 70;
const int BCharge = 101;
const int BRing = 115;
const int BGuitar1 = 5;
const int BGuitar2 = 6;
const int BGuitar3 = 7;
const int BGuitar4 = 36;
const int Harmonica = 31;
const int JSong1 = 12;
const int JSong1Dummy = 90;
const int JSong2 = 29;
const int JSong2Dummy = 81;
const int JSong3 = 25;
const int JSong3Dummy = 82;
const int JSong4 = 88;
const int JSong4Dummy = 83;
const int JSong5 = 53;
const int JSong5Dummy = 106;
const int JSpin = 98;
const int JRing = 112;
const int JGuitar1 = 123;
const int JGuitar2 = 124;
const int JGuitar3 = 125;
const int JGuitar4 = 126;
const int SSong1 = 52;
const int SSong1Dummy = 24;
const int SSong2 = 54;
const int SSong2Dummy = 55;
const int SSong3 = 91;
const int SSong3Dummy = 35;
const int SSong4 = 64;
const int SSong4Dummy = 15;
const int SSong5 = 136;
const int SSong5Dummy = 68;
const int GGuitar1 = 138;
const int GGuitar2 = 139;
const int GGuitar3 = 140;
const int GGuitar4 = 141;
const int GRing1 = 114;
const int GRing2 = 117;
const int GRing3 = 102;

//Wind Blade Constants
const int LW_GUST = 31;
const int EW_NOBLOWAWAY = 32;
const int LW_MISC_TIMEOUT = 7;
const int LW_MISC_PIERCE = 6;

  
//Attack Ring constant/global
const int MISC_LW_BOOSTED = 0; //Which LWeapon->Misc[] variable to use (can't be used by another script)
float attackRingPower = 1; //Global variable; gets changed by attackRingPickup

//Level and XP constants
const int CR_APPARENT_LEVEL = 9; //The counter used for apparent level, this will be Script 3
const int CR_XP = 10; //The Counter used for XP, thiswill be Script 4
const int CR_MAX_XP = 11; //The Counter usedfor Max XP, this will be Script 5
const int CR_LEVEL = 12; //the counter used for actual levels, this will be script 6
const int CR_BASE_XP = 13; 

 

 
 
// this function is called by XP() function, and checks for enemy HP <= 0, but not yet Dead.  It sets the enemy to Dead, and counts it for XP.  
 
void checkEnemiesKilled(){
    for ( int i = Screen->NumNPCs(); i > 0; i-- ){
        npc enem = Screen->LoadNPC(i);
        if ((enem->HP <=0) && (Game->Counter[CR_APPARENT_LEVEL] < 29))
        {   
            Game->Counter[CR_BASE_XP] += LogToBase((enem->Damage),2); 
         }
     }
}
 
 
void XPLevel()
{
    
    Game->Counter[CR_APPARENT_LEVEL] = Game->Counter[CR_LEVEL] + 1;
    if(Game->Counter[CR_LEVEL] == 0)
    {
    Game->Counter[CR_MAX_XP] = 16;
    Link->MaxHP = 16;
    Link->MaxMP = 32;
    Trace(150);
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Trace(200);
        Game->Counter[CR_LEVEL] = 1;
        Link->MaxHP += 16;
        Trace(250);
        Link->HP += 16;
        Trace(300);
        Link->MP += 32;
        Trace(350);
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
  }
    else if(Game->Counter[CR_LEVEL] == 1)
    {
    Game->Counter[CR_MAX_XP] = 20;
    Link->MaxHP = 32;
    Link->MaxMP = 32;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 2;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 2)
    {
    Game->Counter[CR_MAX_XP] = 26;
    Link->MaxHP = 32;
    Link->MaxMP = 64;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 3;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32;
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 3)
    {
    Game->Counter[CR_MAX_XP] = 32;
     Link->MaxHP = 48;
    Link->MaxMP = 64;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 4;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32;
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 4)
    {
    Game->Counter[CR_MAX_XP] = 41;
     Link->MaxHP = 48;
    Link->MaxMP = 96;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 5;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 5)
    {
    Game->Counter[CR_MAX_XP] = 52;
     Link->MaxHP = 64;
    Link->MaxMP = 96;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 6;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32;
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 6)
    {
    Game->Counter[CR_MAX_XP] = 66;
     Link->MaxHP = 64;
    Link->MaxMP = 128;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 7;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 7)
    {
    Game->Counter[CR_MAX_XP] = 83;
     Link->MaxHP = 80;
    Link->MaxMP = 128;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 8;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 8)
    {
    Game->Counter[CR_MAX_XP] = 105;
    Link->MaxHP = 80;
    Link->MaxMP = 160;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 9;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32;
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 9)
    {
    Game->Counter[CR_MAX_XP] = 133;
    Link->MaxHP = 96;
    Link->MaxMP = 160;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 10;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 10)
    {
    Game->Counter[CR_MAX_XP] = 168;
    Link->MaxHP = 96;
    Link->MaxMP = 192;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 11;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32;
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 11)
    {
    Game->Counter[CR_MAX_XP] = 212;
    Link->MaxHP = 112;
    Link->MaxMP = 192;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 12;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 12)
    {
    Game->Counter[CR_MAX_XP] = 269;
    Link->MaxHP = 112;
    Link->MaxMP = 224;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 13;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 13)
    {
    Game->Counter[CR_MAX_XP] = 340;
    Link->MaxHP = 128;
    Link->MaxMP = 224;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 14;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 14)
    {
    Game->Counter[CR_MAX_XP] = 430;
    Link->MaxHP = 128;
    Link->MaxMP = 256;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 15;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 15)
    {
    Game->Counter[CR_MAX_XP] = 544;
    Link->MaxHP = 144;
    Link->MaxMP = 256;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 16;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 16)
    {
    Game->Counter[CR_MAX_XP] = 688;
    Link->MaxHP = 144;
    Link->MaxMP = 288;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 17;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 17)
    {
    Game->Counter[CR_MAX_XP] = 870;
    Link->MaxHP = 160;
    Link->MaxMP = 288;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 18;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 18)
    {
    Game->Counter[CR_MAX_XP] = 1101;
    Link->MaxHP = 160;
    Link->MaxMP = 320;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 19;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 19)
    {
    Game->Counter[CR_MAX_XP] = 1393;
    Link->MaxHP = 176;
    Link->MaxMP = 320;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 20;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 20)
    {
    Game->Counter[CR_MAX_XP] = 1762;
    Link->MaxHP = 176;
    Link->MaxMP = 352;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 21;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 21)
    {
    Game->Counter[CR_MAX_XP] = 2229;
    Link->MaxHP = 192;
    Link->MaxMP = 352;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 22;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 22)
    {
    Game->Counter[CR_MAX_XP] = 2820;
    Link->MaxHP = 192;
    Link->MaxMP = 384;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 23;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 23)
    {
    Game->Counter[CR_MAX_XP] = 3567;
    Link->MaxHP = 208;
    Link->MaxMP = 384;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 24;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 24)
    {
    Game->Counter[CR_MAX_XP] = 4512;
    Link->MaxHP = 208;
    Link->MaxMP = 416;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 25;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 25)
    {
    Game->Counter[CR_MAX_XP] = 5707;
    Link->MaxHP = 224;
    Link->MaxMP = 416;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 26;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 26)
    {
    Game->Counter[CR_MAX_XP] = 7220;
    Link->MaxHP = 224;
    Link->MaxMP = 448;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 27;
        Link->MaxHP += 16;
        Link->HP += 16;
        Link->MP += 32; 
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 27)
    {
    Game->Counter[CR_MAX_XP] = 9999;
    Link->MaxHP = 240;
    Link->MaxMP = 448;
    if (Game->Counter[CR_XP] >= Game->Counter[CR_MAX_XP])
    {
        Game->Counter[CR_LEVEL] = 28;
        Link->MaxMP += 32;
        Link->HP += 16;
        Link->MP += 32;
        Game->Counter[CR_BASE_XP] -= ((Game->Counter[CR_MAX_XP])*7.24);
    }
    }
    else if(Game->Counter[CR_LEVEL] == 28)
    {
    Game->Counter[CR_MAX_XP] = 0;
    Game->Counter[CR_XP] = 0;
    Link->MaxHP = 240;
    Link->MaxMP = 480;
    }
}   



// Call this in your Global loop.  It handles counting dead enemies for XP, and leveling up.   
void GetXP() 
{
     checkEnemiesKilled(); 
     Game->Counter[CR_XP] = (Game->Counter[CR_BASE_XP] * 0.14);
}
 
// Return if this ffc collides with an lweapon that has the given
// misc attribute at the given value.
bool CollisionAllLWeapon(ffc this, int attrIndex, int attrValue) {
  for (int i = 1; i <= Screen->NumLWeapons(); i++) {
    lweapon lw = Screen->LoadLWeapon(i);
    if (lw->Misc[attrIndex] == attrValue && Collision(this, lw)) {
      return true;}}
  return false;}
  
  //Ice Rod Constants and functions
const int Stunframes = 360;
const int twobytwoice = 3260;
const int threebythreeice = 10580;
const int icecset = 7;
bool opaqueice = false;
const int freezesound = 44;
const int iceblocknpc = 510;
const int watericeoffset = 11;
const int FWaterSound = 44;
const int IceRodID = 25;
const int BookID = 32;
const int DummyID = 100;

bool Groundling(npc t){
    if(t->Type==NPCT_PEAHAT || t->Type==NPCT_GHINI || t->Type==NPCT_KEESE || t->Type==NPCT_FAIRY)
        return(false);
    return(true);
}

int IceLayer(npc f){
    if(Groundling(f)) return(3);
    return(5);
}

int icetransparency(){
    if(opaqueice) return(128);
    return(64);
}

bool CanFreeze(npc t){
    if(t->Type==NPCT_AQUAMENTUS || t->Type==NPCT_PEAHAT || t->Type==NPCT_ROCK || t->Type==NPCT_MOLDORM ||

t->Type==NPCT_MANHANDLA || t->Type==NPCT_GOHMA || t->Type==NPCT_LANMOLA || t->Type==NPCT_PATRA ||

t->Type==NPCT_SPINTILE) return(false);
    return(true);
}

void RandDir(npc r){
    int rdir = Rand(8);
    for(; rdir == r->Dir;){
        rdir = Rand(8);
    }
    r->Dir = rdir;
}

void IceTurn(npc me){
    int cornerx;
    int cornery;
    int colc;
    float SCheck = me->Step/100;
    int SDist = Round(SCheck);
    if(me->Dir == DIR_LEFT){
        cornerx = me->X-SDist;
        cornery = me->Y;
    }
    else if(me->Dir == DIR_LEFTUP){
        cornerx = me->X-SDist;
        cornery = me->Y-SDist;
    }
    else if(me->Dir == DIR_UP){
        cornerx = me->X;
        cornery = me->Y-SDist;
    }
    else if(me->Dir == DIR_RIGHTUP){
        cornerx = me->X+SDist;
        cornery = me->Y-SDist;
    }
    else if(me->Dir == DIR_RIGHT){
        cornerx = me->X+SDist;
        cornery = me->Y;
    }
    else if(me->Dir == DIR_RIGHTDOWN){
        cornerx = me->X+SDist;
        cornery = me->Y+SDist;
    }
    else if(me->Dir == DIR_DOWN){
        cornerx = me->X;
        cornery = me->Y+SDist;
    }
    else if(me->Dir == DIR_LEFTDOWN){
        cornerx = me->X-SDist;
        cornery = me->Y+SDist;
    }
    for(colc = 1; colc <= Screen->NumNPCs(); colc++){
        npc cc = Screen->LoadNPC(colc);
        if(cc->ID == iceblocknpc && RectCollision(cornerx+me->HitXOffset, cornery+me->HitYOffset,

cornerx+me->HitWidth+me->HitXOffset, cornery+me->HitHeight+me->HitYOffset, cc->X, cc->Y, cc->X+cc->HitWidth,

cc->Y+cc->HitHeight)){
            RandDir(me);
        }
    }
}



//Common Constant, only need to define once per script file.
const int SFX_ERROR = 57; //Set from Quest->Audio->SFX Data 
const int BIG_LINK  = 0;   //Set this constant to 1 if using the Large Link Hit Box feature.

//Constants used by Ice Combos
const int CT_ICECOMBO = 142; //The combo type "Script1 by default"
const int ICE_ACCELERATION = 1;
const int ICE_DECELERATION = 1;
const int ICE_MAXSTEP = 150;

//Declare global variables used by Ice Combos.
bool isScrolling;
bool onice;
float Ice_X;
float Ice_Y;
int Ice_XStep;
int Ice_YStep;
//End declaration

//Constants used by Bottomless Pits & Lava.
const int CT_HOLELAVA                     = 128; //Combo type to use for pit holes and lava."No Ground Enemies by default"
const int CF_PIT                                                                = 98;  //The combo flag to register combos as pits.
const int CF_LAVA                                                 = 99;  //The combo flag to register combos as lava.
const int WPS_LINK_FALL           = 88;  //The weapon sprite to display when Link falls into a pit. "Sprite 88 by default"
const int WPS_LINK_LAVA           = 89;  //The weapon sprite to display when Link drowns in lava. "Sprite 89 by default"
const int SFX_LINK_FALL           = 38;  //The sound to play when Link falls into a pit. "SFX_FALL by default"
const int SFX_LINK_LAVA           = 55;  //The sound to play when Link drowns in Lava. "SFX_SPLASH by default.
const int CMB_AUTOWARP                  = 888; //The first of your four transparent autowarp combos.
const int HOLELAVA_DAMAGE                 = 8;   //Damage in hit points to inflict on link. "One Heart Container is worth 16 hit points"

//Global variables used by Bottomless Pits & Lava.
int Falling;
bool Warping; //Determines if Link is being warped by a pit combo.

