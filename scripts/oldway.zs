import "std.zh"

const int LINKTILEOFFSET = -261;

ffc script a{
	void run(){
		lweapon l; int map = 1; int screen; npc n;
		while(true){

			if ( Link->PressL ) {
				Link->SetLinkTile(1,Link->Dir,11721+LINKTILEOFFSET);
				Link->GetLinkTile(1										,Link->Dir);
				Trace(Link->GetLinkTile(1,Link->Dir));
				//Link->SetLinkExtend(1,Link->Dir,2);
				//Link->GetLinkExtend(1,Link->Dir);
				//Trace(Link->GetLinkExtend(1,Link->Dir));
				

			}
			if ( Link->PressEx1 ) screen = ( vbound(screen-1, 1, MAXMAPS) );
			if ( Link->PressEx2 ) screen = ( vbound(screen+1, 1, MAXMAPS) ) ;
			
			if ( Link->PressL ) { 
				for ( int q = 0; q < 10; q++ ) Trace(Game->GetScreenEnemy(map,screen,q));
			}
			if ( Link->PressR ) {
				//for ( int q = 0; q < 10; q++ ) {
					Game->SetScreenEnemy(1,0,0, 20);
				//}
			}
			if ( Link->PressEx3 ) {
				l = Screen->CreateLWeaponDx(LW_SPARKLE, I_SWORD1);
				l->X = 100; l->Y = 100; 
			}
				
			if ( l->isValid() ) { l->X = Rand(0,150); l->Y = Rand(0,100); l->Tile = Rand(1070, 1075);
				
			Screen->DrawString(6, 0, SCTLS_BASE, FONT_LA, 0x01, -1, 0, s_ctls, 128);
			Screen->DrawString(6, 0, SCTLS_BASE+SCTLS_NEXT_OFS, FONT_LA, 0x01, -1, 0, s_ctls2, 128);
			Screen->DrawString(6, 0, SCTLS_BASE+(SCTLS_NEXT_OFS*2), FONT_LA, 0x01, -1, 0, s_ctls3, 128);
			Screen->DrawString(6, 0, SCTLS_BASE+(SCTLS_NEXT_OFS*3), FONT_LA, 0x01, -1, 0, s_ctls4, 128);
	
			
			//Waitdraw(); //Can;t have this, because ffcs do not permit it. 
			Waitframe();
		}
	}
}				
