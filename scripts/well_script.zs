

// [FFC] WELL SCRIPT -----------------------------------------------------------------------------------------------------------------

const int ItemID = 05;
const int FFC_AUTOWARP  = 4;

ffc script WellScript
{
	void run(){

		int ZY;

		while(true){
					
			if(UsingItem(ItemID)) while(Link->Z > 0) Waitframe();					
			
			ZY = CenterLinkY() - Link->Z;			          			
			
			if(ZY > this->Y && ZY < this->Y+this->EffectHeight && CenterLinkX() > this->X && CenterLinkX() < this->X+this->EffectWidth) 
			
			this->Data = FFC_AUTOWARP;			
					
			Waitframe();
		}
	}
}