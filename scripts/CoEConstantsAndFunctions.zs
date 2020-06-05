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



//Wind Blade Constants
const int LW_GUST = 31;
const int EW_NOBLOWAWAY = 32;
const int LW_MISC_TIMEOUT = 7;
const int LW_MISC_PIERCE = 6;

  
//Attack Ring constant/global
const int MISC_LW_BOOSTED = 0; //Which LWeapon->Misc[] variable to use (can't be used by another script)
float attackRingPower = 1; //Global variable; gets changed by attackRingPickup



 

 
 

 
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
const int CF_PIT                                                                = 101;  //The combo flag to register combos as pits.
const int CF_LAVA                                                 = 102;  //The combo flag to register combos as lava.
const int WPS_LINK_FALL           = 88;  //The weapon sprite to display when Link falls into a pit. "Sprite 88 by default"
const int WPS_LINK_LAVA           = 89;  //The weapon sprite to display when Link drowns in lava. "Sprite 89 by default"
const int SFX_LINK_FALL           = 38;  //The sound to play when Link falls into a pit. "SFX_FALL by default"
const int SFX_LINK_LAVA           = 55;  //The sound to play when Link drowns in Lava. "SFX_SPLASH by default.
const int CMB_AUTOWARP                  = 888; //The first of your four transparent autowarp combos.
const int HOLELAVA_DAMAGE                 = 8;   //Damage in hit points to inflict on link. "One Heart Container is worth 16 hit points"

//Global variables used by Bottomless Pits & Lava.
int Falling;
bool Warping; //Determines if Link is being warped by a pit combo.

float SwordDamage;
float Damage; 
const int SwordPower = 122;

void ModItemPower(int itm, int pow)
    {
        itemdata id = Game->LoadItemData(itm);
        id->Power = pow;
    }

const int CR_COPPER = 7;
const int CR_SILVER = 8;
const int CR_BREAD = 9;
const int CR_MEAT = 10;
const int CR_ALE = 11;
const int CR_HP = 12;
const int CR_MAXHP = 13;
const int CR_SP = 14;
const int CR_MAXSP = 15;
const int CR_MP = 16;
const int CR_MAXMP = 17;
const int CR_XP = 18;
const int CR_MAXXP = 19;
const int CR_LV = 20;
const int CR_STRENGTH = 21;
const int CR_INTELLECT = 22;
const int CR_DEXTERITY = 23;
const int CR_CHARISMA = 24;
const int CR_MAXCOIN = 25;
const int CR_LUCK = 26;

int HP_PERCENT = 100;
int SP_PERCENT = 100;
int MP_PERCENT = 100;
int XP_PERCENT = 100;
int CritChance;  
int BotchRoll;
int SwMinDam;
int SwMaxDam;
int MinDam;
int MaxDam;


// Set this to the font colour you want. It is set to 1 (white) by default.
const int DMG_FONTCOL=1;
// Set this to three different unused slots for the npc->Misc[] values. If you don't have any other script using those, the default values are fine.
const int DMG_MISC1=1;
const int DMG_MISC2=2;
const int DMG_MISC3=3;

void EnemyDamage(){
int offset;
for(int i=1;i<=Screen->NumNPCs();i++){
  npc enem=Screen->LoadNPC(i);
  if(enem->Misc[DMG_MISC1]==0){
   enem->Misc[DMG_MISC1]=1;
   enem->Misc[DMG_MISC2]=enem->HP;
   enem->Misc[DMG_MISC3]=0;
  }
  if(enem->Misc[DMG_MISC1]!=0&&enem->HP<enem->Misc[DMG_MISC2]){
   enem->Misc[DMG_MISC1]=45;
   enem->Misc[DMG_MISC3]=enem->Misc[DMG_MISC2]-enem->HP;
   enem->Misc[DMG_MISC2]=enem->HP;
  }
  if(enem->Misc[DMG_MISC1]>1){
   if(enem->Misc[DMG_MISC3]>9){offset=0;}
   else{offset=4;}
   if(enem->Misc[DMG_MISC1]%3!=0)Screen->DrawInteger(6, enem->X+offset, enem->Y-18+(enem->Misc[DMG_MISC1]/5), FONT_Z1, DMG_FONTCOL, -1, -1, -1, enem->Misc[DMG_MISC3], 0, 128);
   enem->Misc[DMG_MISC1]--;
  }
}
}
   


