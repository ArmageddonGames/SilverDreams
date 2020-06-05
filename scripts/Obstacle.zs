

ffc script Obstacle
{
    void run (int itemid, int Combo1, int Combo2)
{

if (Link->Item[itemid] == true)
{
  for (int i = 0; i < 176; i++) 
{
    
  if (Screen->ComboD[i] == Combo1) 
  {
        Screen->ComboD[i] = Combo2;
        Game->PlaySound(27);
  }       

}  
}
}
}

ffc script Counter_Obstacle
{
    void run (int counterid, int quantity, int Combo1, int Combo2)
{

if (Game->Counter[counterid] >= quantity)
{
  for (int i = 0; i < 176; i++) 
{
    
  if (Screen->ComboD[i] == Combo1) 
  {
        Screen->ComboD[i] = Combo2;
        Game->PlaySound(27);
        Game->Counter[counterid] -= quantity;
  }       

}  
}
}
}






