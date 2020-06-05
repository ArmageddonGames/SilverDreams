item script PotionSpecial
{
    void run(int a,int b, int c)
    {

        if(a==0){Game->DCounter[CR_LIFE] += b;}
        if(a==1){Game->DCounter[CR_MAGIC] += c;}
        if(a==2){Game->DCounter[CR_LIFE] +=b; Game->DCounter[CR_LIFE] += c;}
        
    }
}

item script EveryWeapon {
  void run(int thisItemId) {
    LastItemUsed = thisItemId;}}

item script DummyItem
{
    void run(int ItemID, int m)
    {
        Link->Item[ItemID] = true;
        Screen->Message(m);
    }
}

item script ItemBundle
{
    void run(int a, int b, int c, int d, int e, int f, int g, int m)
    {
        Link->Item[a] = true;
        Link->Item[b] = true;
        Link->Item[c] = true;
        Link->Item[d] = true;
        Link->Item[e] = true;
        Link->Item[f] = true;
        Link->Item[g] = true;
        Screen->Message(m);
    }
}

//D0 - D7: Set these to the items you want to give in the bundle and place as the pickup script on one dummy item.

item script MultipleItemPickup{

void run(int Item0, int Item1, int m){
item giveitem0= Screen->CreateItem(Item0);
giveitem0->X = Link->X;
giveitem0->Y = Link->Y;
giveitem0->Z = Link->Z;
item giveitem1= Screen->CreateItem(Item1);
giveitem1->X = Link->X;
giveitem1->Y = Link->Y;
giveitem1->Z = Link->Z;

Screen->Message(m);

    }
}

//D0: The power of this attack ring (can be integer or decimal)
item script attackRingPickup{
    void run(float power, int m){
        attackRingPower = Max(attackRingPower, power);
        Screen->Message(m);
    }
}

item script IceRod{
    void run(int step, int thisItemId){
        LastItemUsed = thisItemId;
        if (Game->Counter[CR_MAGIC] > 8)
        {
        Game->Counter[CR_MAGIC] -= 8; //fill in the magic consumption here as well
        lweapon Ice = NextToLink(LW_SCRIPT1, 1);
            Ice->Dir = Link->Dir;
            Ice->Damage = 2;
            Ice->Step = step;
            Ice->Misc[4] = 42;
            Ice->Misc[10] = 2;
            Ice->UseSprite(83);
            Ice->CollDetection=false;
           
    }

        else{
        Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
    }
    }
}

item script IceElemental{
    void run(int sprite, int thisItemId){
        
        lweapon Ice = NextToLink(LW_ARROW, 3);
            Ice->Dir = Link->Dir;
            Ice->Misc[4] = 42;
            Ice->Misc[10] = 2;
            Ice->CollDetection=false;
            

  
    }
}

item script FireElemental {
  void run(int thisItemId) {
    LastItemUsed = thisItemId;}}
    
item script LightElemental {
  void run(int thisItemId) {
    LastItemUsed = thisItemId;}}
    

item script Message{
    void run(int m){
        Screen->Message(m);
    }
}

//D0: MP Cost
item script faroresWind{
    void run(int mpCost){
        //If warp currently active, quit
        if ( fwData[FWD_ACTIVE] != 0 )
            return;
    
        //If no warp point and insufficient magic, quit
        if ( fwData[FWD_DMAP] > 0 && Link->MP < mpCost )
            return;
        
        //Otherwise if no warp point, pay to make one
        if ( fwData[FWD_DMAP] > 0 )
            Link->MP -= mpCost;
        
        //Then activate
        fwData[FWD_ACTIVE] = 1;
    }
}


item script SONG_OBSTACLE
{
    void run (int SFX, int Combo1, int Combo2, int Combo3, int Combo4, int Combo5, int Combo6, int FreezeTime)
    {
        int Song_Obstacle[] = "Song_Obstacle";
        int Args[8] = {SFX, Combo1, Combo2, Combo3, Combo4, Combo5,Combo6, FreezeTime};
        RunFFCScript(Game->GetFFCScript(Song_Obstacle), Args);
    }
}