void SwordBotch()
{     
    BotchRoll = Rand(1,20);
    if (BotchRoll == 1)
    {
        Link->HP -= (SwMaxDam * 2);
    }
    else if (BotchRoll == 2)
    {
        Link->HP -= SwMaxDam;
    }
    else if ((BotchRoll >= 3) && (BotchRoll <= 4))
    {
        Link->HP -= Rand((SwMinDam + 1), (SwMaxDam - 1));
    }
    else if ((BotchRoll >= 5) && (BotchRoll <= 6))
    {
        Link->HP -= SwMinDam;
    }
    else if (BotchRoll == 7)
    {
        Game->Counter[CR_SP] -= (SwMaxDam *2); 
    }
    else if (BotchRoll == 8)
    {
        Game->Counter[CR_SP] -= SwMaxDam; 
    }
    else if ((BotchRoll >= 9) && (BotchRoll <= 10))
    {
        Game->Counter[CR_SP] -= Rand((SwMinDam + 1), (SwMaxDam - 1));
    }
    else if ((BotchRoll >= 11) && (BotchRoll <= 12))
    {
        Game->Counter[CR_SP] -= SwMinDam; 
    }
    else if ((BotchRoll >= 13) && (BotchRoll <= 16))
    {
        return;
    }
    else if (BotchRoll == 17) 
    {
        Link->Drunk = 1800;
    }
    else if (BotchRoll == 18)
    {
        Damage = (Rand(SwMinDam, SwMaxDam) * 0.5);
    }    
    else if (BotchRoll == 19)
    {
        Damage = Rand(SwMinDam, SwMaxDam);
    }
    else if (BotchRoll == 20)
    {
        Damage = (Rand(SwMinDam, SwMaxDam) * 2);
    }
}

void Botch()
{     
    BotchRoll = Rand(1,20);
    if (BotchRoll == 1)
    {
        Link->HP -= (MaxDam * 2);
    }
    else if (BotchRoll == 2)
    {
        Link->HP -= MaxDam;
    }
    else if ((BotchRoll >= 3) && (BotchRoll <= 4))
    {
        Link->HP -= Rand((MinDam + 1), (MaxDam - 1));
    }
    else if ((BotchRoll >= 5) && (BotchRoll <= 6))
    {
        Link->HP -= MinDam;
    }
    else if (BotchRoll == 7)
    {
        Game->Counter[CR_SP] -= (MaxDam *2); 
    }
    else if (BotchRoll == 8)
    {
        Game->Counter[CR_SP] -= MaxDam; 
    }
    else if ((BotchRoll >= 9) && (BotchRoll <= 10))
    {
        Game->Counter[CR_SP] -= Rand((MinDam + 1), (MaxDam - 1));
    }
    else if ((BotchRoll >= 11) && (BotchRoll <= 12))
    {
        Game->Counter[CR_SP] -= MinDam; 
    }
    else if ((BotchRoll >= 13) && (BotchRoll <= 16))
    {
        return;
    }
    else if (BotchRoll == 17) 
    {
        Link->Drunk = 1800;
    }
    else if (BotchRoll == 18)
    {
        Damage = (Rand(MinDam, MaxDam) * 0.5);
    }    
    else if (BotchRoll == 19)
    {
        Damage = Rand(MinDam, MaxDam);
    }
    else if (BotchRoll == 20)
    {
        Damage = (Rand(MinDam, MaxDam) * 2);
    }
}
