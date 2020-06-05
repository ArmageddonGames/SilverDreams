//This script uses internal variables already in std.zh, so when you're reading it,
//remember that all variables refer to the weapon's TYPE and not its GRAPHIC.
//For set-up, replace the tile used as a graphic on ALL Bow items with the tile used for regular arrows.
//It's important that the arrows be identical, to keep the illusion.
//Set the graphics for each Arrow item to a different bow tile
//Set your speeds and damages and MP cost as you wish in the editor, speed can only be set by Bow and damage can only be set on arrows make sure the MP cost is done on the arrow item.

//The end result of this script is that you will have 3 bows on your subscreen, but each will actually be an arrow class item.
//What the script will do is check to see if one of the arrow class items (which graphically look like bows) is selected as a button item
//depending on which one is selected, it will change which "arrow" (which is really a bow) you have equipped. This is why it's important that all three bow-class items use identical arrow graphics

   
const int I_BOW3 = 255 //set this to the item id number of the third bow that will look like an arrow.

global script BowForArrowSlot2
{
    void run()
    {
        while(true);
        {
            BowForArrow();
            Waitframe();
        }
    }
}


void BowForArrow()
{
    if ((!Link->Item[I_BOW1]) && (!Link->Item[I_BOW2]) && (!Link->Item[I_BOW3]))
    {
        return;
    }
    else
    {
    if ((GetEquipmentA() == I_ARROW1) || (GetEquipmentB() == I_ARROW1))
    {
        if (!Link->Item[I_BOW1])
        {
        Link->Item[I_BOW1] = true;
        Link->Item[I_BOW2] = false;
        Link->Item[I_BOW3] = false;
        return;
        }
        else
        {
            return;
        }
    }
    else if ((GetEquipmentA() == I_ARROW2) || (GetEquipmentB() == I_ARROW2))
    {
        if (!Link->Item[I_BOW2])
        {
        Link->Item[I_BOW1] = false;
        Link->Item[I_BOW2] = true;
        Link->Item[I_BOW3] = false;
        return;
        }
        else
        {
            return;
        }
    }
    else if ((GetEquipmentA() == I_ARROW3) || (GetEquipmentB() == I_ARROW3))
    {
        if (!Link->Item[I_BOW3])
        {
        Link->Item[I_BOW1] = false;
        Link->Item[I_BOW2] = false;
        Link->Item[I_BOW3] = true;
        return;
        }
        else
        {
            return;
        }
    }
    else
    {
        return;
    }
    }
}

