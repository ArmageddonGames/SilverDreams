global script traceID{
	void run(){
		int id[]="UsingItem: ";
			TraceS(id); Trace(Link->UsingItem);
		int scr[]="UsingItemA: ";
			TraceS(scr); Trace(Link->UsingItemA);
		int scr1[]="UsingItemB: ";
			TraceS(sc2); Trace(Link->UsingItemB);
		while(true){
			if ( Link->UsingItem != -1 ) {
				int id[]="UsingItem: ";
				TraceS(id); Trace(Link->UsingItem);
			}
			if ( Link->UsingItemA != -1 ) {
				int scr[]="UsingItemA: ";
				TraceS(scr); Trace(Link->UsingItemA);
			}
			if ( Link->UsingItemB != -1 ) {
				int scr1[]="UsingItemB: ";
				TraceS(sc2); Trace(Link->UsingItemB);
			}
			if ( Link->PressR ) { 
				int os[]="Old warp return square: ";
				TraceS(os); Trace(Link->useWarpReturn);
				Link->WarpReturn++;
				int ns[]="New warp return square: ";
				TraceNL(); TraceS(ns); Trace(Link->UseWarpReturn);
			}
			if ( Link->PressL ) { 
				int os[]="Old warp return square: ";
				TraceS(os); Trace(Link->useWarpReturn);
				Link->WarpReturn--;
				int ns[]="New warp return square: ";
				TraceNL(); TraceS(ns); Trace(Link->UseWarpReturn);
			}
			if ( Link->PressEx1 ) {
				int ss[]="Warping Link";
				Link->Warp(1,3); 
			}
			Waitdraw(); Waitframe();
		}
	}
}