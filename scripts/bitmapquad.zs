import "std.zh"

global script q{
	void run(){
		
		int x[4] = {0, 255, 0, 255};
		int y[4] = {0, 0, 175, 175};
		int t;
		
		int a = RT_BITMAP1; 
		
		while(true){
			
			if(Link->PressL)
				t = (t+1)%4;
			if(Link->InputUp)
				y[t]--;
			else if(Link->InputDown)
				y[t]++;
			else if(Link->InputLeft)
				x[t]--;
			else if(Link->InputRight)
				x[t]++;
			if ( Link->PressEx2 ) a--;
			if ( Link->PressEx1 ) a++;
			Screen->SetRenderTarget(RT_BITMAP1);
			Screen->DrawScreen(0, 1, 0, 0, 0, 0);
			Screen->SetRenderTarget(RT_SCREEN);
			Screen->BitmapQuad(6, x[0], y[0], x[1], y[1], x[2], y[2], x[3], y[3], 512, 512, 0, 0, RT_BITMAP1, PT_PTEXTURE,0,0);
			Screen->DrawInteger(5, 50, 0, 0, 1, 0, 0, 0, a, 0, 128);
			Waitdraw();
			Waitframe();
		}
	}
}
