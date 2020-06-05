//Setup Instructions:

//Create 2 additional sets of Link sprites, one for the rank of Captain, one for the rank of Trainee

//Create 4 items, one labelled "Trainee", one labelled "Standard" and one labelled "Captain" and one as "Captain (Dummy)". Make sure they are flagged as equipment.
//Set the Link Tile Modifier on item "Captain" to 1040, set the modifier on "Trainee" to 2080. Make sure that "Standard" and "Captain (dummy)" have LTM of 0.
//Make sure Captain is level 3, Standard is level 2 and Trainee is level 1. Make "Captain (dummy)" a different item class Make sure "keep lower level items" is checked for Captain and NOT checked for Standard.
//Edit the names of the ring items to Knight's Tunic (for blue), Royal Guard Tunic (for red), and Hero's/Champion's (for Gold)
//Nerf Royal Guard damage divisor to 3 and Hero/Champion to 4
//Nerf Magic Sword and Master Sword damage to 3 and 4 
//Edit Hero's/Champion's Tunic's sprite CSet to whichever color you like (I recommend a darker green, with a brighter, Z1 style green for the "Guard" (no ring) CSet)
//Add "Trainee" item

//Make sure the sprites on your tile page are in the correct order. The proper order, as intended by this script is:
//Standard, No Shield; Standard, Shield 1; Standard, Shield 2; Standard, Shield 3;
//Captain, No Shield; Captain, Shield 1; Captain, Shield 2; Captain, Shield 3;
//Trainee, No Shield; Trainee, Shield 1; Trainee, Shield 2; Trainee, Shield 3; 
//If you use a different order, make sure you adjust your LTMs and the values in the script accordingly.


 //For rank system promotion:
 //Apply FFC script "Promotion" to invisible FFC onscreen

//Rank Item Constants   
const int RANK_TRAINEE = 255; //Set this to the item # of the "Trainee" item
const int RANK_STANDARD = 254; //Set this to the item # of "Standard" item
const int RANK_CAPTAIN = 253; //Set this to the item # of "Captain" item
const int RANK_CAPTAIN_DUMMY = 252; ////Set this to the item # of "Captain" item
const int RANK_KNIGHT = 17;  //Item # of Blue Ring
const int RANK_ROYAL_GUARD = 18; //Item # of Red Ring
const int RANK_HERO = 61; //Item # of Gold Ring


//String Number constants
const int INTRO = 1; //string # for first meeting with King
const int PROMOTION_1 = 2; //String # for first promotion
const int PROMOTION_2 = 3;
const int PROMOTION_3 = 4;
const int PROMOTION_4 = 5;
const int PROMOTION_5 = 6;
const int PROMOTION_6 = 7;
const int GET_GOING = 8; //String # for response if you haven't gotten a Triforce Piece since your last promotion


//For restricted item:
//Apply FFC script "Restricted_Item" to an FFC that looks like the restricted item
//Set D0 argument to the item id # of the subrank (trainee,standard, captain (dummy)) item. Do NOT use "Captain" item, as that will cause a bug.
//Set D1 argument to the item id # of the rank (Knight, Royal Guard, Hero/Champion)
//Set D2 argument to the item id # the item you're restricting.
ffc script Restricted_Item
{
    void run(int subrank, int rank, int itemid) 
    {
        if ((Link->Item[subrank] == true) && (Link->Item[rank] == true))
        {
            CreateItemAt(itemid, this->X, this->Y);
            return;
        }
        else
        {
            return;
        }
    }
    
}


ffc script Promotion
{
    void run()
    {
        if ((Link->Item[RANK_TRAINEE] == true) && (NumTriforcePieces() == 0))
        {
            Screen->Message(INTRO);
            return;
        }
        else if ((Link->Item[RANK_TRAINEE] == true) && (NumTriforcePieces() == 1))
        {
            Screen->Message(PROMOTION_1);
            Link->Item[RANK_STANDARD] = true;
            Link->Item[RANK_TRAINEE] = false;
            Game->MCounter[CR_LIFE] += 16;
            Game->DCounter[CR_LIFE] +=16;
            return;
        }
        else if ((Link->Item[RANK_STANDARD] == true) && (Link->Item[RANK_KNIGHT] == false) && (Link->Item[RANK_ROYAL_GUARD] == false) && (Link->Item[RANK_HERO] == false) && (NumTriforcePieces() == 2))
        {
            Screen->Message(PROMOTION_2);
            Link->Item[RANK_CAPTAIN] = true;
            Link->Item[RANK_CAPTAIN_DUMMY] = true;
            Game->MCounter[CR_MAGIC] += 32;
            Game->DCounter[CR_MAGIC] +=32;
            return;
        }
        else if ((Link->Item[RANK_CAPTAIN] == true) && (Link->Item[RANK_KNIGHT] == false) && (Link->Item[RANK_ROYAL_GUARD] == false) && (Link->Item[RANK_HERO] == false) && (NumTriforcePieces() == 3))
        {
            Screen->Message(PROMOTION_3);
            Link->Item[RANK_CAPTAIN] = false;
            Link->Item[RANK_KNIGHT] = true;
            Link->Item[I_SWORD2] = true;
            Link->Item[I_SHIELD2] = true;
            return;
        }
        else if ((Link->Item[RANK_STANDARD] == true) && (Link->Item[RANK_KNIGHT] == true) && (Link->Item[RANK_ROYAL_GUARD] == false) && (Link->Item[RANK_HERO] == false) && (NumTriforcePieces() == 4))
        {
            Screen->Message(PROMOTION_4);
            Link->Item[RANK_CAPTAIN] = true;
            Game->MCounter[CR_LIFE] += 16;
            Game->DCounter[CR_LIFE] +=16;
            Game->MCounter[CR_MAGIC] += 32;
            Game->DCounter[CR_MAGIC] +=32;
            return;
        }
        else if ((Link->Item[RANK_CAPTAIN] == true) && (Link->Item[RANK_KNIGHT] == true) && (Link->Item[RANK_ROYAL_GUARD] == false) && (Link->Item[RANK_HERO] == false) && (NumTriforcePieces() == 5))
        {
            Screen->Message(PROMOTION_5);
            Link->Item[RANK_CAPTAIN] = false;
            Link->Item[RANK_ROYAL_GUARD] = true;
            Link->Item[I_SWORD3] = true;
            return;
        }
        else if ((Link->Item[RANK_STANDARD] == true) && (Link->Item[RANK_KNIGHT] == true) && (Link->Item[RANK_ROYAL_GUARD] == true) && (Link->Item[RANK_HERO] == false) && (NumTriforcePieces() == 6))
        {
            Screen->Message(PROMOTION_1);
            Link->Item[RANK_HERO] = true;
            Link->Item[I_SWORD4] = true;
            Link->Item[I_SHIELD3] = true;
            return;
        }
        else
        {
            Screen->Message(GET_GOING);
        }
        
    }
}
