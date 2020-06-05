

ffc script triggersound{
	void run(int sfx){
		bool waiting = true;
		while(waiting) {
			if ( GetLayerComboT(1,ComboAt(Link->X, Link->Y)) == CT_RESET ) {
				waiting = false;
			}
			Waitframe();
		}
			Game->PlaySound(sfx);
			this->Data = 0; this->Script = 0; Quit();
		}
}			
