//Dug this out of my old files. The enemy element table works, fine, but the Armors were never made functional, due to problems with the GetPlayerDamageMultiplier function.


// The fake amount of hp.
 
const int ELEMENT_FIRE = 1;
const int ELEMENT_WATER = 2;
const int ELEMENT_WOOD = 3;
const int ELEMENT_LIGHTNING = 4;
const int ELEMENT_EARTH = 5;
const int ELEMENT_WIND = 6;
const int ELEMENT_LIGHT=7;
const int ELEMENT_DARKNESS = 8;
const int ELEMENT_CELESTIAL = 9;
 
// Misc slot for enemy initialization state.
const int MISC_NPC_INIT = 0;
// Misc slot for npc's hp last frame..
const int MISC_NPC_OLD_HP = 1;
// Misc slot for npc's element.
const int MISC_NPC_ELEMENT = 2;

//Global variables for Link
int MISC_PLAYER_HP = 0;
int PlayerDefense = 1;
int PlayerElement = 0;

int GetDamageMultiplier(int attackElement, int targetElement) 
{
  if (attackElement == 0 && targetElement == 0) 
  {
      return 1;
  }
  else if (attackElement == targetElement)
  {
      return 0;
  }
  else if (attackElement == ELEMENT_FIRE && targetElement == ELEMENT_WATER)
  {
      return 0.5;
  }
  else if (attackElement == ELEMENT_FIRE && targetElement == ELEMENT_WOOD)
  {
      return 2;
  }
  else if (attackElement == ELEMENT_FIRE && targetElement == ELEMENT_LIGHTNING)
  {
      return 0.5;
  }
  else if (attackElement == ELEMENT_WATER && targetElement == ELEMENT_LIGHTNING)
  {
      return 0.5;
  }
  else if (attackElement == ELEMENT_WATER && targetElement == ELEMENT_FIRE)
  {
      return 2;
  }
  else if (attackElement == ELEMENT_WATER && targetElement == ELEMENT_WOOD)
  {
      return 0.5;
  }
  else if (attackElement == ELEMENT_WOOD && targetElement == ELEMENT_FIRE)
  {
      return 0.5;
  }
  else if (attackElement == ELEMENT_WOOD && targetElement == ELEMENT_LIGHTNING)
  {
      return 2;
  }
  else if (attackElement == ELEMENT_WOOD && targetElement == ELEMENT_WATER)
  {
      return 0.5;
  }
  else if (attackElement == ELEMENT_LIGHTNING && targetElement == ELEMENT_WOOD)
  {
      return 0.5;
  }
  else if (attackElement == ELEMENT_LIGHTNING && targetElement == ELEMENT_WATER)
  {
      return 2;
  }
  else if (attackElement == ELEMENT_LIGHTNING && targetElement == ELEMENT_FIRE)
  {
      return 0.5;
  }
  else if (attackElement == ELEMENT_EARTH && targetElement == ELEMENT_WIND)
  {
      return 2;
  }
  else if (attackElement == ELEMENT_WIND && targetElement == ELEMENT_EARTH)
  {
      return 2;
  }
  else if (attackElement == ELEMENT_DARKNESS && targetElement == ELEMENT_LIGHT)
  {
      return 2;
  }
  else if (attackElement == ELEMENT_LIGHT && targetElement == ELEMENT_DARKNESS)
  {
      return 2;
  }
  else if (attackElement == ELEMENT_CELESTIAL)
  {
      return 4;
  }
  // Finally, return 1 if we haven't found a multiplier yet.
  return 1;
}
 
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
  // so half the damage here where we interpret it by uncommenting. (giving all enemies 1/2 damage minimum defense, so do not need this)
  //hit >>= 1;
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


