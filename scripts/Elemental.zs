// The fake amount of hp.
 
const int ELEMENT_FIRE = 1;
const int ELEMENT_FOREST = 2;
const int ELEMENT_WATER = 3;
const int ELEMENT_WIND = 4;
const int ELEMENT_ICE = 5;
const int ELEMENT_EARTH = 6;
const int ELEMENT_LIGHT=7;
const int ELEMENT_SHADOW = 8;
const int ELEMENT_SPIRIT = 9;
 
// Misc slot for enemy initialization state.
const int MISC_NPC_INIT = 0;
// Misc slot for npc's hp last frame..
const int MISC_NPC_OLD_HP = 1;
// Misc slot for npc's element.
const int MISC_NPC_ELEMENT = 2;

//Global variables for Link
int MISC_LINK_HP = 0;
int Link_Defense = 1;
int Link_Element = 0;

int GetDamageMultiplier(int attackElement, int targetElement) {
  if (attackElement == 0 && targetElement == 0) {return 1;}
  else if (attackElement > 0 && targetElement == 0) {return 0.5;}
  else if (attackElement == ELEMENT_FIRE && targetElement == ELEMENT_FIRE) {return 0;}
  else if (attackElement == ELEMENT_FOREST && targetElement == ELEMENT_FOREST) {return 0;}
  else if (attackElement == ELEMENT_WATER && targetElement == ELEMENT_WATER) {return 0;}
  else if (attackElement == ELEMENT_WIND && targetElement == ELEMENT_WIND) {return 0;}
  else if (attackElement == ELEMENT_ICE && targetElement == ELEMENT_ICE) {return 0;}
  else if (attackElement == ELEMENT_EARTH && targetElement == ELEMENT_EARTH) {return 0;}
  else if (attackElement == ELEMENT_LIGHT && targetElement == ELEMENT_LIGHT) {return 0;}
  else if (attackElement == ELEMENT_SHADOW && targetElement == ELEMENT_SHADOW) {return 0;}
  else if (attackElement == ELEMENT_SPIRIT && targetElement == ELEMENT_SPIRIT) {return 0;}
  else if (attackElement == ELEMENT_FIRE && targetElement == ELEMENT_FOREST) {return 2;}
  else if (attackElement == ELEMENT_FOREST && targetElement == ELEMENT_WATER) {return 2;}
  else if (attackElement == ELEMENT_WATER && targetElement == ELEMENT_FIRE) {return 2;}
  else if (attackElement == ELEMENT_WIND && targetElement == ELEMENT_ICE) {return 2;}
  else if (attackElement == ELEMENT_ICE && targetElement == ELEMENT_EARTH) {return 2;}
  else if (attackElement == ELEMENT_EARTH && targetElement == ELEMENT_WIND) {return 2;}
  else if (attackElement == ELEMENT_LIGHT && targetElement == ELEMENT_SHADOW) {return 2;}
  else if (attackElement == ELEMENT_SHADOW && targetElement == ELEMENT_SPIRIT) {return 2;}
  else if (attackElement == ELEMENT_SPIRIT && targetElement == ELEMENT_LIGHT) {return 2;}
  else if (attackElement == ELEMENT_FIRE && targetElement == ELEMENT_WATER) {return 0.5;}
  else if (attackElement == ELEMENT_FOREST && targetElement == ELEMENT_FIRE) {return 0.5;}
  else if (attackElement == ELEMENT_WATER && targetElement == ELEMENT_FOREST) {return 0.5;}
  else if (attackElement == ELEMENT_WIND && targetElement == ELEMENT_EARTH) {return 0.5;}
  else if (attackElement == ELEMENT_ICE && targetElement == ELEMENT_WIND) {return 0.5;}
  else if (attackElement == ELEMENT_EARTH && targetElement == ELEMENT_ICE) {return 0.5;}
  else if (attackElement == ELEMENT_LIGHT && targetElement == ELEMENT_SPIRIT) {return 0.5;}
  else if (attackElement == ELEMENT_SHADOW && targetElement == ELEMENT_LIGHT) {return 0.5;}
  else if (attackElement == ELEMENT_SPIRIT && targetElement == ELEMENT_SHADOW) {return 0.5;}
 
  // Finally, return 1 if for some reason we haven't found a multiplier yet.
  return 1;}
 
