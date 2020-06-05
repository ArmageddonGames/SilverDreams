ffc script f
{
	void run()
	{
		int vars[10];
		lweapon l = Screen->LoadLWeapon(1);

		if(vars[3](l->X, l->Y, 
		VectorX(vars[3], -90),
		VectorY(vars[3], -90)) <= 8)
		{ 
			Quit();
		}
	}
}