int GetPlayerDamageMultiplier(int EnemyElement, int PlayerElement) 
 {
  if (EnemyElement == 0 && PlayerElement == 0) 
  {
      return 1;
  }
  else if (EnemyElement == PlayerElement)
  {
      return 0.5;
  }
  else if (EnemyElement == ELEMENT_FIRE && PlayerElement == ELEMENT_WATER)
  {
      return 0.75;
  }
  else if (EnemyElement == ELEMENT_FIRE && PlayerElement == ELEMENT_WOOD)
  {
      return 1.5;
  }
  else if (EnemyElement == ELEMENT_FIRE && PlayerElement == ELEMENT_LIGHTNING)
  {
      return 0.75;
  }
  else if (EnemyElement == ELEMENT_WATER && PlayerElement == ELEMENT_LIGHTNING)
  {
      return 0.75;
  }
  else if (EnemyElement == ELEMENT_WATER && PlayerElement == ELEMENT_FIRE)
  {
      return 1.5;
  }
  else if (EnemyElement == ELEMENT_WATER && PlayerElement == ELEMENT_WOOD)
  {
      return 0.75;
  }
  else if (EnemyElement == ELEMENT_WOOD && PlayerElement == ELEMENT_FIRE)
  {
      return 0.75;
  }
  else if (EnemyElement == ELEMENT_WOOD && PlayerElement == ELEMENT_LIGHTNING)
  {
      return 1.5;
  }
  else if (EnemyElement == ELEMENT_WOOD && PlayerElement == ELEMENT_WATER)
  {
      return 0.75;
  }
  else if (EnemyElement == ELEMENT_LIGHTNING && PlayerElement == ELEMENT_WOOD)
  {
      return 0.75;
  }
  else if (EnemyElement == ELEMENT_LIGHTNING && PlayerElement == ELEMENT_WATER)
  {
      return 1.5;
  }
  else if (EnemyElement == ELEMENT_LIGHTNING && PlayerElement == ELEMENT_FIRE)
  {
      return 0.75;
  }
  else if (EnemyElement == ELEMENT_EARTH && PlayerElement == ELEMENT_WIND)
  {
      return 1.5;
  }
  else if (EnemyElement == ELEMENT_WIND && PlayerElement == ELEMENT_EARTH)
  {
      return 1.5;
  }
  else if (EnemyElement == ELEMENT_DARKNESS && PlayerElement == ELEMENT_LIGHT)
  {
      return 1.5;
  }
  else if (EnemyElement == ELEMENT_LIGHT && PlayerElement == ELEMENT_DARKNESS)
  {
      return 1.5;
  }
  else if (EnemyElement == ELEMENT_CELESTIAL)
  {
      return 2.5;
  }
  // Finally, return 1 if we haven't found a multiplier yet.
  return 1;
}

 
 
// Updates Link.
void Player_Update() {
  Player_Damage();}
 

 
// Take damage as appropriate.
void Player_Damage() {
  // See if we took any hits, and quit if we didn't.
  int hit = MISC_PLAYER_HP - Link->HP;
  if (hit <= 0) {
    MISC_PLAYER_HP = Link->HP;
    return;}
  // Go back up to the hp we had before (so we can subtract the proper
  // amount this time.)
  Link->HP = MISC_PLAYER_HP;
 // Enemy editor only let's us specify damage in increments of 4,
// so quarter the damage here where we interpret it, by uncommenting (I'm using red ring for base defense, so this part is unneeded) 
// hit >>= 2;
 // Interpret the hit value.
  int element = hit % 10;
  int damage = (hit * 0.1) << 2;
  // Damage multipliers
  damage *= GetPlayerDamageMultiplier(element, PlayerElement);
  damage = (damage / PlayerDefense) >> 0;
  // Apply damage.
  Link->HP -= damage;
  // Update the 'old' value to the new amount.
  MISC_PLAYER_HP = Link->HP;
}


item script ElementalArmor
{
 void run(int ArmorElement, int ArmorDefense)
 {
  PlayerElement = ArmorElement; 
  PlayerDefense = ArmorDefense;
  //Insert other Armor functions here
 }
} 