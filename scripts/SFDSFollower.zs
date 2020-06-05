global script slot_2{
    void run(){

    int Brian = 17; //Item that makes the FFC follower follow you
    int Justin = 18;
    int FollowerJustin = 32; //The number of the FFC used.  This script will "hijack" this one, so don't use it for anything else on screens when you expect the player to have a follower.
    int FollowerBrian = 31; 
    int firstFollowerJustinCombo = 23568; //combo of the first combo.  In order, the concecutive combos must be "still up", "still down", "still left", "still right", "moving up", "moving down", "moving left", "moving right".
    int firstFollowerBrianCombo = 24568;
    int csetOfFollowerJustin = 3;
    int csetOfFollowerBrian = 4;
    bool firstCheck = false; //leave this alone
    ffc follower;

    int pastX;
    int currentX;
    int followerX[13];

    int pastY;
    int currentY;
    int followerY[13];

    int index;

        while(true){

    if(Link->Item[Brian] == true){
        if(Link->Action != LA_SCROLLING && firstCheck == false){
        follower = Screen->LoadFFC(FollowerJustin);
        follower->Data = firstFollowerJustinCombo;
        follower->CSet = csetOfFollowerJustin;

        pastX = Link->X;
        follower->X = Link->X;
        pastY = Link->Y;
        follower->Y = Link->Y;

        for ( int i = 0; i < 13; i++ ){
            followerX[i] = Link->X;
            followerY[i] = Link->Y;
        }

        firstCheck = true;
        }
        if(Link->Action != LA_SCROLLING){
        if((Link->InputUp || Link->InputDown || Link->InputRight || Link->InputLeft)&&(!(Link->InputA || Link->InputB))){
            pastX = follower->X;
            follower->X = followerX[0];
            for(index=0; index<12; index++){
            followerX[index] = followerX[index + 1];
            }
            followerX[12] = Link->X;

            pastY = follower->Y;
            follower->Y = followerY[0];
            for(index=0; index<12; index++){
            followerY[index] = followerY[index + 1];
            }
            followerY[12] = Link->Y;
        }

        if(follower->Y > pastY){
            follower->Data = firstFollowerJustinCombo + 5;
        }
        else if(follower->Y < pastY){
            follower->Data = firstFollowerJustinCombo + 4;
        }
        else if(follower->X > pastX){
            follower->Data = firstFollowerJustinCombo + 7;
        }
        else if(follower->X < pastX){
            follower->Data = firstFollowerJustinCombo + 6;
        }
        if(!(Link->InputUp || Link->InputDown || Link->InputRight || Link->InputLeft)){
            if((follower->Data == (firstFollowerJustinCombo + 4))||(follower->Data == (firstFollowerJustinCombo + 5))||(follower->Data == (firstFollowerJustinCombo + 6))||(follower->Data == (firstFollowerJustinCombo + 7))){
            follower->Data = follower->Data - 4;
            }
            else if((follower->Data == (firstFollowerJustinCombo + 3))||(follower->Data == (firstFollowerJustinCombo + 2))||(follower->Data == (firstFollowerJustinCombo + 1))||(follower->Data == (firstFollowerJustinCombo))){
                
            }
            else{
            follower->Data = firstFollowerJustinCombo;
            }
        }
            }
        if(Link->Action == LA_SCROLLING){
        firstCheck = false;
            }
   else if(Link->Item[Justin] == true){
        if(Link->Action != LA_SCROLLING && firstCheck == false){
        follower = Screen->LoadFFC(FollowerBrian);
        follower->Data = firstFollowerBrianCombo;
        follower->CSet = csetOfFollowerBrian;

        pastX = Link->X;
        follower->X = Link->X;
        pastY = Link->Y;
        follower->Y = Link->Y;

        for ( int i = 0; i < 13; i++ ){
            followerX[i] = Link->X;
            followerY[i] = Link->Y;
        }

        firstCheck = true;
        }
        if(Link->Action != LA_SCROLLING){
        if((Link->InputUp || Link->InputDown || Link->InputRight || Link->InputLeft)&&(!(Link->InputA || Link->InputB))){
            pastX = follower->X;
            follower->X = followerX[0];
            for(index=0; index<12; index++){
            followerX[index] = followerX[index + 1];
            }
            followerX[12] = Link->X;

            pastY = follower->Y;
            follower->Y = followerY[0];
            for(index=0; index<12; index++){
            followerY[index] = followerY[index + 1];
            }
            followerY[12] = Link->Y;
        }

        if(follower->Y > pastY){
            follower->Data = firstFollowerBrianCombo + 5;
        }
        else if(follower->Y < pastY){
            follower->Data = firstFollowerBrianCombo + 4;
        }
        else if(follower->X > pastX){
            follower->Data = firstFollowerBrianCombo + 7;
        }
        else if(follower->X < pastX){
            follower->Data = firstFollowerBrianCombo + 6;
        }
        if(!(Link->InputUp || Link->InputDown || Link->InputRight || Link->InputLeft)){
            if((follower->Data == (firstFollowerBrianCombo + 4))||(follower->Data == (firstFollowerBrianCombo + 5))||(follower->Data == (firstFollowerBrianCombo + 6))||(follower->Data == (firstFollowerBrianCombo + 7))){
            follower->Data = follower->Data - 4;
            }
            else if((follower->Data == (firstFollowerBrianCombo + 3))||(follower->Data == (firstFollowerBrianCombo + 2))||(follower->Data == (firstFollowerBrianCombo + 1))||(follower->Data == (firstFollowerBrianCombo))){
                
            }
            else{
            follower->Data = firstFollowerBrianCombo;
            }
        }
            }
        if(Link->Action == LA_SCROLLING){
        firstCheck = false;
            }
    }
    }

        Waitframe();

        }
    }
}