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
    void run(int sprite, int thisItemId, int cost, int weapon){
        LastItemUsed = thisItemId;
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
        Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
    }
    }
}

item script windBlade{
    void run ( int step, int dur, int thisItemId){
         LastItemUsed = thisItemId;
        if ( NumLWeaponsOf(LW_GUST) ) //Quit if existing gust
            return;
        if (Game->Counter[CR_MAGIC] > 8)
        {
        Game->Counter[CR_MAGIC] -= 8; //fill in the magic consumption here as well    
        lweapon gust = NextToLink(LW_GUST, 16);
        gust->UseSprite(13);
        gust->Step = step;
        gust->Misc[LW_MISC_TIMEOUT] = dur;
        gust->Damage = 2;
        
    }
        else{
        Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
    }
    }
}

item script windElemental{
    void run ( int sprite, int dur, int thisItemId, int cost, int weapon ){
        LastItemUsed = thisItemId;
        if ( NumLWeaponsOf(LW_GUST) ) //Quit if existing gust
            return;
        if (Game->Counter[CR_MAGIC] > cost)
        {
        Game->Counter[CR_MAGIC] -= cost; //fill in the magic consumption here as well    
        lweapon gust = NextToLink(weapon, 16);
        gust->UseSprite(sprite);
        gust->Misc[LW_MISC_TIMEOUT] = dur;
        gust->Damage = 2;
        
    }
        else{
        Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
    }
    }
}

item script windElementalnosprite{
    void run ( int dur, int thisItemId, int cost, int weapon ){
         LastItemUsed = thisItemId;
        if ( NumLWeaponsOf(LW_GUST) ) //Quit if existing gust
            return;
        if (Game->Counter[CR_MAGIC] > cost)
        {
        Game->Counter[CR_MAGIC] -= cost; //fill in the magic consumption here as well    
        lweapon gust = NextToLink(weapon, 16);
        gust->Misc[LW_MISC_TIMEOUT] = dur;
        gust->Damage = 2;
       
    }
        else{
        Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
    }
    }
}
   
   

item script QuakeSword
{
    void run(int speed, int power, int maxProjectiles, int nouse, int thisItemId)
    {
        LastItemUsed = thisItemId;
    if (Game->Counter[CR_MAGIC] > 8 && NumLWeaponsOf(LW_BEAM) < maxProjectiles) //Fill in the numbers for magic consumption and number of projectiles allowed on screen
        {
        Game->Counter[CR_MAGIC] -= 8; //fill in the magic consumption here as well
        lweapon magic = Screen->CreateLWeapon(LW_BEAM);
        magic->UseSprite(18); // the number of the sprite used for the projectile. Use two tiles, the first for up/down, the second for left/right
        magic->X = Link->X; //Find Link's Position X
        magic->Y = Link->Y; //Find Link's Position Y
        magic->Dir = Link->Dir; //Find the Direction that Link is facing.
        magic->Step = speed; // the speed the projectile travels
        magic->Damage = power; //the damage the projectile will do
        Game->PlaySound(EQ_Sound); // the sound effect for the weapon
        Screen->Quake = EQ_Point * 2;
        Link->ItemJinx = (nouse * 1); //Set delay between firing. Change multiplier if desired, but set base in argument D7.
        if(Link->Dir == DIR_DOWN) //If Link is facing down...
            {
            magic->Flip = 2; //Change direction of spriteUsed to down.
            }
        if(Link->Dir == DIR_RIGHT) //If Link is facing right.
            {
            magic->Tile += 1; //Use next tile as well.
            }
        if(Link->Dir == DIR_LEFT)
            {
            magic->Tile += 1; //If Link is facing left.
            magic->Flip = 1; //Flip spriteUsed tile and use next tile as well.
          
            }
        
        }
        
        else{
    Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
    }
    }
}




item script FlameSword
{
    void run(int speed, int power, int maxProjectiles, int nouse, int thisItemId)
    {
        LastItemUsed = thisItemId;
    if (Game->Counter[CR_MAGIC] > 8 && NumLWeaponsOf(LW_BEAM) < maxProjectiles) //Fill in the numbers for magic consumption and number of projectiles allowed on screen
        {
        Game->Counter[CR_MAGIC] -= 8; //fill in the magic consumption here as well
        lweapon magic = Screen->CreateLWeapon(LW_BEAM);
        magic->UseSprite(90); // the number of the sprite used for the projectile. Use two tiles, the first for up/down, the second for left/right
        magic->X = Link->X; //Find Link's Position X
        magic->Y = Link->Y; //Find Link's Position Y
        magic->Dir = Link->Dir; //Find the Direction that Link is facing.
        magic->Step = speed; // the speed the projectile travels
        magic->Damage = power; //the damage the projectile will do
        Link->ItemJinx = (nouse * 1); //Set delay between firing. Change multiplier if desired, but set base in argument D7.
        if(Link->Dir == DIR_DOWN) //If Link is facing down...
            {
            magic->Flip = 2; //Change direction of spriteUsed to down.
            }
        if(Link->Dir == DIR_RIGHT) //If Link is facing right.
            {
            magic->Tile += 1; //Use next tile as well.
            }
        if(Link->Dir == DIR_LEFT)
            {
            magic->Tile += 1; //If Link is facing left.
            magic->Flip = 1; //Flip spriteUsed tile and use next tile as well.
           
            }
       
        
        }
        
        else{
    Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
    }
    }
}

