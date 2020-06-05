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
    //Follower Variables
    int FollowerJustin = 32; //The number of the FFC used.  This script will "hijack" this one, so don't use it for anything else on screens when you expect the player to have a follower.
    int FollowerBrian = 31;
    int firstFollowerJustinCombo = 1592; //combo of the first combo.  In order, the concecutive combos must be "still up", "still down", "still left", "still right", "moving up", "moving down", "moving left", "moving right".
    int firstFollowerBrianCombo = 1584;
    int csetOfFollower = 6;
    bool firstCheck = false; //leave this alone
    int Follower;
    int firstFollowerCombo;
    int CharID;
    ffc follower;

    int pastX;
    int currentX;
    int followerX[13];

    int pastY;
    int currentY;
    int followerY[13];

    int index;
    int secretName[] = "Gabe"; // Up to 8 letters long
    int saveName[9];
    
    
    Game->GetSaveName(saveName);
if(strcmp(secretName, saveName) == 0 && Link->Item[Gabe] == false)
{
item UnlockGabe= Screen->CreateItem(Gabe);
UnlockGabe->X = Link->X;
UnlockGabe->Y = Link->Y;
UnlockGabe->Z = Link->Z;
}



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
                       
                       XPLevel();
                       GetXP();   
                       
    if(Link->Item[Brian] == true){
        CharID = Brian;
        Follower = FollowerJustin;
        firstFollowerCombo = firstFollowerJustinCombo;}
    else if(Link->Item[Justin] == true){
        CharID = Justin;
        Follower = FollowerBrian;
        firstFollowerCombo = firstFollowerBrianCombo;}
     if(Link->Item[CharID] == true){
        if(Link->Action != LA_SCROLLING && firstCheck == false){
        follower = Screen->LoadFFC(Follower);
        follower->Data = firstFollowerCombo;
        follower->CSet = csetOfFollower;

        pastX = Link->X;
        follower->X = Link->X;
        pastY = Link->Y;
        follower->Y = Link->Y;

        for ( int i = 0; i < 13; i++ ){
            followerX[i] = Link->X;
            followerY[i] = Link->Y;
        }

        firstCheck = true;
        }
        if(Link->Action != LA_SCROLLING){
        if((Link->InputUp || Link->InputDown || Link->InputRight || Link->InputLeft)&&(!(Link->InputA || Link->InputB))){
            pastX = follower->X;
            follower->X = followerX[0];
            for(index=0; index<12; index++){
            followerX[index] = followerX[index + 1];
            }
            followerX[12] = Link->X;

            pastY = follower->Y;
            follower->Y = followerY[0];
            for(index=0; index<12; index++){
            followerY[index] = followerY[index + 1];
            }
            followerY[12] = Link->Y;
        }

        if(follower->Y > pastY){
            follower->Data = firstFollowerCombo + 5;
        }
        else if(follower->Y < pastY){
            follower->Data = firstFollowerCombo + 4;
        }
        else if(follower->X > pastX){
            follower->Data = firstFollowerCombo + 7;
        }
        else if(follower->X < pastX){
            follower->Data = firstFollowerCombo + 6;
        }
        if(!(Link->InputUp || Link->InputDown || Link->InputRight || Link->InputLeft)){
            if((follower->Data == (firstFollowerCombo + 4))||(follower->Data == (firstFollowerCombo + 5))||(follower->Data == (firstFollowerCombo + 6))||(follower->Data == (firstFollowerCombo + 7))){
            follower->Data = follower->Data - 4;
            }
            else if((follower->Data == (firstFollowerCombo + 3))||(follower->Data == (firstFollowerCombo + 2))||(follower->Data == (firstFollowerCombo + 1))||(follower->Data == (firstFollowerCombo))){
                
            }
            else{
            follower->Data = firstFollowerCombo;
            }
        }
            }
        if(Link->Action == LA_SCROLLING){
        firstCheck = false;
            }
    }


   
                              //Waitdraw();
                              UpdateDrunkeness(); 
                                //Magic Container Piece Global
               
                //Magic Container checks
                for ( int i = 1; i <= Screen->NumItems(); i++){
                item drop = Screen->LoadItem(i);
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
                    
                    
                    //Character switching
            if (Link->Item[Brian] == true)
            {
                Link->Item[SmokeBreak] = true;
                Link->Item[BCharge] = true;
                Link->Item[BRing] = true;
                Link->Item[JSpin] = false;
                Link->Item[JRing] = false;
                Link->Item[Harmonica] = false;
                Link->Item[JSong1] = false;
                Link->Item[JSong2] = false;
                Link->Item[JSong3] = false;
                Link->Item[JSong4] = false;
                Link->Item[JSong5] = false;
                if (Link->Item[JGuitar1] == true)
                {
                    Link->Item[BGuitar1] = true;
                    Link->Item[JGuitar1] = false;
                }
                 if (Link->Item[JGuitar2] == true)
                {
                    Link->Item[BGuitar2] = true;
                    Link->Item[JGuitar2] = false;
                }
                if (Link->Item[JGuitar3] == true)
                {
                    Link->Item[BGuitar3] = true;
                    Link->Item[JGuitar3] = false;
                }
                 if (Link->Item[JGuitar4] == true)
                {
                    Link->Item[BGuitar4] = true;
                    Link->Item[JGuitar4] = false;
                }
            }
            if (Link->Item[Justin] == true)
            {
                Link->Item[SmokeBreak] = false;
                Link->Item[BCharge] = false;
                Link->Item[BRing] = false;
                Link->Item[JSpin] = true;
                Link->Item[JRing] = true;
                Link->Item[Harmonica] = true;
                Link->Item[BSong1] = false;
                Link->Item[BSong2] = false;
                Link->Item[BSong3] = false;
                Link->Item[BSong4] = false;
                Link->Item[BSong5] = false;                
                if (Link->Item[BGuitar1] == true)
                {
                    Link->Item[JGuitar1] = true;
                    Link->Item[BGuitar1] = false;
                }
                 if (Link->Item[BGuitar2] == true)
                {
                    Link->Item[JGuitar2] = true;
                    Link->Item[BGuitar2] = false;
                }
                if (Link->Item[BGuitar3] == true)
                {
                    Link->Item[JGuitar3] = true;
                    Link->Item[BGuitar3] = false;
                }
                 if (Link->Item[BGuitar4] == true)
                {
                    Link->Item[JGuitar4] = true;
                    Link->Item[BGuitar4] = false;
                }
                }
            if (Link->Item[Gabe] == true)
            
            
            {
                Link->Item[GRing1] = true;
                Link->Item[GRing2] = true;
                Link->Item[JSpin] = true;
                Link->Item[GRing3] = true;
                Link->Item[Harmonica] = true;
                Link->Item[SmokeBreak] = true;
            }
            
             if (Link->Item[Bullhorn] == true)
            {
                if ((Link->Item[BSong1Dummy] == true) && ((Link->Item[Brian] == true) || (Link->Item[Gabe] == true)))
                {
                    Link->Item[BSong1] = true;
                }
                if ((Link->Item[BSong2Dummy] == true) && ((Link->Item[Brian] == true) || (Link->Item[Gabe] == true)))
                {
                    Link->Item[BSong2] = true;
                }
                 if ((Link->Item[BSong3Dummy] == true) && ((Link->Item[Brian] == true) || (Link->Item[Gabe] == true)))
                {
                    Link->Item[BSong3] = true;
                }
                if ((Link->Item[BSong4Dummy] == true) && ((Link->Item[Brian] == true) || (Link->Item[Gabe] == true)))
                {
                    Link->Item[BSong4] = true;
                }    
                  if ((Link->Item[BSong5Dummy] == true) && ((Link->Item[Brian] == true) || (Link->Item[Gabe] == true)))
                {
                    Link->Item[BSong5] = true;
                }
                if ((Link->Item[JSong1Dummy] == true) && ((Link->Item[Justin] == true) || (Link->Item[Gabe] == true)))
                {
                    Link->Item[JSong1] = true;
                }
                if ((Link->Item[JSong2Dummy] == true) && ((Link->Item[Justin] == true) || (Link->Item[Gabe] == true)))
                {
                    Link->Item[JSong2] = true;
                }
                 if ((Link->Item[JSong3Dummy] == true) && ((Link->Item[Justin] == true) || (Link->Item[Gabe] == true)))
                {
                    Link->Item[JSong3] = true;
                }
                if ((Link->Item[JSong4Dummy] == true) && ((Link->Item[Justin] == true) || (Link->Item[Gabe] == true)))
                {
                    Link->Item[JSong4] = true;
                }    
                  if ((Link->Item[JSong5Dummy] == true) && ((Link->Item[Justin] == true) || (Link->Item[Gabe] == true)))
                {
                    Link->Item[JSong5] = true;
                }
                if (Link->Item[SSong1Dummy] == true)
                {
                    Link->Item[SSong1] = true;
                }
                if (Link->Item[SSong2Dummy] == true)
                {
                    Link->Item[SSong2] = true;
                }
                 if (Link->Item[SSong3Dummy] == true)
                {
                    Link->Item[SSong3] = true;
                }
                if (Link->Item[SSong4Dummy] == true)
                {
                    Link->Item[SSong4] = true;
                }    
                  if (Link->Item[SSong5Dummy] == true)
                {
                    Link->Item[SSong5] = true;
                }
            }
              
              else if (Link->Item[Bullhorn] == false)
                {
            
                    Link->Item[BSong1] = false;
                    Link->Item[BSong2] = false;
                    Link->Item[BSong3] = false;
                    Link->Item[BSong4] = false;
                    Link->Item[BSong5] = false;
                    Link->Item[JSong1] = false;
                    Link->Item[JSong2] = false;
                    Link->Item[JSong3] = false;
                    Link->Item[JSong4] = false;
                    Link->Item[JSong5] = false;
                    Link->Item[SSong1] = false;
                    Link->Item[SSong2] = false;
                    Link->Item[SSong3] = false;
                    Link->Item[SSong4] = false;
                    Link->Item[SSong5] = false;
            }
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
                              

void UpdateDrunkeness()
{
          int random_act = 0;

        if(Game->Counter[CR_DRUNKENESS] == 0 && Game->Counter[CR_BEER] > 0){
                Game->Counter[CR_BEER] = 0;
        }

          if(Link->Drunk > 0)
          {
                    Game->Counter[CR_DRUNKENESS]=Link->Drunk;
                    Link->Drunk=0;
          }

          if(Game->Counter[CR_DRUNKENESS]>0)
          {
                    Game->Counter[CR_DRUNKENESS]--;
                    Screen->FastCombo(DRUNK_ICON_LAYER, Link->X, Link->Y, DRUNK_ICON_COMBO, DRUNK_ICON_CSET, OP_OPAQUE);

                    if(Link->Misc[LM_DRUNKACT] > 0){
                              if(Link->Misc[LM_DRUNKACTTIME] > 0){
                                        Drunk_Action();
                                        Link->Misc[LM_DRUNKACTTIME]--;
                              }else{
                                        Link->Misc[LM_DRUNKACT] = 0;
                              }
                    }

                    // Game->Counter[CR_DRUNKENESS]%30 == 0 &&

                    if( Drunk_Effect() ) {
                              Link->Misc[LM_DRUNKACT] = Rand(15);
                              if(Link->Misc[LM_DRUNKACT] <= 11) Link->Misc[LM_DRUNKACTTIME] = 30;
                              else Link->Misc[LM_DRUNKACTTIME] = 0;

                              Drunk_Action();
                    }
          }
}

bool Drunk_Effect(){
    return (Rand(100) <= DRUNK_EFFECT_CHANCE * (Max(1,Game->Counter[CR_DRUNKENESS]/DRUNK_TIME)) );
}

void Drunk_Action(){
          int temp = 0;

          if(Link->Misc[LM_DRUNKACT] <= 3){
                    Link->Dir = Link->Misc[LM_DRUNKACT];
          }else if(Link->Misc[LM_DRUNKACT] <= 7){
                    if(Link->Misc[LM_DRUNKACT] == 4){
                              Link->InputDown = false;
                              Link->InputLeft = false;
                              Link->InputRight = false;

                              Link->InputUp = true;
                    }else if(Link->Misc[LM_DRUNKACT] == 5){
                              Link->InputUp = false;
                              Link->InputLeft = false;
                              Link->InputRight = false;

                              Link->InputDown = true;
                    }else if(Link->Misc[LM_DRUNKACT] == 6){
                              Link->InputUp = false;
                              Link->InputDown = false;
                              Link->InputRight = false;

                              Link->InputLeft = true;
                    }else{
                              Link->InputUp = false;
                              Link->InputDown = false;
                              Link->InputLeft = false;

                              Link->InputRight = true;
                    }

                    Link->Dir = Link->Misc[LM_DRUNKACT]-4;
          }else if(Link->Misc[LM_DRUNKACT] == 8){
                    Link->InputDown = false;
                    Link->InputLeft = false;
                    Link->InputRight = false;

                    temp = Link->Dir;
                    Link->InputUp;
                    Link->Dir = temp;
          }else if(Link->Misc[LM_DRUNKACT] == 9){
                    Link->InputUp = false;
                    Link->InputLeft = false;
                    Link->InputRight = false;

                    temp = Link->Dir;
                    Link->InputDown;
                    Link->Dir = temp;
          }else if(Link->Misc[LM_DRUNKACT] == 10){
                    Link->InputUp = false;
                    Link->InputDown = false;
                    Link->InputRight = false;

                    temp = Link->Dir;
                    Link->InputLeft;
                    Link->Dir = temp;
          }else if(Link->Misc[LM_DRUNKACT] == 11){
                    Link->InputUp = false;
                    Link->InputDown = false;
                    Link->InputLeft = false;

                    temp = Link->Dir;
                    Link->InputRight;
                    Link->Dir = temp;
          }else if(Link->Misc[LM_DRUNKACT] == 12){
                    Link->InputA = true;
          }else if(Link->Misc[LM_DRUNKACT] == 13){
                    Link->InputB = true;
          }else if(Link->Misc[LM_DRUNKACT] == 14){
                    Link->InputL = true;
          }else if(Link->Misc[LM_DRUNKACT] == 15){
                    Link->InputR = true;
          }
}
          