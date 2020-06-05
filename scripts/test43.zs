import "std.zh"

global script a{
	void run(){
		while(true){
			if ( Link->PressEx1 ) Link->Extend = 3;
			if ( Link->PressEx2 ) Link->HitWidth = 32; 
			if ( Link->PressEx3 ) Link->InvFrames = 300;
			if ( Link->PressEx4 ) Link->InvFrames = 0;
			if ( Link->PressR ) {
				int s[]="Link->Animation was: ";
				int s1[]="Link->Animation is now: ";
				TraceS(s); Trace(Link->Animation);
				Link->Animation++;
				TraceS(s1); Trace(Link->Animation);
			}
			if ( Link->PressL ) {
				int s[]="Link->Animation was: ";
				int s1[]="Link->Animation is now: ";
				TraceS(s); Trace(Link->Animation);
				Link->Animation--;
				TraceS(s1); Trace(Link->Animation);
			}
			Waitdraw(); Waitframe();
		}
	}
}
