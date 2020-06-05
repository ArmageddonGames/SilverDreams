import "std.zh"


global script a{
	void run(){
		int timer = 120; 
		while(true){
				if ( Link->PressEx1 ) { 
					while ( --timer) { Link->Action = LA_CASTING; Waitframe(); }
					timer = 120;
				}
				Waitdraw(); Waitframe(); 
		}
	}
}
