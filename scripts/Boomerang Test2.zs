import "std.zh"
import "ffcscript.zh"
import "stdExtra.zh"
import "string.zh"


global script slot_2
{
    void run(){

       

        while(true)
        {
                     for (int i = 1; i <= Screen->NumLWeapons(); ++i) 
            {
             lweapon Falcon = Screen->LoadLWeapon(i);
             if (Falcon->ID == LW_BRANG)
              {
                if (Falcon->Dir == DIR_DOWN)
                {
                    Falcon->OriginalTile = 21400;
                    Falcon->Flip = 3;
                }
                else if (Falcon->Dir == DIR_RIGHT)
                {
                    Falcon->OriginalTile = 21408;
                    Falcon->Flip = 0;
                }
                else if (Falcon->Dir == DIR_LEFT)
                {
                    Falcon->OriginalTile = 21400;
                    Falcon->Flip = 2;
                }
                else if (Falcon->Dir == DIR_UP)
                {
                    Falcon->OriginalTile = 21408;
                    Falcon->Flip = 0;
                }
                else if (Falcon->Dir == DIR_LEFTUP)
                {
                    Falcon->OriginalTile = 21400;
                    Falcon->Flip = 2;
                }
                else if (Falcon->Dir == DIR_LEFTDOWN)
               {
                    Falcon->OriginalTile = 21400;
                    Falcon->Flip = 2;
                }
                else if (Falcon->Dir == DIR_RIGHTUP)
                {
                    Falcon->OriginalTile = 21408;
                    Falcon->Flip = 0;
                }
                else if (Falcon->Dir == DIR_RIGHTDOWN)
                {
                    Falcon->OriginalTile = 21408;
                    Falcon->Flip = 0;
                }
              }

            Waitframe();

        }
    }
}
}