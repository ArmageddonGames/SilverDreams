const int FLIPPERS_2 = 143;

global script slot2
{
          void run()
          {
           
     
    //Initialize variables used to store Link's strating position on Screen Init.
    int olddmap = Game->GetCurDMap();
    int oldscreen = Game->GetCurDMapScreen();
    int startx = Link->X;
    int starty = Link->Y;
    int startdir = Link->Dir;

    //Clear global variables used by Bottomless pits.
    Falling = 0;
    Warping = false;
        
    //Global variables for Farore's Wind
    int faroresWindTimer = 0;
    Link->Invisible = false;        
    // Ice Rod Variables
    int foriceone;
    int foricetwo;
    int foricethree;
    int foricefour;
    int SwimTimer = (Game->Counter[CR_SP] * 20);
    int LifeTimer = (Link->HP * 20);
        //Main Loop
        while(true)
        { 
            EnemyDamage();
            LimitEnemies(30);
            //Drawing Meters
            //For meters
        Game->Counter[CR_MAXCOIN] = Game->MCounter[CR_RUPEES];
        Game->MCounter[CR_COPPER] = (Game->MCounter[CR_RUPEES] - Game->Counter[CR_SILVER] - Game->Counter[CR_RUPEES]);
        Game->MCounter[CR_SILVER] = (Game->MCounter[CR_RUPEES] - Game->Counter[CR_COPPER] - Game->Counter[CR_RUPEES]);
        Game->MCounter[CR_RUPEES] = (Game->MCounter[CR_RUPEES] - Game->Counter[CR_SILVER] - Game->Counter[CR_COPPER]); 
        Game->Counter[CR_HP] = Link->HP;
        Game->Counter[CR_MP] = Link->MP;
        Game->Counter[CR_MAXHP] = Link->MaxHP;
        Game->Counter[CR_MAXMP] = Link->MaxMP;
        //int HP_PERCENT = ((Game->MCounter[CR_LIFE] * 0.01) * Game->Counter[CR_LIFE]);
        //int SP_PERCENT = ((Game->MCounter[CR_SP] * 0.01) * Game->Counter[CR_SP]);
        //int MP_PERCENT = ((Game->MCounter[CR_MAGIC] * 0.01) * Game->Counter[CR_MAGIC]);
        //int XP_PERCENT = ((Game->MCounter[CR_XP] * 0.01) * Game->Counter[CR_XP]);
        int HP_PERCENT = (((Game->Counter[CR_LIFE]) / Game->MCounter[CR_LIFE]) * 100);
        int SP_PERCENT = (((Game->Counter[CR_SP]) / Game->MCounter[CR_SP]) * 100);
        int MP_PERCENT = (((Game->Counter[CR_MAGIC]) / Game->MCounter[CR_MAGIC]) * 100);
        int XP_PERCENT = (((Game->Counter[CR_MAXXP]) / Game->MCounter[CR_XP]) * 100);
            Screen->Rectangle(7, 6, -47, (6 + HP_PERCENT), -44, 129, 1, 0, 0, 0, true, OP_OPAQUE);
            Screen->Rectangle(7, 6, -34, (6 + SP_PERCENT), -31, 81, 1, 0, 0, 0, true, OP_OPAQUE);
            Screen->Rectangle(7, 6, -22, (6 + MP_PERCENT), -19, 113, 1, 0, 0, 0, true, OP_OPAQUE);
            Screen->Rectangle(7, 6, -11, (6 + XP_PERCENT), -7, 127, 1, 0, 0, 0, true, OP_OPAQUE);
            Screen->DrawTile(7, 0, -53, 41600, 7, 1, 8, -1, -1, 0, 0, 0, 0, true, OP_OPAQUE);
            Screen->DrawTile(7, 0, -40, 41600, 7, 1, 8, -1, -1, 0, 0, 0, 0, true, OP_OPAQUE);
            Screen->DrawTile(7, 0, -28, 41600, 7, 1, 8, -1, -1, 0, 0, 0, 0, true, OP_OPAQUE);
            Screen->DrawTile(7, 0, -16, 41600, 7, 1, 8, -1, -1, 0, 0, 0, 0, true, OP_OPAQUE);
            
           
//Swim Meter system; currently bugged, swim timer doesn't reset
if ((Link->Action == LA_SWIMMING) && (Link->Item[FLIPPERS_2] == false))
{
    
    if (Game->Counter[CR_SP] > 0)
    {
        Game->Counter[CR_SP] -=1;
    }
    else if (Game->Counter[CR_SP] <= 0)
    {
        Link->Action = LA_DROWNING;
        
    }
}
            
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
                       



   
                              //Waitdraw();
                               
            //Generic Trigger Global
             for (int i = 1; i <= Screen->NumLWeapons(); i++) 
             {
        lweapon lw = Screen->LoadLWeapon(i);
        if (lw->Misc[LWEAPON_MISC_SOURCE] == 0) 
        {
          lw->Misc[LWEAPON_MISC_SOURCE] = LastItemUsed;
          }
          }
     //Implement cooldown for Farore's Wind
            if ( faroresWindTimer > 0 )
                faroresWindTimer--;
            
            //If Farores Wind was called by item script
            if ( fwData[FWD_ACTIVE] != 0 ){
                //No warp point set: set one
                if ( fwData[FWD_DMAP] < 0 ){
                    //Start animation (sprite above Link)
                    Game->PlaySound(SFX_FARORESWINDSET);
                    lweapon anim = CreateLWeaponAt(LW_SPARKLE, Link->X, Link->Y-16);
                    anim->UseSprite(WPS_FARORESWINDSET);
                    freezeScreen();
                    
                    //Let it finish
                    while(anim->isValid())
                        WaitNoAction();
                    
                    //Animation done; set warp point
                    unfreezeScreen();
                    
                    //Store warp point data
                    fwData[FWD_DMAP] = Game->GetCurDMap();
                    fwData[FWD_SCREEN] = Game->GetCurDMapScreen();
                    fwData[FWD_X] = Link->X;
                    fwData[FWD_Y] = Link->Y;
                    fwData[FWD_ACTIVE] = 0;
                    
                    createWarpPointFFC();
                }
                
                //Warp point set: warp to it
                else{
                    //Start animation (sprite replaces Link)
                    Game->PlaySound(SFX_FARORESWINDWARP);
                    lweapon anim = CreateLWeaponAt(LW_SPARKLE, Link->X, Link->Y);
                    anim->UseSprite(WPS_FARORESWINDWARP);
                    Link->Invisible = true;
                    freezeScreen();
                    
                    //Let it finish
                    while(anim->isValid())
                        WaitNoAction();
                    
                    //Animation done; warp
                    unfreezeScreen();
                    Link->Invisible = false;
                    Screen->SetSideWarp(0, fwData[FWD_SCREEN], fwData[FWD_DMAP], WT_IWARPWAVE);
                    ffc warpFFC = loadUnusedFFC(true);
                    warpFFC->Data = CMB_AUTOW2;
                    
                    //Wait for warp to take place (warp pauses global script), then place Link
                    Waitframe();
                    Link->X = fwData[FWD_X];
                    Link->Y = fwData[FWD_Y];
                    
                    //Un-set warp
                    fwData[FWD_DMAP] = -1;
                }
                
                fwData[FWD_ACTIVE] = 0;
            }
        
            
                    
            
            if ((Link->Action != LA_SCROLLING) && (Link->Action !=LA_RAFTING))
            {
                Update_HoleLava(startx, starty, olddmap, oldscreen, startdir);
                if(Link->Z==0 && !Falling && (oldscreen != Game->GetCurDMapScreen() || olddmap != Game->GetCurDMap()))
                {
                    olddmap = Game->GetCurDMap();
                    oldscreen = Game->GetCurDMapScreen();
                    startx = Link->X;
                    starty = Link->Y;
                    startdir = Link->Dir;
                }
            }
   //THIS REPLACES YOUR NORMAL WAITFRAME()
            //Any other scripts that check screen changes can share this section
            if ( WaitframeCheckScreenChange() ){
                createWarpPointFFC(); //If screen changed, try to create warp point
            }
        }
    }
}


void createWarpPointFFC(){
    if ( Game->GetCurDMap() == fwData[FWD_DMAP] //If on warp point DMap/screen
        && Game->GetCurDMapScreen() == fwData[FWD_SCREEN]
    ){
        ffc warpPointFFC = loadUnusedFFC(false); //Get an unused FFC
        
        if ( !ffcIsBlank(warpPointFFC) ) //If non-blank FFC, quit now
            return;
            
        //Place the FFC
        warpPointFFC->Data = CMB_WARPPOINT;
        warpPointFFC->X = fwData[FWD_X];
        warpPointFFC->Y = fwData[FWD_Y];
    }
}   
    //Handles Pit Combo Functionality.
    void Update_HoleLava(int x, int y, int dmap, int scr, int dir)
    {
        lweapon hookshot = LoadLWeaponOf(LW_HOOKSHOT);
        if(hookshot->isValid()) return;

        if(Falling)
        {
            Falling--;
            if(Falling == 1)
            {
                int buffer[] = "holelava";
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
                              