// Updates all npcs.
void NPC_Update() {
  for (int i = 1; i <= Screen->NumNPCs(); i++) {
    NPC_Update(Screen->LoadNPC(i));}}
 
// Updates this npc.
void NPC_Update(npc n) {
  NPC_Initialize(n);
  NPC_Damage(n);}
 
// If this NPC hasn't been initialized, do so and mark it.
void NPC_Initialize(npc n) {
  // Exit out if they've already been initialized.
  if (n->Misc[MISC_NPC_INIT] != 0) {return;}
  // Record their current HP.
  n->Misc[MISC_NPC_OLD_HP] = n->HP;
  // Set their element to Misc Attribute 11.
  n->Misc[MISC_NPC_ELEMENT] = n->Attributes[10];
  // Mark them as initialized.
  n->Misc[MISC_NPC_INIT] = 1;}
 
// Take damage as appropriate.
void NPC_Damage(npc n) {
  // See if we took any hits, and quit if we didn't.
  int hit = n->Misc[MISC_NPC_OLD_HP] - n->HP;
  if (hit <= 0) {return;}
  // Go back up to the hp we had before (so we can subtract the proper
  // amount this time.)
  n->HP = n->Misc[MISC_NPC_OLD_HP];
  // Item editor only let's us specify damage in increments of 2,
  // so half the damage here where we interpret it.
  hit >>= 1;
  // Interpret the hit value.
  int element = hit % 10;
  int damage = (hit * 0.2) >> 0;
  // Damage multipliers
  damage *= GetDamageMultiplier(element, n->Misc[MISC_NPC_ELEMENT]);
  // Apply damage.
  n->HP -= damage;
  // Update the 'old' value to the new amount.
  n->Misc[MISC_NPC_OLD_HP] = n->HP;
}


int GetLinkDamageMultiplier(int attackElement, int Link_Element) {
  if (attackElement == 0 && Link_Element == 0) {return 1;}
  else if (attackElement == ELEMENT_FIRE && Link_Element == ELEMENT_FIRE) {return 0.75;}
  else if (attackElement == ELEMENT_FOREST && Link_Element == ELEMENT_FOREST) {return 0.75;}
  else if (attackElement == ELEMENT_WATER && Link_Element == ELEMENT_WATER) {return 0.75;}
  else if (attackElement == ELEMENT_WIND && Link_Element == ELEMENT_WIND) {return 0.75;}
  else if (attackElement == ELEMENT_ICE && Link_Element == ELEMENT_ICE) {return 0.75;}
  else if (attackElement == ELEMENT_EARTH && Link_Element == ELEMENT_EARTH) {return 0.75;}
  else if (attackElement == ELEMENT_LIGHT && Link_Element == ELEMENT_LIGHT) {return 0.75;}
  else if (attackElement == ELEMENT_SHADOW && Link_Element == ELEMENT_SHADOW) {return 0.75;}
  else if (attackElement == ELEMENT_SPIRIT && Link_Element == ELEMENT_SPIRIT) {return 0.75;}
  else if (attackElement == ELEMENT_FIRE && Link_Element == ELEMENT_FOREST) {return 1.5;}
  else if (attackElement == ELEMENT_FOREST && Link_Element == ELEMENT_WATER) {return 1.5;}
  else if (attackElement == ELEMENT_WATER && Link_Element == ELEMENT_FIRE) {return 1.5;}
  else if (attackElement == ELEMENT_WIND && Link_Element == ELEMENT_ICE) {return 1.5;}
  else if (attackElement == ELEMENT_ICE && Link_Element == ELEMENT_EARTH) {return 1.5;}
  else if (attackElement == ELEMENT_EARTH && Link_Element == ELEMENT_WIND) {return 1.5;}
  else if (attackElement == ELEMENT_LIGHT && Link_Element == ELEMENT_SHADOW) {return 1.5;}
  else if (attackElement == ELEMENT_SHADOW && Link_Element == ELEMENT_SPIRIT) {return 1.5;}
  else if (attackElement == ELEMENT_SPIRIT && Link_Element == ELEMENT_LIGHT) {return 1.5;}

 
  // Finally, return 1 if for some reason we haven't found a multiplier yet.
  return 1;}
 
 
