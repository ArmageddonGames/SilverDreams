ffc script holelava
{
    void run(int warp, bool position, int damage)
    {
        while(true)
        {
            while(!Warping) Waitframe();
            if(warp > 0)
            {
                this->Data = CMB_AUTOWARP+warp-1;
                this->Flags[FFCF_CARRYOVER] = true;
                Waitframe();
                this->Data = FFCS_INVISIBLE_COMBO;
                this->Flags[FFCF_CARRYOVER] = false;
                Link->Z = Link->Y;
                Warping = false;
                Link->DrawXOffset -= Cond(Link->DrawXOffset < 0, -1000, 1000);
                Link->HitXOffset -= Cond(Link->HitXOffset < 0, -1000, 1000);
                Quit();
            }
            if(position)
            {
                Link->X = this->X;
                Link->Y = this->Y;
            }
            else
            {
                Link->X = this->InitD[6];
                Link->Y = this->InitD[7];
            }
            if(damage)
            {
                Link->HP -= damage;
                Link->Action = LA_GOTHURTLAND;
                Link->HitDir = -1;
                Game->PlaySound(SFX_OUCH);
            }
            Link->DrawXOffset -= Cond(Link->DrawXOffset < 0, -1000, 1000);
            Link->HitXOffset -= Cond(Link->HitXOffset < 0, -1000, 1000);
            Warping = false;
            Waitframe();
        }
    }
}

//Used to determine if Link is on a Pit or Lava combo.
int OnPitCombo()
{
    int comboLoc = ComboAt(Link->X+8, Link->Y + Cond(BIG_LINK==0, 12, 8));
    if(Screen->ComboT[comboLoc] != CT_HOLELAVA)
    return 0;
    else if(Screen->ComboI[comboLoc] == CF_PIT || Screen->ComboI[comboLoc] == CF_LAVA)
    return Screen->ComboI[comboLoc];
    else if(Screen->ComboF[comboLoc] == CF_PIT || Screen->ComboF[comboLoc] == CF_LAVA)
    return Screen->ComboF[comboLoc];
    else
    return 0;
}


//Snaps Link to the combo so he appears completely over pit and lava combos.
void SnaptoGrid()
{
    int x = Link->X;
    int y = Link->Y + Cond(BIG_LINK==0, 8, 0);
    int comboLoc = ComboAt(x, y);

    //X Axis
    if(Screen->ComboT[comboLoc] == CT_HOLELAVA && Cond(x % 16 == 0, true, Screen->ComboT[comboLoc+1] != CT_HOLELAVA))
    Link->X = ComboX(comboLoc);
    else if(Screen->ComboT[comboLoc+1] == CT_HOLELAVA && Cond(x % 16 == 0, true, Screen->ComboT[comboLoc] != CT_HOLELAVA))
    Link->X = ComboX(comboLoc+1);
    if(Cond(y % 16 == 0, false, Screen->ComboT[comboLoc+16] == CT_HOLELAVA) && Cond(x % 16 == 0, true, Screen->ComboT[comboLoc+17] != CT_HOLELAVA))
    Link->X = ComboX(comboLoc+16);
    else if(Cond(y % 16 == 0, false, Screen->ComboT[comboLoc+17] == CT_HOLELAVA) && Cond(x % 16 == 0, true, Screen->ComboT[comboLoc+16] != CT_HOLELAVA))
    Link->X = ComboX(comboLoc+17);

    //Y Axis
    if(Screen->ComboT[comboLoc] == CT_HOLELAVA && Cond(y % 16 == 0, true, Screen->ComboT[comboLoc+16] != CT_HOLELAVA))
    Link->Y = ComboY(comboLoc);
    else if(Screen->ComboT[comboLoc+16] == CT_HOLELAVA && Cond(y % 16 == 0, true, Screen->ComboT[comboLoc] != CT_HOLELAVA))
    Link->Y = ComboY(comboLoc+1);
    if(Cond(x % 16 == 0, false, Screen->ComboT[comboLoc+1] == CT_HOLELAVA) && Cond(y % 16 == 0, true, Screen->ComboT[comboLoc+17] != CT_HOLELAVA))
    Link->Y = ComboY(comboLoc+1);
    else if(Cond(x % 16 == 0, false, Screen->ComboT[comboLoc+17] == CT_HOLELAVA) && Cond(y % 16 == 0, true, Screen->ComboT[comboLoc+1] != CT_HOLELAVA))
    Link->Y = ComboY(comboLoc+17);
}

// D0 = Number of the JerkLike enemy in the enemy list. The first enemy in the list is 1, the second one is 2, etc.
// D2 = item# it eats
// D3 = every this number of frames, the drop rate for return drops by 10%.  
 
ffc script LikeLikeMod{
    void run(int enemyID, int eat_item, int eatdropratio){
        Waitframes(5);
        npc LikeLikeMod=Screen->LoadNPC(enemyID);
        bool hadItem=Link->Item[eat_item];
        int eatcounter = 0;
        int droppercentage = 100;
 
        while(true){
            if(hadItem==true && Link->Item[eat_item]==false){
                eatcounter++;
 
                if(eatcounter%eatdropratio == 0 && droppercentage != 0){
                      droppercentage -= 10;
                }
            }
 
            if(LikeLikeMod->HP<=0){
                int dropchance=Rand(100)+1;
                if(dropchance<=droppercentage && hadItem==true && Link->Item[eat_item]==false){
                    item i=Screen->CreateItem(eat_item);
                    SetItemPickup(i, IP_HOLDUP, true);
                    i->X=LikeLikeMod->X;
                    i->Y=LikeLikeMod->Y;
                }
                Quit();
            }
 
        Waitframe();
        }
    }
}

ffc script TFReqItem
{
    void run(int itemID, int triforceCount)
    {
        if ( Screen->State[ST_ITEM] )
        return;
        
        item drop = CreateItemAt(itemID, this->X, this->Y);
        
        drop->Pickup |= IP_ST_ITEM;
        
        if ( NumTriforcePieces() < triforceCount )
        drop->Pickup |= IP_DUMMY;
    }
}

ffc script Trigger {
  void run(int fromCombo, int toCombo, int itemNo) {
    int loc = ComboAt(this->X + 8, this->Y + 8);
    int underCombo = Screen->ComboD[loc];
 
    // Wait until
    while (// We're hit by the right item type, or
           !CollisionAllLWeapon(this, LWEAPON_MISC_SOURCE, itemNo) &&
           // The combo on layer 0 changes.
           Screen->ComboD[loc] == underCombo) {
      Waitframe();}
 
    // Cancel out if the underlying combo changed.
    if (Screen->ComboD[loc] != underCombo) {
      return;}
 
    // Otherwise, we were hit by the item, so change the combos on screen.
    for (int i = 0; i < 176; i++) {
      if (Screen->ComboD[i] == fromCombo) {
        Screen->ComboD[i] = toCombo;}}}}
