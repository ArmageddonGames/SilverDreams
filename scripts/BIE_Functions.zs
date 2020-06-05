void DayNightCycle()
{
    dmapdata dm = Game->LoadDMapData(Game->GetCurDMap());
    int type = dm->Type; TraceNL(); TraceS("Detected DMap Type: "); Trace(type); 
    
if ( type == DMT_INTERIOR )
    {
        return;
    }
if ( type == DMT_DUNGEON )
    {
        return;
    } 
else
    {
if ((InGameClock[CLOCK_HOURS] >= 6) && (InGameClock[CLOCK_HOURS] < 7) && (CYCLE != SUNRISE))
{
    CYCLE = SUNRISE;
    Game->DMapPalette[CURRENTDMAP] = SUNRISET_PAL;
}
else if ((InGameClock[CLOCK_HOURS] >= 7) && (InGameClock[CLOCK_HOURS] < 19) && (CYCLE != DAY))
{
    CYCLE = DAY;
    Game->DMapPalette[CURRENTDMAP] = DAY_PAL;
}
else if ((InGameClock[CLOCK_HOURS] >= 19) && (InGameClock[CLOCK_HOURS] < 20) && (CYCLE != SUNSET))
{
    CYCLE = SUNSET;
    Game->DMapPalette[CURRENTDMAP] = SUNRISET_PAL;
}
else if (CYCLE != NIGHT)
{
    CYCLE = NIGHT;
    Game->DMapPalette[CURRENTDMAP] = NIGHT_PAL;
}   
}
}

void InGameClock()
{
        InGameClock[CLOCK_SECONDS] +=2;
    if ( InGameClock[CLOCK_SECONDS] == 60 ) 
    {
        InGameClock[CLOCK_SECONDS] = 0;
        InGameClock[CLOCK_MINUTES] +=1;
    }
    if ( InGameClock[CLOCK_MINUTES] == 60 ) 
    {
        InGameClock[CLOCK_MINUTES] = 0;
        InGameClock[CLOCK_HOURS] +=1;
    }
    if ( InGameClock[CLOCK_HOURS] == 24 ) 
    {
        InGameClock[CLOCK_HOURS] = 0;
        InGameClock[CLOCK_DAYS] +=1;
    }
}

void SwitchCharacters()
{
        if (Link->Item[PartySwitcher] == true && Link->PressEx2)
        {
            if (Link->Item[Binx] == true)
                {
                Link->Item[Caroline] = true;
                Link->Item[Binx] = false;
                }
                
            else if (Link->Item[Caroline] == true)
                {
                Link->Item[Caroline] = false;
                Link->Item[Binx] = true;
                }
        }
}

void Ex1Jump()
{
    if (Link->Z == 0 && Link->PressEx1)
            {
                Game->PlaySound(SFX_JUMP);
                Link->Jump = 2;
            }
}

void AdventureParty()
{
    //Follower global
    if(Link->Item[Binx] == true && Link->Item[PartySwitcher] == true)
    {
        if(Link->Action != LA_SCROLLING && firstCheck == false)
        {
        follower = Screen->LoadFFC(FollowerCaroline);
        follower->Data = firstFollowerCarolineCombo;
        follower->CSet = csetOfFollowerCaroline;

        pastX = Link->X;
        follower->X = Link->X;
        pastY = Link->Y;
        follower->Y = Link->Y;

        for ( int i = 0; i < 13; i++ )
        {
            followerX[i] = Link->X;
            followerY[i] = Link->Y;
        }

        firstCheck = true;
        }
        if(Link->Action != LA_SCROLLING)
        {
        if((Link->InputUp || Link->InputDown || Link->InputRight || Link->InputLeft)&&(!(Link->InputA || Link->InputB))){
            pastX = follower->X;
            follower->X = followerX[0];
            for(index=0; index<12; index++)
            {
            followerX[index] = followerX[index + 1];
            }
            followerX[12] = Link->X;

            pastY = follower->Y;
            follower->Y = followerY[0];
            for(index=0; index<12; index++)
            {
            followerY[index] = followerY[index + 1];
            }
            followerY[12] = Link->Y;
        }

        if(follower->Y > pastY)
        {
            follower->Data = firstFollowerCarolineCombo + 5;
        }
        else if(follower->Y < pastY)
        {
            follower->Data = firstFollowerCarolineCombo + 4;
        }
        else if(follower->X > pastX)
        {
            follower->Data = firstFollowerCarolineCombo + 7;
        }
        else if(follower->X < pastX)
        {
            follower->Data = firstFollowerCarolineCombo + 6;
        }
        if(!(Link->InputUp || Link->InputDown || Link->InputRight || Link->InputLeft))
        {
            if((follower->Data == (firstFollowerCarolineCombo + 4))||(follower->Data == (firstFollowerCarolineCombo + 5))||(follower->Data == (firstFollowerCarolineCombo + 6))||(follower->Data == (firstFollowerCarolineCombo + 7)))
            {
            follower->Data = follower->Data - 4;
            }
            else if((follower->Data == (firstFollowerCarolineCombo + 3))||(follower->Data == (firstFollowerCarolineCombo + 2))||(follower->Data == (firstFollowerCarolineCombo + 1))||(follower->Data == (firstFollowerCarolineCombo)))
            {
                
            }
            else{
            follower->Data = firstFollowerCarolineCombo;
            }
        }
            }
        if(Link->Action == LA_SCROLLING){
        firstCheck = false;
            }
   else if(Link->Item[Caroline] == true){
        if(Link->Action != LA_SCROLLING && firstCheck == false)
        {
        follower = Screen->LoadFFC(FollowerBinx);
        follower->Data = firstFollowerBinxCombo;
        follower->CSet = csetOfFollowerBinx;

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
        if(Link->Action != LA_SCROLLING)
        {
        if((Link->InputUp || Link->InputDown || Link->InputRight || Link->InputLeft)&&(!(Link->InputA || Link->InputB))){
            pastX = follower->X;
            follower->X = followerX[0];
            for(index=0; index<12; index++)
            {
            followerX[index] = followerX[index + 1];
            }
            followerX[12] = Link->X;

            pastY = follower->Y;
            follower->Y = followerY[0];
            for(index=0; index<12; index++)
            {
            followerY[index] = followerY[index + 1];
            }
            followerY[12] = Link->Y;
        }

        if(follower->Y > pastY)
        {
            follower->Data = firstFollowerBinxCombo + 5;
        }
        else if(follower->Y < pastY)
        {
            follower->Data = firstFollowerBinxCombo + 4;
        }
        else if(follower->X > pastX)
        {
            follower->Data = firstFollowerBinxCombo + 7;
        }
        else if(follower->X < pastX)
        {
            follower->Data = firstFollowerBinxCombo + 6;
        }
        if(!(Link->InputUp || Link->InputDown || Link->InputRight || Link->InputLeft)){
            if((follower->Data == (firstFollowerBinxCombo + 4))||(follower->Data == (firstFollowerBinxCombo + 5))||(follower->Data == (firstFollowerBinxCombo + 6))||(follower->Data == (firstFollowerBinxCombo + 7)))
            {
            follower->Data = follower->Data - 4;
            }
            else if((follower->Data == (firstFollowerBinxCombo + 3))||(follower->Data == (firstFollowerBinxCombo + 2))||(follower->Data == (firstFollowerBinxCombo + 1))||(follower->Data == (firstFollowerBinxCombo)))
            {
                
            }
            else{
            follower->Data = firstFollowerBinxCombo;
            }
        }
      }
      if(Link->Action == LA_SCROLLING){
      firstCheck = false;
      }
    }            
  }
}
