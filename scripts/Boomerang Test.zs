import "std.zh"
import "ffcscript.zh"
import "stdExtra.zh"
import "string.zh"

const int BRANG_STATE = 0; //Slot of lweapon->Misc[] to use.


global script slot_2
{
    void run()
    {

        int reqItem = 23; //Item that makes the FFC follower follow you
        int ffcNumber = 32; //The number of the FFC used. This script will "hijack" this one, so don't use it for anything else on screens when you expect the player to have a follower.
        int firstFollowerCombo = 65272; //combo of the first combo. In order, the concecutive combos must be "still up", "still down", "still left", "still right", "moving up", "moving down", "moving left", "moving right".
        int csetOfFollower = 8;
        bool firstCheck = false; //leave this alone
        ffc follower; //We will be using this on every screen.

        int pastX;
        int currentX;
        int followerX[13];

        int pastY;
        int currentY;
        int followerY[13];

        int index; //This is a VERY BAD variable name, as it is used as a short name in MANY functions.
        //I would use follower_index for this. -Z
        //Don't complain to me if you see a flood of 'variable already declared' errors because of this.

        
        //BrangFlip(); //This is doing nothing as it is outside the loop.  -Z

        while(true)
        { //begin main infinite loop
            
            
            BrangFlip(); //Call the boomerange flipping function every frame.
            
            //I am going to comment his wall of text. -Z
            
            //If Link has whatever gimmic he needs...
//            if(Link->Item[reqItem] == true)
//            {

                //if you mean this to be a one-time thing, then you need to set firstCheck false
                //INSIDE this scope.
//                if(Link->Action != LA_SCROLLING && firstCheck == false)
//                {
//                    follower = Screen->LoadFFC(ffcNumber);
//                    follower->Data = firstFollowerCombo;
//                    follower->CSet = csetOfFollower;
//
//                    pastX = Link->X;
//                    follower->X = Link->X;
//                    pastY = Link->Y;
//                    follower->Y = Link->Y;

//                    for ( int i = 0; i < 13; i++ )
//                    { //I don;t care if you put braces on a line, or on a following line,
//                        //but please choose one or the other, and not both willy-nilly. -Z
//                        followerX[i] = Link->X;
//                        followerY[i] = Link->Y;
//                    
//                    }
//                    firstCheck = true; //Don;t load an ffc every flipping frame.
//                }
//            }
            
            //We could resolve these two things together, as you are again checking for scorlling.
            
            //Simplify all the checks that you want to do using scrolling into one block.
            //These if-else blocks would be better as functions. -Z
            if(Link->Action != LA_SCROLLING)
            {
                //If Link has the required item and we have not set up the ffc on this screen...
                if ( firstCheck == false && Link->Item[reqItem] == true )
                {
                    follower = Screen->LoadFFC(ffcNumber);
                    follower->Data = firstFollowerCombo;
                    follower->CSet = csetOfFollower;

                    pastX = Link->X;
                    follower->X = Link->X;
                    pastY = Link->Y;
                    follower->Y = Link->Y;

                    for ( int i = 0; i < 13; i++ )
                    { //I don;t care if you put braces on a line, or on a following line,
                        //but please choose one or the other, and not both willy-nilly. -Z
                        followerX[i] = Link->X;
                        followerY[i] = Link->Y;
                    
                    }
                    firstCheck = true; //Don;t load an ffc every flipping frame.
                }
                    
                if((Link->InputUp || Link->InputDown || Link->InputRight || Link->InputLeft)&&(!(Link->InputA || Link->InputB)))
                {
                    //No idea what all of the calcs do. -Z
                    pastX = follower->X;
                    follower->X = followerX[0];
                    for(index=0; index<12; index++)
                    { //or why this is hardcoded to 12. Oh, it's an array size?- Z
                        //! The array is a size of 13, so if you are using all of its indices
                        //! then you need to do < 13, or <= 12 here. -Z
                        followerX[index] = followerX[index + 1];
                    }
                    followerX[12] = Link->X;

                    pastY = follower->Y;
                    follower->Y = followerY[0];
                    
                    for(index=0; index<12; index++)
                    {
                        followerY[index] = followerY[index + 1];
                    }
                    followerY[12] = Link->Y;
                }

                if(follower->Y > pastY)
                {
                    follower->Data = firstFollowerCombo + 5;
                }
                else if(follower->Y < pastY)
                {
                    follower->Data = firstFollowerCombo + 4;
                }
                
                //!
                //!! You probably want if, not else-if here: -Z
                else if(follower->X > pastX)
                {
                    follower->Data = firstFollowerCombo + 7;
                }
                else if(follower->X < pastX)
                {
                    follower->Data = firstFollowerCombo + 6;
                }
                
                //If Link is holding down a directional button. Note that you should check for Press, too. -Z
                
                
                if(!(Link->InputUp || Link->InputDown || Link->InputRight || Link->InputLeft))
                {
                    if((follower->Data == (firstFollowerCombo + 4))||(follower->Data == (firstFollowerCombo + 5))||(follower->Data == (firstFollowerCombo + 6))||(follower->Data == (firstFollowerCombo + 7)))
                    {
                        follower->Data = follower->Data - 4;
                    }
                    else if((follower->Data == (firstFollowerCombo + 3))||(follower->Data == (firstFollowerCombo + 2))||(follower->Data == (firstFollowerCombo + 1))||(follower->Data == (firstFollowerCombo)))
                    {
                        //Do nothing? -Z
                    }
                    else
                    {
                        follower->Data = firstFollowerCombo;
                    }
                } //end check for input when not scrolling.
            } //end checks while scrolling
            //You could just have 'else' after this.
            if(Link->Action == LA_SCROLLING)
            {
                firstCheck = false; //Refresh on change screen.
            }
            
            //! Waitframe needs to be *inside* the loop. This would be much easier to spot if you
            //! used tabs to indent the code.
            
            Waitframe();
        } //End main loop.
    } //end run()
} //end global script





