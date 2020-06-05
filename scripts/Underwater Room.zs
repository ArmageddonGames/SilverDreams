//UNDERWATER Room Script by Mero

//Constants used by the Underwater Room script.
const int I_ZORATUNIC   = 123; //If link has this item in his inventory he will be immune to the effects of UNDERWATER rooms.
const int CR_SECONDS    = 31;  //A CR_ variable used by Game->Counter[] as a second counter.
const int UNDERWATERROOM_FLAG  = 0;   //This is the general use screen flag to use for UNDERWATER rooms under the misc category. Values 0-4
const int UNDERWATERROOM_TIME  = 150; //This is the amount of seconds to allow Link to stay in a UNDERWATER room for.
const int SOLID_WHITE   = 1;   //Solid white color from the palette.
const int SOLID_BLACK   = 16;  //Solid black color from the palette.

bool underwaterroominit = false;
int underwaterroomtimer = 0;

global script slot2_underwaterroom
{
    void run()
    {
        //Main Loop
        while(true)
        {
            Update_UnderwaterRoom();
            Waitframe();
        }
    }
}

void Update_UnderwaterRoom()
{
    if(Link->Item[I_ZORATUNIC])
    {
        underwaterroominit = false;
        return;
    }
    else if((Screen->Flags[SF_MISC] & 4<<UNDERWATERROOM_FLAG)!=0)
    {
        if(underwaterroominit)
        {
            Game->Counter[CR_SECONDS] = (Game->Counter[CR_SECONDS] + 1)%60;
            if(Game->Counter[CR_SECONDS] == 0) underwaterroomtimer--;
        }
        else underwaterroomtimer = UNDERWATERROOM_TIME;
        underwaterroominit = true;
        if(underwaterroomtimer == 0)
        {
            underwaterroominit = false;
            Link->HP = 0;
            Quit();
        }
    }
    else
    {
        underwaterroominit = false;
        underwaterroomtimer = 0;
        return;
    }
    if(underwaterroominit)
    {
        //Create an array of characters.
        int string[5];
        //Add the minutes to the array.
        itoa(string, 0, Div(underwaterroomtimer, 60));
        //Add the : after the minutes.
        string[strlen(string)] = ':';
        //Add the seconds after the colon.
        int seconds = underwaterroomtimer % 60;
        if(seconds < 10) string[strlen(string)] = '0';
        itoa(string, strlen(string), seconds);
        //Draw the timer to the screen.
        Screen->DrawString(7, 0, 0, FONT_DEF, SOLID_WHITE, SOLID_BLACK, TF_NORMAL, string, 128);
    }
}