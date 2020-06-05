import "std.zh"

const int MAXMAPS = 1;
const int SCTLS_BASE = 100; 
const int SCTLS_NEXT_OFS = 10; 

global script a{
void run(){
	int s_demo[]="Demo - Test Get/SetScreenEnemy()";
	int s_scr[]="Screen:"; int s_map[]="Map:";
	int s_ctls[]="Press Ex1, Ex2 to change Map ID";
	int s_ctls2[]="Press Ex3/Ex4 to change Screen ID";
	int s_ctls3[]="Press R to change NPCs";
	int s_ctls4[]="Press L to Trace NPCs to Console";
	int map;
	int screen;
	while(true){
		
		if ( Link->PressEx1 ) map = ( vbound(map-1, 1, MAXMAPS) );
		if ( Link->PressEx2 ) map = ( vbound(map+1, 1, MAXMAPS) ) ;
		if ( Link->PressEx3 ) screen = ( vbound(screen-1, 0, 0x87) );
		if ( Link->PressEx4 ) screen = ( vbound(screen+1, 0, 0x87) );
		if ( Link->PressL ) { 
			for ( int q = 0; q < 10; q++ ) Trace(Game->GetScreenEnemy(map,screen,q));
		}
		if ( Link->PressR ) {
			for ( int q = 0; q < 10; q++ ) {
				Game->SetScreenEnemy(map,screen,q, 20);
			}
		}
		Screen->DrawInteger(6, 60, 30, 0, 0x01, -1, -1, -1, map, 0, 128);
		Screen->DrawInteger(6, 60, 50, 0, 0x01, -1, -1, -1, screen, 0, 128);
	
		Screen->DrawString(6, 0, 30, 0, 0x01, -1, 0, s_scr, 128);
    	Screen->DrawString(6, 0, 50, 0, 0x01, -1, 0, s_map, 128);
	
		Screen->DrawString(6, 0, 0, 0, 0x01, -1, 0, s_demo, 128);

		Screen->DrawString(6, 0, SCTLS_BASE, FONT_LA, 0x01, -1, 0, s_ctls, 128);
		Screen->DrawString(6, 0, SCTLS_BASE+SCTLS_NEXT_OFS, FONT_LA, 0x01, -1, 0, s_ctls2, 128);
		Screen->DrawString(6, 0, SCTLS_BASE+(SCTLS_NEXT_OFS*2), FONT_LA, 0x01, -1, 0, s_ctls3, 128);
		Screen->DrawString(6, 0, SCTLS_BASE+(SCTLS_NEXT_OFS*3), FONT_LA, 0x01, -1, 0, s_ctls4, 128);
	
	
		Waitdraw(); Waitframe();
	}
}}
