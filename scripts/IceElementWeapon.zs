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


global script slot2
{
    void run()
    {
    // Ice Rod Variables
    int foriceone;
    int foricetwo;
    int foricethree;
    int foricefour;


        //Main Loop
        while(true)
        { 
            
            //Wind Blade Global
            //Weapon checks
            for ( int i = Screen->NumLWeapons(); i > 0; i-- ){
                lweapon weap = Screen->LoadLWeapon(i);
                
                //Pierce
                if ( weap->Misc[LW_MISC_PIERCE] > 0 ){
                    weap->DeadState = WDS_ALIVE;
                }
                
                //Timeout
                if ( weap->Misc[LW_MISC_TIMEOUT] > 0 ){
                    weap->Misc[LW_MISC_TIMEOUT]--;
                    if ( weap->Misc[LW_MISC_TIMEOUT] <= 0 )
                        weap->DeadState = WDS_DEAD;
                }
                
                //Wind sword gust
                if ( weap->ID == LW_GUST ){
                    //Destroy weapons
                    for ( int j = Screen->NumEWeapons(); j > 0; j-- ){
                        eweapon eweap = Screen->LoadEWeapon(j);
                        if ( eweap->ID != EW_NOBLOWAWAY
                          && Collision(weap, eweap)
                        ){
                            eweap->DeadState = WDS_DEAD;
                            weap->DeadState = WDS_DEAD; //Kill weapon
                            break;
                        }
                    }
                    //Blow away enemies
                    for ( int j = Screen->NumNPCs(); j > 0; j-- ){
                        if ( !weap->isValid() )
                            break;
                        npc enem = Screen->LoadNPC(j); //Load enemy
                        if ( enem->Z <= 0 && Collision ( enem, weap ) ){ //If touching shockwave
                            int size = (enem->HitHeight/16) * (enem->HitWidth/16); //Larger enemies have less effect
                            enem->Stun = 60/size; //Stun it
                            enem->Jump = 3/size; //Throw into the air
                            enem->Dir = Link->Dir; //Move in Link's direction (away from him)
                            
                            weap->DeadState = WDS_DEAD; //Kill weapon
                        }
                    }
                }
            }
            //Ice Rod Global
            for(foriceone = 1; foriceone <= Screen->NumLWeapons(); foriceone++){
            lweapon tweapon = Screen->LoadLWeapon(foriceone);
            if(tweapon->Misc[4] == 42){
                for(foricetwo = 1; foricetwo <= Screen->NumNPCs(); foricetwo++){
                    npc tnpc = Screen->LoadNPC(foricetwo);
                    if(RectCollision(tweapon->X, tweapon->Y, tweapon->X+15, tweapon->Y+15,

tnpc->X+tnpc->HitXOffset, tnpc->Y+tnpc->HitYOffset, tnpc->X+tnpc->HitXOffset+tnpc->HitWidth,

tnpc->Y+tnpc->HitYOffset+tnpc->HitHeight)){
                        Game->PlaySound(freezesound);
                        if(CanFreeze(tnpc) && tnpc->ID != iceblocknpc){
                            tnpc->HP -= tweapon->Misc[10];
                            if(tnpc->HP<=0){
                                tnpc->HP=500;
                                tnpc->Misc[12]=145;
                            }
                            else tnpc->Misc[12] = 144;
                            tnpc->Stun = Stunframes+1;
                            npc IceCol = Screen->CreateNPC(iceblocknpc);
                                IceCol->X = tnpc->X-8;
                                IceCol->Y = tnpc->Y-8;
                                if(tnpc->TileHeight == 2 && tnpc->TileWidth == 2){
                                    IceCol->HitHeight = 48;
                                    IceCol->HitWidth = 48;
                                }
                                else{
                                    IceCol->HitHeight = 32;
                                    IceCol->HitWidth = 32;
                                }
                        }
                        tweapon->DeadState = WDS_DEAD;
                    }
                }
            }
        }
        for(foricethree = 1; foricethree <= Screen->NumNPCs(); foricethree++){
            npc itnpc = Screen->LoadNPC(foricethree);
            if(itnpc->Misc[12] == 144 || itnpc->Misc[12] == 145){
                if(itnpc->Stun > 1){
                    itnpc->CollDetection = false;
                    if(itnpc->TileWidth == 2 && itnpc->TileHeight == 2){
                        Screen->DrawTile(IceLayer(itnpc), itnpc->X-8, itnpc->Y-8, threebythreeice, 3, 3,

icecset, -1, -1, 0, 0, 0, 0, true, icetransparency());
                    }
                    else{
                        Screen->DrawTile(IceLayer(itnpc), itnpc->X-8, itnpc->Y-8, twobytwoice, 2, 2, icecset,

-1, -1, 0, 0, 0, 0, true, icetransparency());
                    }
                }
                else{
                    itnpc->CollDetection = true;
                    lweapon Melt = Screen->CreateLWeapon(EW_SCRIPT1);
                        Melt->X = itnpc->X;
                        Melt->Y = itnpc->Y;
                        Melt->DrawStyle = DS_CLOAKED;
                    for(foricefour = 1; foricefour <= Screen->NumNPCs(); foricefour++){
                        npc ibnpc = Screen->LoadNPC(foricefour);
                        if(Collision(Melt, ibnpc) && ibnpc->ID == iceblocknpc){
                            ibnpc->X = 256;
                            ibnpc->Y = 176;
                            ibnpc->HP = 0;
                        }
                    }
                    Melt->DeadState = WDS_DEAD;
                    if(itnpc->Misc[12]==145) itnpc->HP=0;
                }
            }
            else{
                IceTurn(itnpc);
            }
        }
        
      Waitframe();
        }
    }
}





//D0 is the Sprite of the LWeapon, D1 is the ItemId, D2 is MP cost and D3 is LWeapon Type
item script IceElemental //Modified Ice rod, to allow it to be attached to any LWeapon type
{
    void run(int sprite, int thisItemId, int cost, int weapon)
    {
        //LastItemUsed = thisItemId; //This is added in for use with another script.
        if (Game->Counter[CR_MAGIC] > cost)
        {
        Game->Counter[CR_MAGIC] -= cost;
        lweapon Ice = NextToLink(weapon, 1);
            Ice->Dir = Link->Dir;
            Ice->Misc[4] = 42;
            Ice->Misc[10] = 2;
            Ice->CollDetection=false;
            
    }

        else{
        Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR Sound Effects.
    }
    }
}
