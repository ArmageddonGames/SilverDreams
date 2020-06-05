global script active{
    void run(){
        Link->Invisible = false;
        while(true){
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
        
            //THIS REPLACES YOUR NORMAL WAITFRAME()
            //Any other scripts that check screen changes can share this section
            if ( WaitframeCheckScreenChange() ){
                createWarpPointFFC(); //If screen changed, try to create warp point
            }
        }
    }
}