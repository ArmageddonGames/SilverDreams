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

item script CharacterBundle
{
    void run(int a, int b, int dmap, int scr)
    {
        Link->Item[a] = true;
        Link->Item[b] = true;
        Link->Warp(dmap,scr);
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



item script Message{
    void run(int ignore1, int ignore2, int ignore3, int ignore4, int ignore5, int ignore6, int ignore7, int m){
        Screen->Message(m);
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

item script SwordRandomDamage 
    {
        void run(int SwMinDam, int SwMaxDam)
        {
            CritChance = ((Rand(1,20)) + (((Game->Counter[CR_LUCK]) - 10) * 0.25));
            if (CritChance >= 20)
            {
                SwordDamage = ((Rand(SwMinDam, SwMaxDam) + ((Game->Counter[CR_STRENGTH] - 10) * 0.25)*2));
            }
            else if (CritChance <= ((((Game->Counter[CR_LUCK]) - 10) * 0.25) + 1))
            {
                SwordDamage = 0;
                SwordBotch();
                }
            else if ((CritChance < 20) && (CritChance > 1))
            {
                SwordDamage = (Rand(SwMinDam, SwMaxDam) + ((Game->Counter[CR_STRENGTH] - 10) * 0.25));
            }
            ModItemPower(SwordPower,SwordDamage);
            Trace(SwordDamage);
            Trace((CritChance + 100));
            Trace((BotchRoll + 1000));
        }
    } 
    
    
item script RangedRandomDamage 
    {
        void run(int MinDam, int MaxDam)
        {
            CritChance = ((Rand(1,20)) + (((Game->Counter[CR_LUCK]) - 10) * 0.25));
            if (CritChance >= 20)
            {
                Damage = ((Rand(MinDam, MaxDam) + ((Game->Counter[CR_DEXTERITY] - 10) * 0.25)*2));
            }
            else if (CritChance <= ((((Game->Counter[CR_LUCK]) - 10) * 0.25) + 1))
            {
                Damage = 0;
                Botch();
            }
            else if ((CritChance < 20) && (CritChance > ((((Game->Counter[CR_LUCK]) - 10) * 0.25) + 1)))
            {
                Damage = (Rand(MinDam, MaxDam) + ((Game->Counter[CR_DEXTERITY] - 10) * 0.25));
            }
            this->Power = Damage;
            Trace(Damage);
            Trace((CritChance + 100));
            Trace((BotchRoll + 1000));
        }
    }
    
item script MeleeRandomDamage 
    {
        void run(int MinDam, int MaxDam)
        {
            CritChance = ((Rand(1,20)) + (((Game->Counter[CR_LUCK]) - 10) * 0.25));
            if (CritChance >= 20)
            {
                Damage = ((Rand(MinDam, MaxDam) + ((Game->Counter[CR_STRENGTH] - 10) * 0.25)*2));
            }
            else if (CritChance <= ((((Game->Counter[CR_LUCK]) - 10) * 0.25) + 1))
            {
                Damage = 0;
                Botch();
            }
             else if ((CritChance < 20) && (CritChance > ((((Game->Counter[CR_LUCK]) - 10) * 0.25) + 1)))
            {
                Damage = (Rand(MinDam, MaxDam) + ((Game->Counter[CR_STRENGTH] - 10) * 0.25));
            }
            this->Power = Damage;
            Trace(Damage);
            Trace((CritChance + 100));
            Trace((BotchRoll + 1000));
        }
    }
    
item script MagicRandomDamage 
    {
        void run(int MinDam, int MaxDam)
        {
            CritChance = ((Rand(1,20)) + (((Game->Counter[CR_LUCK]) - 10) * 0.25));
            if (CritChance >= 20)
            {
                Damage = ((Rand(MinDam, MaxDam) + ((Game->Counter[CR_INTELLECT] - 10) * 0.25)*2));
            }
             else if (CritChance <= ((((Game->Counter[CR_LUCK]) - 10) * 0.25) + 1))
            {
                Damage = 0;
                Botch();
            }
            else if ((CritChance < 20) && (CritChance > ((((Game->Counter[CR_LUCK]) - 10) * 0.25) + 1)))
            {
                Damage = (Rand(MinDam, MaxDam) + ((Game->Counter[CR_INTELLECT] - 10) * 0.25));
            }
            this->Power = Damage;
            Trace(Damage);
            Trace((CritChance + 100));
            Trace((BotchRoll + 1000));
        }
    }

item script PerformanceRandomDamage 
    {
        void run(int MinDam, int MaxDam)
        {
            CritChance = ((Rand(1,20)) + (((Game->Counter[CR_LUCK]) - 10) * 0.25));
            if (CritChance >= 20)
            {
                Damage = ((Rand(MinDam, MaxDam) + ((Game->Counter[CR_CHARISMA] - 10) * 0.25)*2));
            }
             else if (CritChance <= ((((Game->Counter[CR_LUCK]) - 10) * 0.25) + 1))
            {
                Damage = 0;
                Botch();
            }
            else if ((CritChance < 20) && (CritChance > ((((Game->Counter[CR_LUCK]) - 10) * 0.25) + 1)))
            {
                Damage = (Rand(MinDam, MaxDam) + ((Game->Counter[CR_CHARISMA] - 10) * 0.25));
            }
            this->Power = Damage;
            Trace(Damage);
            Trace((CritChance + 100));
            Trace((BotchRoll + 1000));
        }
    }        
    
item script InitialStats
    {
        void run()    
        {
            
            Link->MaxHP = ((Rand(1,6)) + (Rand(1,6)) + (Rand(1,6)));;
            Link->HP = Link->MaxHP;
            Link->MaxMP = ((Rand(1,6)) + (Rand(1,6)) + (Rand(1,6)));
            Link->MP = Link->MaxMP;
            Game->Counter[CR_SP] = 180; //(10 * (Rand(1,6)) + (Rand(1,6)) + (Rand(1,6)));
            Game->MCounter[CR_SP] = 180;// Game->Counter[CR_SP];
            Game->Counter[CR_MAXSP] = Game->MCounter[CR_SP];
            Game->Counter[CR_MAXXP] = 150;
            Game->Counter[CR_LV] += 1;
            Game->Counter[CR_STRENGTH] = ((Rand(1,6)) + (Rand(1,6)) + (Rand(1,6)));
            Game->Counter[CR_INTELLECT] = ((Rand(1,6)) + (Rand(1,6)) + (Rand(1,6)));
            Game->Counter[CR_DEXTERITY] = ((Rand(1,6)) + (Rand(1,6)) + (Rand(1,6)));
            Game->Counter[CR_CHARISMA] = ((Rand(1,6)) + (Rand(1,6)) + (Rand(1,6)));
            Game->Counter[CR_LUCK] = ((Rand(1,6)) + (Rand(1,6)) + (Rand(1,6)));
            Trace(Link->MaxHP);
            Trace(Link->MaxMP);
            Trace(Game->MCounter[CR_SP]);
            Trace(Game->Counter[CR_STRENGTH]);
            Trace(Game->Counter[CR_INTELLECT]);
            Trace(Game->Counter[CR_DEXTERITY]);
            Trace(Game->Counter[CR_CHARISMA]);
            Trace(Game->Counter[CR_LUCK]);
            
        }
    }