item script EarthElemental {
  void run(int thisItemId) {
    LastItemUsed = thisItemId;
     Game->PlaySound(EQ_Sound); // the sound effect for the weapon
        Screen->Quake = EQ_Point * 2;}
    }
    
    item script VineSword
{
    void run(int speed, int power, int maxProjectiles, int nouse, int thisItemId)
    {
        LastItemUsed = thisItemId;
    if (Game->Counter[CR_MAGIC] > 8 && NumLWeaponsOf(LW_BEAM) < maxProjectiles) //Fill in the numbers for magic consumption and number of projectiles allowed on screen
        {
        Game->Counter[CR_MAGIC] -= 8; //fill in the magic consumption here as well
        lweapon magic = Screen->CreateLWeapon(LW_BEAM);
        magic->UseSprite(234); // the number of the sprite used for the projectile. Use two tiles, the first for up/down, the second for left/right
        magic->X = Link->X; //Find Link's Position X
        magic->Y = Link->Y; //Find Link's Position Y
        magic->Dir = Link->Dir; //Find the Direction that Link is facing.
        magic->Step = speed; // the speed the projectile travels
        magic->Damage = power; //the damage the projectile will do
        Link->ItemJinx = (nouse * 1); //Set delay between firing. Change multiplier if desired, but set base in argument D7.
        if(Link->Dir == DIR_DOWN) //If Link is facing down...
            {
            magic->Flip = 2; //Change direction of spriteUsed to down.
            }
        if(Link->Dir == DIR_RIGHT) //If Link is facing right.
            {
            magic->Tile += 1; //Use next tile as well.
            }
        if(Link->Dir == DIR_LEFT)
            {
            magic->Tile += 1; //If Link is facing left.
            magic->Flip = 1; //Flip spriteUsed tile and use next tile as well.
           
            
            }
      
        }
        
        else{
    Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
    }
    }
}

item script FireElemental {
  void run(int thisItemId) {
    LastItemUsed = thisItemId;}}
    
item script ForestElemental {
  void run(int thisItemId) {
    LastItemUsed = thisItemId;}}
    
item script WaterElemental {
  void run(int thisItemId) {
    LastItemUsed = thisItemId;}}   
    
item script LightElemental {
  void run(int thisItemId) {
    LastItemUsed = thisItemId;}}
    
item script ShadowElemental {
  void run(int thisItemId) {
    LastItemUsed = thisItemId;}}
    
item script SpiritElemental {
  void run(int thisItemId) {
    LastItemUsed = thisItemId;}} 

item script WaveSword
{
    void run(int speed, int power, int maxProjectiles, int nouse, int thisItemId)
    {
        LastItemUsed = thisItemId;
    if (Game->Counter[CR_MAGIC] > 8 && NumLWeaponsOf(LW_BEAM) < maxProjectiles) //Fill in the numbers for magic consumption and number of projectiles allowed on screen
        {
        Game->Counter[CR_MAGIC] -= 8; //fill in the magic consumption here as well
        lweapon magic = Screen->CreateLWeapon(LW_BEAM);
        magic->UseSprite(233); // the number of the sprite used for the projectile. Use two tiles, the first for up/down, the second for left/right
        magic->X = Link->X; //Find Link's Position X
        magic->Y = Link->Y; //Find Link's Position Y
        magic->Dir = Link->Dir; //Find the Direction that Link is facing.
        magic->Step = speed; // the speed the projectile travels
        magic->Damage = power; //the damage the projectile will do
        Link->ItemJinx = (nouse * 1); //Set delay between firing. Change multiplier if desired, but set base in argument D7.
        if(Link->Dir == DIR_DOWN) //If Link is facing down...
            {
            magic->Flip = 2; //Change direction of spriteUsed to down.
            }
        if(Link->Dir == DIR_RIGHT) //If Link is facing right.
            {
            magic->Tile += 1; //Use next tile as well.
            }
        if(Link->Dir == DIR_LEFT)
            {
            magic->Tile += 1; //If Link is facing left.
            magic->Flip = 1; //Flip spriteUsed tile and use next tile as well.
           
            
            }
        
        }
        
        else{
    Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
    }
    }
}

