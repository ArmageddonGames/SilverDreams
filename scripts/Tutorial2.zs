import "std.zh"

item script Recharge
{
	void run()
	{
		Link->HP = Link->MaxHP;
		Link->MP = Link->MaxMP;
	}
}

item script CheatLv4
{
	void run()
	{
		Game->Cheat = 4;
	}
}

const int EQ_Point = 30
const int EQ_Sound = 13

ffc script Earthquake
{
	void run()
	{
		Game->PlaySound(EQ_Sound)
		Screen->Quake = EQ_Point * 2;
		Link->Jump = 3;
		Link->SwordJinx = EQ_Point * 2;
		Link->ItemJinx = EQ_Point * 2;
	}
}

ffc script LinkMove
{
	void run()
	{
		Link->X = this->X;
		Link->Y = this->Y;
	}
}

const int HS = 16
const int MS = 32

item script SetTo3
{
	void run()
	{
		Link->HP = HS * 3;
		Link->MP = MS * 3;
	}
}

ffc script MoveLAccelR
{
	void run()
	{
		this->Vx = -2;
		this->Ax = 2;
	}
}

ffc script Seventy5
{
	void run()
	{
		Link->HP *= 0.75;
		Link->MP *= 0.75;
	}
}

ffc script VeerAway
{
	void run()
	{
		this->Vx = (Link->X - this->X) / 60;
		this->Vy = (Link->Y - this->Y) / 60;
		this->Ax = -this->Vx / 150;
		this->Ax = -this->Vx / 150;
	}
}

ffc script ProportionateDisability
{
	void run()
	{
		Link->SwordJinx = (Link->HP / (Heart) * 60;
		Link->ItemJinx = (Link->MP / (MJar) * 60;
	}
}

ffc script MoveDownRight
{
	void run()
	{
		Link->X += 16;
		Link->Y += 16;
	}
}

item script HealingSpell
{
	void run()
	{
		Link->HP += Link->MP / 8;
		Link->MP *= 0.75;
	}
}

ffc script SecretSound
{
	void run()
	{
		Game->PlaySound(27);
	}
}

ffc script CircleLink
{
	void run()
	{
		Link->Circle(5,Link->X+8,16,3,1,0,0,0,false,128);
		Link->Circle(5,Link->X+8,12,3,1,0,0,0,false,128);
		Link->Circle(5,Link->X+8,8,3,1,0,0,0,false,128);
		Link->Circle(5,Link->X+8,4,3,1,0,0,0,false,128);
	}
}

ffc script MoveTowardLink
{
	void run ()
	{
		this->Vx = VectorX(1,Angle(this->X,this->Y,Link->X,Link->Y));
		this->VY = VectorY(1,Angle(this->X,this->Y,Link->X,Link->Y));
	}
}

ffc script WaitSound
{
	void run()
	{
		Waitframes(600);
		Game->PlaySound(27);
	}
}

global script Cheats4Noobs
{
	void run()
	{
		Game->Cheats = Min(4,Link->NumDeaths / 10);
	}
}

ffc script WaitFlash
{
	void run()
	{
		Waitframes(300)
		Screen->Rectangle(6,0,0,255,2,1,0,0,0,true,128);
	}
}


ffc script TFReqItem
{
	void run(int itemID, int triforceCount){ 
                if ( Screen->State[ST_ITEM] ) 
                        return; 
                         
                item drop = CreateItemAt(itemID, this->X, this->Y); 
                 
                drop->Pickup |= IP_ST_ITEM; 
                         
                if ( NumTriforcePieces() < triforceCount ) 
                        drop->Pickup |= IP_DUMMY; 
        } 
}

item script CursedKey
{
	void run()
	{
		Link->MaxHP = Max(Link->HP,HS,HS);
		Link->HP = Min(Link->HP,Link->MaxHP);
		Game->Counter[CR_KEY) += 1;
	}
}

item script SwordInStone
{
	void run(int item[])
	{
		this->Pickup = Equipment->item[]
	}
}