//Global variables for Link
int MISC_LINK_HP = 1;
int Link_Defense = 1;
int Link_Element = 0;


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
 
 
// Updates this npc.
void Link_Update() {
  Link_Damage();}
 

 
// Take damage as appropriate.
void Link_Damage() {
  // See if we took any hits, and quit if we didn't.
  int hit = MISC_LINK_HP - Link->HP;
  if (hit <= 0) {return;}
  // Go back up to the hp we had before (so we can subtract the proper
  // amount this time.)
  Link->HP = MISC_LINK_HP;
  // Item editor only let's us specify damage in increments of 2,
  // so half the damage here where we interpret it.
  hit >>= 1;
  // Interpret the hit value.
  int element = hit % 10;
  int damage = (hit * 0.2) >> 0;
  // Damage multipliers
  damage *= GetLinkDamageMultiplier(element, Link_Element);
  damage /= Link_Defense;
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