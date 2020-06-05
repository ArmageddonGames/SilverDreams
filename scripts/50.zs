import "std.zh"

global script a{
	void run(){
		while(true){
		if ( Link->PressEx1 ) {
			int m[]="THis is a script message.";
			Game->SetMessage(1,m);
			Screen->Message(1);
		}
		if ( Link->PressEx2) {
			int m[]="Script Title";
			Game->SetDMapTitle(0,m);
		}
		if ( Link->PressEx3 ) {
			Game->GreyscaleOn();
		}
		if ( Link->PressEx4 ) {
			Game->GreyscaleOff();
		}
		if ( Link->PressL ) {
			int s[]="Old Level Palette: ";
			TraceS(s); Trace(Game->DMapPalette[Game->GetCurDMap()]);
			int s1[]="New Level Palette: ";
            Game->DMapPalette[Game->GetCurDMap()]--;
            TraceS(s1); Trace(Game->DMapPalette[Game->GetCurDMap()]);
		}
		if ( Link->PressR ) {
			int s1[]="New Level Palette: ";
            Game->DMapPalette[Game->GetCurDMap()]++;
            TraceS(s1); Trace(Game->DMapPalette[Game->GetCurDMap()]);
		}
		Waitdraw(); Waitframe();
		}
	}
}
