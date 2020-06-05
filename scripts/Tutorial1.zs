import "std.zh"

ffc script sign {
	void run(int m) {
		while(true) {
			while(Link->X < this->X - 8 || Link->X > this->X + 24 || Link->Y < this->Y || Link->Y > this->Y + 24 || Link->Dir != DIR_UP || !Link->InputA) {
				Waitframe();
			}
			Link->InputA = false;
			Screen->Message(m);

			while(Link->X >= this->X - 8 && Link->X <= this->X + 24 && Link->Y >= this->Y && Link->Y <= this->Y + 24 && Link->Dir == DIR_UP) {
				Waitframe();
			}
			
			Screen->Message(0);
		}
	}
}

ffc script crow{
    void run(int spc, int combo){
        int r;
        while(Abs(Link->X - this->X) > spc || Abs(Link->Y - this-> Y) > spc){
        Waitframe();
        }
        r = Rand(10)/5;
        if(Rand(2) == 1)r*= -1;
        this->Vx = r; 
        r = Rand(10)/5; 
        if(Rand(2) == 1)r*= -1; 
        this->Vy = r;
        if(this->Vy == 0 && this-> Vx == 0)this->Vy += 1;
        if(this->Vy < 1)this->Vy +=1;
        if(this->Vx < 1)this->Vx +=1;
        if(this->Vy < 0 && this->Vx == 0)this->Data = combo;
        if(this->Vy > 0 && this->Vx == 0)this->Data = combo+1;
        if(this->Vx < 0 && this->Vy == 0)this->Data = combo+2;
        if(this->Vx > 0 && this->Vy == 0)this->Data = combo+3;
        if(this->Vx < 0 && this->Vy < 0)this->Data = combo+4;
        if(this->Vx > 0 && this->Vy < 0)this->Data = combo+5;
        if(this->Vx < 0 && this->Vy > 0)this->Data = combo+6;
        if(this->Vx > 0 && this->Vy > 0)this->Data = combo+7;
    }
}


