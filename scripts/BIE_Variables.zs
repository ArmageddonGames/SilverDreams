//DMap variables
const int DMT_INTERIOR = 2;
const int DMT_OVERWORLD = 1;
const int DMT_DUNGEON = 0;
int CURRENTDMAP = 0;

//Day/Night cycle variables
const int SUNRISE = 1;
const int DAY = 0;
const int SUNSET = 2;
const int NIGHT = 3;
const int DAY_PAL = 0;
const int SUNRISET_PAL = 32;
const int NIGHT_PAL = 33;
const int NIGHT_OVERLAY_LAYER = 6;
int CYCLE = 0;

//In-game clock variables
const int CLOCK_SECONDS = 0;
const int CR_SECONDS = 30;
const int CLOCK_MINUTES = 1;
const int CR_MINUTES = 29;
const int CLOCK_HOURS = 2;
const int CR_HOURS = 28;
const int CLOCK_DAYS = 3;
const int CLOCK_MAX = 4;
int InGameClock[4]={-1, 0, 0, 1};


//Follower variables
int Binx = 17; //Item that makes the FFC follower follow you
int Caroline = 18;
int PartySwitcher = 255;
int FollowerCaroline = 32; //The number of the FFC used.  This script will "hijack" this one, so don't use it for anything else on screens when you expect the player to have a follower.
int FollowerBinx = 31; 
int firstFollowerCarolineCombo = 23568; //combo of the first combo.  In order, the concecutive combos must be "still up", "still down", "still left", "still right", "moving up", "moving down", "moving left", "moving right".
int firstFollowerBinxCombo = 24568;
int csetOfFollowerCaroline = 6;
int csetOfFollowerBinx = 6;
bool firstCheck = false; //leave this alone
ffc follower;
int pastX;
int currentX;
int followerX[13];
int pastY;
int currentY;
int followerY[13];
int index;