item script LightSword
{
    void run(int speed, int power, int maxProjectiles, int nouse, int thisItemId)
    {
        LastItemUsed = thisItemId;
    if (Game->Counter[CR_MAGIC] > 8 && NumLWeaponsOf(LW_BEAM) < maxProjectiles) //Fill in the numbers for magic consumption and number of projectiles allowed on screen
        {
        Game->Counter[CR_MAGIC] -= 8; //fill in the magic consumption here as well
        lweapon magic = Screen->CreateLWeapon(LW_BEAM);
        magic->UseSprite(232); // the number of the sprite used for the projectile. Use two tiles, the first for up/down, the second for left/right
        magic->X = Link->X; //Find Link's Position X
        magic->Y = Link->Y; //Find Link's Position Y
        magic->Dir = Link->Dir; //Find the Direction that Link is facing.
        magic->Step = speed; // the speed the projectile travels
        magic->Damage = power; //the damage the projectile will do
        Link->ItemJinx = (nouse * 1); //Set delay between firing. Change multiplier if desired, but set base in argument D7.
        if(Link->Dir == DIR_DOWN) //If Link is facing down...
            {
            magic->Flip = 2; //Change direction of spriteUsed to down.
            }
        if(Link->Dir == DIR_RIGHT) //If Link is facing right.
            {
            magic->Tile += 1; //Use next tile as well.
            }
        if(Link->Dir == DIR_LEFT)
            {
            magic->Tile += 1; //If Link is facing left.
            magic->Flip = 1; //Flip spriteUsed tile and use next tile as well.
           
            
            }
        
        }
        
        else{
    Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
    }
    }
}

item script ShadowSword
{
    void run(int speed, int power, int maxProjectiles, int nouse, int thisItemId)
    {
        LastItemUsed = thisItemId;
    if (Game->Counter[CR_MAGIC] > 8 && NumLWeaponsOf(LW_BEAM) < maxProjectiles) //Fill in the numbers for magic consumption and number of projectiles allowed on screen
        {
        Game->Counter[CR_MAGIC] -= 8; //fill in the magic consumption here as well
        lweapon magic = Screen->CreateLWeapon(LW_BEAM);
        magic->UseSprite(231); // the number of the sprite used for the projectile. Use two tiles, the first for up/down, the second for left/right
        magic->X = Link->X; //Find Link's Position X
        magic->Y = Link->Y; //Find Link's Position Y
        magic->Dir = Link->Dir; //Find the Direction that Link is facing.
        magic->Step = speed; // the speed the projectile travels
        magic->Damage = power; //the damage the projectile will do
        Link->ItemJinx = (nouse * 1); //Set delay between firing. Change multiplier if desired, but set base in argument D7.
        if(Link->Dir == DIR_DOWN) //If Link is facing down...
            {
            magic->Flip = 2; //Change direction of spriteUsed to down.
            }
        if(Link->Dir == DIR_RIGHT) //If Link is facing right.
            {
            magic->Tile += 1; //Use next tile as well.
            }
        if(Link->Dir == DIR_LEFT)
            {
            magic->Tile += 1; //If Link is facing left.
            magic->Flip = 1; //Flip spriteUsed tile and use next tile as well.
           
            
            }
      
        }
        
        else{
    Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
    }
    }
}

item script SpiritSword
{
    void run(int speed, int power, int maxProjectiles, int nouse, int thisItemId)
    {
        LastItemUsed = thisItemId;
    if (Game->Counter[CR_MAGIC] > 8 && NumLWeaponsOf(LW_BEAM) < maxProjectiles) //Fill in the numbers for magic consumption and number of projectiles allowed on screen
        {
        Game->Counter[CR_MAGIC] -= 8; //fill in the magic consumption here as well
        lweapon magic = Screen->CreateLWeapon(LW_BEAM);
        magic->UseSprite(230); // the number of the sprite used for the projectile. Use two tiles, the first for up/down, the second for left/right
        magic->X = Link->X; //Find Link's Position X
        magic->Y = Link->Y; //Find Link's Position Y
        magic->Dir = Link->Dir; //Find the Direction that Link is facing.
        magic->Step = speed; // the speed the projectile travels
        magic->Damage = power; //the damage the projectile will do
        Link->ItemJinx = (nouse * 1); //Set delay between firing. Change multiplier if desired, but set base in argument D7.
        if(Link->Dir == DIR_DOWN) //If Link is facing down...
            {
            magic->Flip = 2; //Change direction of spriteUsed to down.
            }
        if(Link->Dir == DIR_RIGHT) //If Link is facing right.
            {
            magic->Tile += 1; //Use next tile as well.
            }
        if(Link->Dir == DIR_LEFT)
            {
            magic->Tile += 1; //If Link is facing left.
            magic->Flip = 1; //Flip spriteUsed tile and use next tile as well.
           
            
            }
      
        }
        
        else{
    Game->PlaySound(SFX_ERROR); //If out of MP, play ERROR SOund Effects.
    }
    }
}

item script Message{
    void run(int ignore1, int ignore2, int ignore3, int ignore4, int ignore5, int ignore6, int ignore7, int m){
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
