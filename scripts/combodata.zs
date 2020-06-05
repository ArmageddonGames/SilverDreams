import "std.zh"

int vol[4];

global script a{
	void run(){
		
		combodata cd = Game->LoadComboData(2);
		Trace(cd->Tile);
		while(1)
		{
			Waitdraw(); Waitframe();
		}
	}
}
