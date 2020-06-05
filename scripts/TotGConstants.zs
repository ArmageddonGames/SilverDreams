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

//Triforce Pieces
const int I_TFP = 144;
const int I_TFW = 145;
const int I_TFC = 146;
const int I_TFPW = 147;
const int I_TFCP = 148;
const int I_TFWC = 149;
const int I_TFWHOLE = 141;

//Magic Container Pieces
const int I_MCPNONE = 252;
const int I_MCPDUMMY = 143;
const int I_MCPIECE1 = 208;
const int I_MCPIECE2 = 209;
const int I_MCPIECE3 = 210;
const int I_MCPIECE4 = 211;

//Boomerangs
const int I_LEAFBOOMERANG = 237;
const int I_SPLASHBOOMERANG = 236;
const int I_GALEBOOMERANG = 235;
const int I_FREEZINGBOOMERANG = 234;
const int I_CLAYBOOMERANG = 233;
const int I_HOLYBOOMERANG = 232;
const int I_GRAVBOOMERANG = 231;
const int I_EGOBOOMERANG = 230;

//Arrows
const int I_FIREARROW = 229;
const int I_FORESTARROW = 228;
const int I_WATERARROW = 227;
const int I_WINDARROW = 226;
const int I_ICEARROW = 225;
const int I_EARTHARROW = 224;
const int I_LIGHTARROW = 223;
const int I_SHADOWARROW = 222;
const int I_SPIRITARROW = 221;

//Hammers
const int I_MAGMAHAMMER = 220;
const int I_WOODHAMMER = 219;
const int I_HYDROHAMMER = 218;
const int I_GUSTHAMMER = 217;
const int I_BLIZZARDHAMMER = 216;
const int I_STONEHAMMER = 215;
const int I_BLESSEDHAMMER = 214;
const int I_DARKHAMMER = 213;
const int I_CHAKRAHAMMER = 212;

//Shields
const int I_SHIELD4 = 134;

//Rafts
const int I_RAFT2 = 211;
const int I_RAFT3 = 210;
const int I_RAFT4 = 209;


// Return if this ffc collides with an lweapon that has the given
// misc attribute at the given value.
bool CollisionAllLWeapon(ffc this, int attrIndex, int attrValue) {
  for (int i = 1; i <= Screen->NumLWeapons(); i++) {
    lweapon lw = Screen->LoadLWeapon(i);
    if (lw->Misc[attrIndex] == attrValue && Collision(this, lw)) {
      return true;}}
  return false;}

//Quake Sword Constants
const int EQ_Point = 30;
const int EQ_Sound = 13;

//Wind Blade Constants
const int LW_GUST = 31;
const int EW_NOBLOWAWAY = 32;
const int LW_MISC_TIMEOUT = 7;
const int LW_MISC_PIERCE = 6;

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

int foriceone;
int foricetwo;
int foricethree;
int foricefour;

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


//Attack Ring constant/global
const int MISC_LW_BOOSTED = 0; //Which LWeapon->Misc[] variable to use (can't be used by another script)
float attackRingPower = 1; //Global variable; gets changed by attackRingPickup

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

