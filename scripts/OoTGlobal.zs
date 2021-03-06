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


        //Main Loop
        while(true)
        { 
         
            Update_HotRoom();
        
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
      Waitdraw();
            //Attack Ring global
            for(int i = 1; i <= Screen->NumLWeapons(); i++){
                lweapon weap = Screen->LoadLWeapon(i);
                if(weap->ID != LW_SWORD && weap->Misc[MISC_LW_BOOSTED] == 0){
                    weap->Damage *= attackRingPower;
                    weap->Misc[MISC_LW_BOOSTED] = 1;
                }
            }
            
            //Generic Trigger Global
             for (int i = 1; i <= Screen->NumLWeapons(); i++) {
        lweapon lw = Screen->LoadLWeapon(i);
        if (lw->Misc[LWEAPON_MISC_SOURCE] == 0) {
          lw->Misc[LWEAPON_MISC_SOURCE] = LastItemUsed;}}
          
        
            
            //Stops enemies from dropping ammunition items that Link doesn't have a way to carry (Bomb bag, quiver, etc.).
            for ( int i = 1; i <= Screen->NumItems(); i++){
                item drop = Screen->LoadItem(i);
                if ( (drop->ID == I_ARROWAMMO1 && !Link->Item[I_QUIVER1])
                        || ( drop->ID == I_ARROWAMMO10 && !Link->Item[I_QUIVER1])
                        || ( drop->ID == I_ARROWAMMO30 && !Link->Item[I_QUIVER1])
                        || ( drop->ID == I_ARROWAMMO5 && !Link->Item[I_QUIVER1])
                        || ( drop->ID == I_BOMBAMMO1 && !Link->Item[I_BOMBBAG1])
                        || ( drop->ID == I_BOMBAMMO4 && !Link->Item[I_BOMBBAG1])
                        || ( drop->ID == I_BOMBAMMO8 && !Link->Item[I_BOMBBAG1])
                        || ( drop->ID == I_BOMBAMMO30 && !Link->Item[I_BOMBBAG1])
                        || ( drop->ID == I_GORONTUNIC && !Link->Item[I_ADULTLINK])
                        || ( drop->ID == I_FLIPPERS && !Link->Item[I_ADULTLINK]))
                Remove (drop);
                
              
                        //Triforce Check
                if ( (drop->ID == I_TFP && Link->Item[I_TFW]))
                drop->ID = I_TFPW;
                if ( (drop->ID == I_TFC && Link->Item[I_TFP]))
                drop->ID = I_TFCP;
                if ( (drop->ID == I_TFW && Link->Item[I_TFP]))
                drop->ID = I_TFPW;
                if ( (drop->ID == I_TFP && Link->Item[I_TFC]))
                drop->ID = I_TFCP;
                if ( (drop->ID == I_TFC && Link->Item[I_TFW]))
                drop->ID = I_TFWC;
                if ( (drop->ID == I_TFW && Link->Item[I_TFC]))
                drop->ID = I_TFWC;
                if ( (drop->ID == I_TFP && Link->Item[I_TFWC]))
                drop->ID = I_TFWHOLE;
                if ( (drop->ID == I_TFC && Link->Item[I_TFPW]))
                drop->ID = I_TFWHOLE;
                if ( (drop->ID == I_TFW && Link->Item[I_TFCP]))
                drop->ID = I_TFWHOLE;
                
                        
                        //Magic Container Piece Global
               
                //Magic Container checks
                if ( (drop->ID == I_MCPDUMMY))
                drop->ID = I_MCPIECE1; 
                if ( (drop->ID == I_MCPIECE1 && Link->Item[I_MCPIECE1]))
                drop->ID = I_MCPIECE2;
                if ( (drop->ID == I_MCPIECE2 && Link->Item[I_MCPIECE2]))
                drop->ID = I_MCPIECE3;
                if ( (drop->ID == I_MCPIECE3 && Link->Item[I_MCPIECE3]))
                drop->ID = I_MCPIECE4;
            
           
            
            }
            if      ( (Link->Item[I_MCPIECE1] == true) &&  //Manually enter item number for MC_1.
                    (Link->Item[I_MCPIECE2] == true) && //Manually enter item number for MC_2.
                    (Link->Item[I_MCPIECE3] == true) && //Manually enter item number for MC_3.
                    (Link->Item[I_MCPIECE4] == true) ) //Manually enter item number for MC_4.

                      //If Link has four Magic Containers
                    {
                        Link->Item[I_MCPIECE1] = false; //Removes MPC1; Manually enter item number for MC_1.
                        Link->Item[I_MCPIECE2] = false; //Removes MCP2; Manually enter item number for MC_2.
                        Link->Item[I_MCPIECE3] = false; //Removes MCP3; Manually enter item number for MC_3.
                        Link->Item[I_MCPIECE4] = false; //Removes MCP4; Manually enter item number for MC_4.
                        item MCWhole = Screen->CreateItem(I_MAGICCONTAINER); //Gives link a whole MC.
                        MCWhole->X = Link->X;
                        MCWhole->Y = Link->Y;
                        MCWhole->Z = Link->Z;
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
                    ScreenFreeze();
                    
                    //Let it finish
                    while(anim->isValid())
                        WaitNoAction();
                    
                    //Animation done; set warp point
                    ScreenUnfreeze();
                    
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
                    ScreenFreeze();
                    
                    //Let it finish
                    while(anim->isValid())
                        WaitNoAction();
                    
                    //Animation done; warp
                    ScreenUnfreeze();
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
        
            
                    
            
            if(Link->Action != LA_SCROLLING)
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
void ScreenFreeze()
{
    ffc ScreenFreeze1 = Screen->LoadFFC(32);
    ScreenFreeze1->Data = 1114;
    ffc ScreenFreeze2 = Screen->LoadFFC(31);
    ScreenFreeze2->Data = 1115;
}

void ScreenUnfreeze()
{
    ffc ScreenUnfreeze1 = Screen->LoadFFC(32);
    ScreenUnfreeze1->Data = 0;
    ffc ScreenUnfreeze2 = Screen->LoadFFC(31);
    ScreenUnfreeze2->Data = 0; 
}

void Update_HotRoom()
{
    if(Link->Item[I_GORONTUNIC])
    {
        hotroominit = false;
        if((Screen->Flags[SF_MISC] & 4<<HOTROOM_FLAG)!=0)
        {
             Link->Item[I_RING2] = true;
        }
        else
        {
             Link->Item[I_RING2] = false;
        }
        return;
    }
    else if((Screen->Flags[SF_MISC] & 4<<HOTROOM_FLAG)!=0)
    {
        if(hotroominit)
        {
            Game->Counter[CR_SECONDS] = (Game->Counter[CR_SECONDS] + 1)%60;
            if(Game->Counter[CR_SECONDS] == 0) hotroomtimer--;
        }
        else hotroomtimer = HOTROOM_TIME;
        hotroominit = true;
        if(hotroomtimer == 0)
        {
            hotroominit = false;
            Link->HP = 0;
            Quit();
        }
    }
    else
    {
        hotroominit = false;
        hotroomtimer = 0;
        return;
    }
    if(hotroominit)
    {
        //Create an array of characters.
        int string[5];
        //Add the minutes to the array.
        itoa(string, 0, Div(hotroomtimer, 60));
        //Add the : after the minutes.
        string[strlen(string)] = ':';
        //Add the seconds after the colon.
        int seconds = hotroomtimer % 60;
        if(seconds < 10) string[strlen(string)] = '0';
        itoa(string, strlen(string), seconds);
        //Draw the timer to the screen.
        Screen->DrawString(7, 0, 0, FONT_DEF, SOLID_WHITE, SOLID_BLACK, TF_NORMAL, string, 128);
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