// Updates Link.
void Link_Update() {
  Link_Damage();}
 

 
// Take damage as appropriate.
void Link_Damage() {
  // See if we took any hits, and quit if we didn't.
  int hit = MISC_LINK_HP - Link->HP;
  if (hit <= 0) {
    MISC_LINK_HP = Link->HP;
    return;}
  // Go back up to the hp we had before (so we can subtract the proper
  // amount this time.)
  Link->HP = MISC_LINK_HP;
 // Enemy editor only let's us specify damage in increments of 4,
// so quarter the damage here where we interpret it.
  hit >>= 2;
 // Interpret the hit value.
  int element = hit % 10;
  int damage = (hit * 0.1) << 2;
  // Damage multipliers
  damage *= GetLinkDamageMultiplier(element, Link_Element);
  damage = (damage / Link_Defense) >> 0;
  // Apply damage.
  Link->HP -= damage;
  // Update the 'old' value to the new amount.
  MISC_LINK_HP = Link->HP;
}

item script FireTunic
{
 void run(int TunicDefense)
 {
  Link_Element = ELEMENT_FIRE; 
  Link_Defense = TunicDefense;
  //Insert other tunic functions here
 }
} 

item script ForestTunic
{
 void run(int TunicDefense)
 {
  Link_Element = ELEMENT_FOREST; 
  Link_Defense = TunicDefense;
  //Insert other tunic functions here
 }
} 

item script WaterTunic
{
 void run(int TunicDefense)
 {
  Link_Element = ELEMENT_WATER; 
  Link_Defense = TunicDefense;
  //Insert other tunic functions here
 }
} 

item script WindTunic
{
 void run(int TunicDefense)
 {
  Link_Element = ELEMENT_WIND; 
  Link_Defense = TunicDefense;
  //Insert other tunic functions here
 }
} 

item script IceTunic
{
 void run(int TunicDefense)
 {
  Link_Element = ELEMENT_ICE; 
  Link_Defense = TunicDefense;
  //Insert other tunic functions here
 }
} 

item script EarthTunic
{
 void run(int TunicDefense)
 {
  Link_Element = ELEMENT_EARTH; 
  Link_Defense = TunicDefense;
  //Insert other tunic functions here
 }
} 

item script LightTunic
{
 void run(int TunicDefense)
 {
  Link_Element = ELEMENT_LIGHT; 
  Link_Defense = TunicDefense;
  //Insert other tunic functions here
 }
} 

item script ShadowTunic
{
 void run(int TunicDefense)
 {
  Link_Element = ELEMENT_SHADOW; 
  Link_Defense = TunicDefense;
  //Insert other tunic functions here
 }
} 

item script SpiritTunic
{
 void run(int TunicDefense)
 {
  Link_Element = ELEMENT_SPIRIT; 
  Link_Defense = TunicDefense;
  //Insert other tunic functions here
 }
} 

item script NeutralTunic
{
 void run(int TunicDefense)
 {
  Link_Element = 0; 
  Link_Defense = TunicDefense;
 }
} 

item script ElementTunic
{
 void run(int TunicElement, int TunicDefense)
 {
  Link_Element = TunicElement; 
  Link_Defense = TunicDefense;
  //Insert other tunic functions here
 }
} 