																																									
import "std.zh"

import "inv.zh"


global script a{
void run(){
while(true){
//Shadow(RT_BITMAP2,5);
InvertedCircleEx(RT_BITMAP1,4, Link->X+8, Link->Y+8, 32, 1, 0x0F,0, 1); 
Waitdraw();
Waitframe();
}}}