void BrangFlip()
{
    for (int i = Screen->NumLWeapons(); i > 0; i--) //Counting down is safer. Do not count 0 as that will log an error and cause lag.
    {
        lweapon Falcon = Screen->LoadLWeapon(i); //I would also mention, that ++i is different to i++.
                            //I noticed that in your earlier script, and ++i increments before the return.
                            //and i++ increments after the return.

        //Added Valid check and only check if falcon is brang. continue instruction is not needed.
        if (Falcon->ID == LW_BRANG )  
        { //Short circuit on the item ID. ZScript in 2.50 does not automaticall short circuit, so
            //every iteration will check all three of these conditions even if ONE IS FALSE.
            //By checking against the ID first, you remove any non-boomerange lweapons
            //from extraneous checks.
            if ( Falcon->isValid() && Falcon->Misc[BRANG_STATE] == 0)
            {
                BrangChange(Falcon); //Change if-else block to a function for easier use.

                //Set the checked value to the weapon dead state of WDS_BOUNCE or 1. For later checks.
                Falcon->Misc[BRANG_STATE] = WDS_BOUNCE; //Set this lweapon as checked, no need to set the direction again.
            }
            else if( Falcon->isValid() && Falcon->Misc[BRANG_STATE] == Falcon->DeadState)
            {
                BrangChange(Falcon); //Change tile again if Brang is now reflected and returning to Link.
                Falcon->Misc[BRANG_STATE] = -1; //Set to -1 to never use again.
            }
        }
    }
}


const int FALCON_TILE_BASE     = 21400; //The base tile.
const int FALCON_TILE_ALT     = 21408;  //The alternate tile.
// Putting it here as a constant makes changing it much easier later, if needed. -Z
// ...as you can change it in your code in ONE PLACE.


void BrangChange(lweapon Falcon)
{
    if (Falcon->Dir == DIR_DOWN)
    {
        Falcon->OriginalTile = FALCON_TILE_BASE; //I STRONGLY ADVISE making these CONSTANTS.
        Falcon->Flip = 3;
    }
    else if (Falcon->Dir == DIR_UP)
    {
        Falcon->OriginalTile = FALCON_TILE_BASE;
        Falcon->Flip = 0;
    }
    else if (Falcon->Dir == DIR_LEFTUP || Falcon->Dir == DIR_LEFTDOWN || Falcon->Dir == DIR_LEFT)
    {
        Falcon->OriginalTile = FALCON_TILE_ALT;
        Falcon->Flip = 2;
    }
    else //Changed to else as this is the last direction possible. Collapsed RIGHTUP, RIGHTDOWN, and RIGHT.
    {
        Falcon->OriginalTile = FALCON_TILE_ALT;
        Falcon->Flip = 0;
    }
}