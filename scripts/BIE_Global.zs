global script slot_2
{
    void run()
    {    

        while(true)
        {   
            InGameClock();
            UpdateInGameClock();
            DayNightCycle();
            Ex1Jump();
            SwitchCharacters();
            AdventureParty();
            
            Waitframe();
        }
    }
}

