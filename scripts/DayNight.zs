import "std.zh"
import "string.zh"


const int SUNRISE = 1;
const int DAY = 0;
const int SUNSET = 2;
const int NIGHT = 3;
const int DAY_PAL = 0;
const int SUNRISET_PAL = 32;
const int NIGHT_PAL = 33;
const int NIGHT_OVERLAY_LAYER = 6;
const int CLOCK_SECONDS = 0;
const int CR_SECONDS = 30;
const int CLOCK_MINUTES = 1;
const int CR_MINUTES = 29;
const int CLOCK_HOURS = 2;
const int CR_HOURS = 28;
const int CLOCK_DAYS = 3;
const int CLOCK_MAX = 4;
const int DMT_INTERIOR = 2;
const int DMT_DUNGEON = 0;
int InGameClock[4]={-1, 0, 0, 1};
int CYCLE = 0;
int CURRENTDMAP = 0;


global script slot2
{
void run()
{
    while (true)
    {
    Game->Counter[CR_SECONDS] = InGameClock[CLOCK_SECONDS];
    Game->Counter[CR_MINUTES] = InGameClock[CLOCK_MINUTES];
    Game->Counter[CR_HOURS] = InGameClock[CLOCK_HOURS];
    CURRENTDMAP = Game->GetCurDMap();   
    InGameClock();
    DayNightCycle();
    Waitframe();
}
}
}

void DayNightCycle()
{
    dmapdata dm = Game->LoadDMapData(Game->GetCurDMap());
    int type = dm->Type; TraceNL(); TraceS("Detected DMap Type: "); Trace(type); 
    
if ( type == DMT_INTERIOR )
    {
        return;
    }
if ( type == DMT_DUNGEON )
    {
        return;
    } 
else
    {
if ((InGameClock[CLOCK_HOURS] >= 6) && (InGameClock[CLOCK_HOURS] < 7) && (CYCLE != SUNRISE))
{
    CYCLE = SUNRISE;
    Game->DMapPalette[CURRENTDMAP] = SUNRISET_PAL;
}
else if ((InGameClock[CLOCK_HOURS] >= 7) && (InGameClock[CLOCK_HOURS] < 19) && (CYCLE != DAY))
{
    CYCLE = DAY;
    Game->DMapPalette[CURRENTDMAP] = DAY_PAL;
}
else if ((InGameClock[CLOCK_HOURS] >= 19) && (InGameClock[CLOCK_HOURS] < 20) && (CYCLE != SUNSET))
{
    CYCLE = SUNSET;
    Game->DMapPalette[CURRENTDMAP] = SUNRISET_PAL;
}
else if (CYCLE != NIGHT)
{
    CYCLE = NIGHT;
    Game->DMapPalette[CURRENTDMAP] = NIGHT_PAL;
}   
}
}

void InGameClock()
{
        InGameClock[CLOCK_SECONDS] +=2;
    if ( InGameClock[CLOCK_SECONDS] == 60 ) 
    {
        InGameClock[CLOCK_SECONDS] = 0;
        InGameClock[CLOCK_MINUTES] +=1;
    }
    if ( InGameClock[CLOCK_MINUTES] == 60 ) 
    {
        InGameClock[CLOCK_MINUTES] = 0;
        InGameClock[CLOCK_HOURS] +=1;
    }
    if ( InGameClock[CLOCK_HOURS] == 24 ) 
    {
        InGameClock[CLOCK_HOURS] = 0;
        InGameClock[CLOCK_DAYS] +=1;
    }
}

