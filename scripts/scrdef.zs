import "std.zh"

global script a{
	void run(){
		while(true){
			if ( Link->PressEx1 ) {
				npc n = Screen->LoadNPC(1);
				for ( int q = 0; q < 10; q++ ) {
					Trace(n->ScriptDefense[q]);
				}
			}
			Waitdraw(); Waitframe();
		}
	}
}
