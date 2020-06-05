global script slot_2
{
    void run()
    {        
        while(true)
        {
            
            Game->Counter[CR_SECONDS] = InGameClock[CLOCK_SECONDS];
            Game->Counter[CR_MINUTES] = InGameClock[CLOCK_MINUTES];
            Game->Counter[CR_HOURS] = InGameClock[CLOCK_HOURS];
            CURRENTDMAP = Game->GetCurDMap();   
            InGameClock();
            DayNightCycle();
            Ex1Jump();
            SwitchCharacters();
            AdventureParty();  
    }
        Waitframe();

        }
    }
}

