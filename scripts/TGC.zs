import "std.zh"

/////////////////////////////////////////////////
//Import mandatory script headers and packages.//
/////////////////////////////////////////////////

import "ffcscript.zh"
import "string.zh"
import "ghost.zh"


////////////////////////////////////////////////////////////////////
//Set up environment, Base Ints, Consts, Floats, Bools, Vars, etc.//
////////////////////////////////////////////////////////////////////

int Drinks_Left;
const int SFX_DRINK = 52;
const int ThunderSFX = 73;
const int NPC_SPECIALENEMY = 1; //The ID of your special enemy
const int LW_EFFECT = 31;
const int SFX_ERROR = 65; //In case you want an error SFX
const int SFX_MAGICCHARGE = 62;
const int SFX_LIGHTARROW = 1;
const int lightColor = 134; //Color of the charging ring: CSet# * 16 + color# (from 0 to 15)
const int WPS_NONE = 101; //Weapon sprite with an empty tile (for superlight arrow)
const float ORBIT_SPEED = 2.5;
const float ORBIT_RADIUS = 48;
int f1 = 0;
int f2 = 0;
int rad = 0;
int slower = 0;
int bombs = 0;
int r1 = 0;
int r2 = 0;
int slowera = 0;
int ffcslot = 1;
int usebombodo = 0;
int ringTimer;	
int byrnaTimer;
int bootsTimer;
//const int ringShadowTile = 0; //Shadow tile for invisble Link
//const int ringShadowCSet = 7; //CSet of this tile
const int ringTimePerMP = 30; //How many frames 1 unit of MP lasts with the One Ring or Cape at 60F/s
const int byrnaTimePerMP = 60; //How many frames 1 unit of MP lasts with the Cane of Byrna at 60F/s
const int bootsTimePerMP = 100; //How many frames 1 unit of MP lasts with the Boots at 60F/s
bool ringOn;
bool byrnaOn;
bool bootsOn;

////////////////////////
/// BEGIN XP SCRIPTS ///
////////////////////////

//==================================================================
//                   ==== * INSTRUCTIONS * ====

//All items: Set their IDs in the I_ constants
//Sound effects: Set the sounds in the SFX_ constants (0 disables the sound)
//Settings: Read the descriptions of the EXP_ constants before editing
//Treasure Hunter: Set the screen flag "General Purpose 1" on screens with chests
//Meter: Read the descriptions of the EXP_METER_ constants before editing

//===================================================================

const int I_FASTWALK = 17; //ID of the fast walk item
const int I_LEADERSHIP = 17; //ID of the leadership item
const int I_TREASUREHUNTER = 17; //ID of the treasure hunter item

const int CR_EXP = 9; //Counters for EXP and level (default 3 & 4)
const int CR_LEVEL = 10;

const int SFX_LEVEL = 32; //SFX to play when you level up (0 = disable)
const int SFX_TREASURESCREEN = 27; //SFX to play when Treasure Hunter activates

const int EXP_HP_RATIO = 4; //Enemy EXP value = HP divided by this
const int EXP_PER_LEVEL = 100; //Amount of EXP to level up
const int EXP_MAX_LEVEL = 20; //Highest possible level
const int EXP_LEADERSHIPCHANCE = 10; //One in {this} chance to get +1 exp
const int EXP_FASTWALKRATE = 5; //Every {this} frames, walk an extra pixel

const int EXP_METER_X = 50; //Starting coordinates of the EXP meter
const int EXP_METER_Y = -8; //Subscreen Y values are < 0; need to play around with this
const int EXP_METER_WIDTH = 8; //How wide the meter is
const int EXP_METER_LENGTH = 64; //How long the meter can get
const int EXP_METER_COLOR = 1; //Color = (CSet# * 16) + color within CSet from 0 to 15

const int SF_TREASURE = 0; //Which screen flag to check for treasure (default Script1)

const int HP_DEAD = -999; //Enemy has been counted for EXP (don't touch)
const int NPC_MISC_MAXHP = 0; //Which npc->Misc[] value to store HP in (don't touch)

//////////////////////
/// END XP SCRIPTS ///
//////////////////////

const int DRAW_OPAQUE = 128;
const int DRAW_TRANSPARENT = 64;
int healsfx = 39; //Sound effect to play when Link is healed
int errorsfx = 65; //Sound effect to play when Link's HP is full or MP is empty
const int WLS_LASERCOLOR = 181; //Color of the laser beam: [CSet# * 16] + [Color within CSet from 0 to 15]
const int WLS_LASEROPACITY = 90; //128 = Opaque, 64 = Transparent
const float WLS_LASERSIDEDAMAGE = 0.5; //Percent damage dealt by touching side of beam (0 = disable)
//Dalek beam colour choices 98 - 147 - 182
//SHOP COnstants
const int COLOR_TEXT = 10;
const int COLOR_BG = 00;

////////////////////////////
///Laser Sentry Constants///
////////////////////////////

const int SFX_ALARM = 67; //Error sound or sentry alert
const int SFX_LASER = 61; //Laser fired

const int LS_ATTRIB_ROTSPEED = 0; //Misc Attr 1
const int LS_ATTRIB_RADIUS = 1; //... 2
const int LS_ATTRIB_DELAY = 2; //... 3
const int LS_ATTRIB_COOLDOWN = 3; //... 4
const int LS_ATTRIB_LASERCOLOR = 4; //... 5

