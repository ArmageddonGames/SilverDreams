global script slot2
{
          void run()
          {
             
    
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
    

                    while(true)
                    { 
                       
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
               Waitframe(); 
          }
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
          