//////////////////////////////////////////
//Import global, item abnd FFC scripts.///
//////////////////////////////////////////

//Scripts that have an comment with NYU are not yet used. Scripts that are just commented out are disabled and were for testing or for other people.

//////////////////
//Global Scripts//
//////////////////

//import "gc_global_base.z" //Has HPMP Counters and HPC, but not the staff or mirror code.
//import "gc_global_working.z"
//import "gc_global_testing.z" //Broken at present. Will cause game to crash on Frame-1
//import "gc_global_ghost.z" //Drains MP on Init until Ring or Staff are used.
//import "gc_global_MM.z"  //MoscowModder's revision of the global_working script.
//import "gc_global_MM_ghost.z" //MoscowModder's revision of global plus Autoghost.
//import "gc_global_MM_ghost_MP_items.z" //MoscowModder's revision of global plus Autoghost with MP items.
//import "gc_global_MM_ghost_MP_items_trowel.z" //As above, plus Trowel scripts.
//import "gc_global_MM_ghost_MP_items_trowel_v2.z" //Updated with SFX.
//import "gc_global_MM_ghost_MP_items_trowel_v2.z" //Plus Solid FFCs - Do Not Use
import "gc_global_MM_ghost_MP_items_trowel_v2_xp.z" //Plus XP System
//import "gc_global_MM_ghost_MP_items_trowel_v8_xp.z" //Plus XP System


import "gc_std_extra_MM.zh" //MoscowModder's std.zh-extensions.

//Enemies thqat break the hpmpcountrs script are Green Dragon Moldorm 10 Moldorm 20 digdogger Kid and BS Dodongo

////////////////////////
//Item and FFC Scripts//
////////////////////////

import "gc_lightarrow.z"
import "gc_timestop.z"
import "gc_key.z"
import "gc_healing.z"
import "gc_restoremp.z"
import "gc_rupeegainloss.z"
//import "gc_mirrorold.z"
import "gc_sernaran_pickup.z"
import "gc_increase_counter_max.z"
import "gc_mcp_old.z"
//import "gc_lonlon.z"
import "gc_tremor.z"
import "gc_detonate.z"
//import "gc_bolt.z"
//import "gc_bolt_v2.z"
//import "gc_bolt_v3.z"
//import "gc_bolt_v4.z"
import "gc_bolt_v8.z"
import "gc_cane_and_mirror.z"
import "gc_beamos.z"
import "gc_jhkarr.z"
import "gc_boots.z"
import "gc_calmen.z"
//import "gc_jumpblock.z"
import "gc_jumpblock_v1.z"
//import "gc_stazer.z"
import "gc_stazer_v2.z"
import "gc_trowel.z"
//import "gc_inferno.z"
import "gc_mirror_new.z"
import "gc_bolt_ffc.z"
import "gc_wand_item_2A.z"
import "gc_generic_projectile_lweapon.z"

///////////////////////
////  THE DALEKS  /////
///////////////////////

//const int WLS_LASERCOLOR = 183; //Color of the laser beam: [CSet# * 16] + [Color within CSet from 0 to 15]
//const int WLS_LASEROPACITY = 108; //128 = Opaque, 64 = Transparent
// Dalek Colour 182, 1, 0, 0, 0, 90 
//Dalek beam colour choices 98 - 147 - 182 - 183

//import "gc_dalek_v5.z"
import "gc_dalek_v6.z" // Working, but jittery Daleks - Dizzy, dizzy, dizzy Daleks.
//import "gc_dalek_v7.z"  //Diabled turning in the script -- They can't functionj without it. Reverting to v6.

//////////////////////////////
//// DALEK LASER SHIP GUN ////
//////////////////////////////

//import "gc_lasersentry.z"
//import "gc_lasersentry_v1.z"
//import "gc_lasersentry_v2.z"
//import "gc_lasersentry_v3.z"
//import "gc_lasersentry_v4.z"
//import "gc_lasersentry_v5.z"
import "gc_lasersentry_v6.z" 

////////////////////
/// SHOP SCRIPTS ///
////////////////////

import "gc_shop.z"

////////////////////
/// FFC SOLIDIDY ///
////////////////////

//import "gc_solidify.z"
//import "gc_solid_NPC.z"
import "gc_solid_NPC_v3.z"
import "gc_solid_FFC_for_enemies_only.z"

//////////////////////////
/////     BOSSES     /////
//////////////////////////

import "gc_Dragon.z"

//////////////////////////
/////  GAME CREDITS  /////
//////////////////////////


//CREDITS for Scripts (Aplhabetical)
//MoscowModder -- One of the most amazing, and talented ZC Scripters out there. Aside from the obvious, he is responsible for the Daleks and other laser shootig enemies. Doumo arigatou gozaimashita MM-san!
//Safith -- THis wonderful man managed to get the HP & MP COunters to work, and is responsible for Ghost.zh and pretty much for getting 2.50 finished. We all love you mate!
//tox_von for the Bombodos script
//ZoriaRPG for making things work, making modifications, a few custom things, and combining it all in a way that functions.
//Please let me know if I'm using your scripts. I will always give credit.

//CREDITS for Gametesting
//Miop - Initial concept teating.
//Ryunaker - For EXTENSIVE gametesting, suggestions, contributions and support!