const int WINDOW_SLOT_1 = 0;
const int WINDOW_SLOT_2 = 1;
const int WINDOW_SLOT_3 = 2;
const int WINDOW_SLOT_4 = 3;
const int WINDOW_SLOT_5 = 4;

// There are certainly other ways to handle these...
int menuCommand;
int menuArg;

void SetUpWindow(int slot, int style, int x, int y, int size)
{
    SetStyleSize(style, size);
    Tango_ClearSlot(slot);
    Tango_SetSlotStyle(slot, style);
    Tango_SetSlotPosition(slot, x, y);
}

void ShowString(int string, int slot, int style, int x, int y)
{
    SetUpWindow(slot, style, x, y, SIZE_LARGE);
    Tango_LoadString(slot, string);
    Tango_ActivateSlot(slot);
    while(Tango_SlotIsActive(slot))   
        Waitframe();
}

ffc script UseMagic
{
    void run()
    {
        Link->Action=LA_CASTING;
        Screen->Wavy=menuArg*15;
    }
}

ffc script Menu
{
    void run()
    {
        //int line1[]="@choice(1)Look@tab(56)@choice(2)Skills@tab(56)@choice(3)Search@26";
        //int line2[]="@choice(4)Items@tab(56)@choice(5)Magic@tab(56)@choice(6)Examine@domenu(1)@suspend()";
        
        int line1[]="@choice(4)Spells@tab(56)@choice(13)!Words@26";
        
        int line2[]="@choice(8)Set@tab(56)@choice(7)Equip@26";

        int line3[]="@choice(5)Search@tab(56)@choice(1)Look@26";
        
        int line4[]="@choice(11)Talk@tab(56)@choice(12)Ask?@26";
        
        int line5[]="@choice(2)Skills@tab(56)@choice(3)Items@26";
        
        int line6[]="@choice(15)Read@tab(56)@choice(6)Vista@26";
        
        int line7[]="@choice(9)Stats@tab(56)@choice(16)Maps@26";

        int line8[]="@choice(10)Game@tab(56)@choice(14)Misc@domenu(1)@suspend()";

        
        
        SetUpWindow(WINDOW_SLOT_1, WINDOW_STYLE_1, 16, 16, SIZE_LARGE);
        Tango_LoadString(WINDOW_SLOT_1, line1);
        Tango_AppendString(WINDOW_SLOT_1, line2);
        Tango_AppendString(WINDOW_SLOT_1, line3);
        Tango_AppendString(WINDOW_SLOT_1, line4);
        Tango_AppendString(WINDOW_SLOT_1, line5);
        Tango_AppendString(WINDOW_SLOT_1, line6);
        Tango_AppendString(WINDOW_SLOT_1, line7);
        Tango_AppendString(WINDOW_SLOT_1, line8);
        Tango_ActivateSlot(WINDOW_SLOT_1);
        
        
        while(!Tango_MenuIsActive()){
            
            Waitframe();
        }
        
        // Save the state of the text slot and menu. The bitmap won't change,
        // so it doesn't need saved.
        int slotState[278];
	int menuState[960];
        int cursorPos;
        Tango_SaveSlotState(WINDOW_SLOT_1, slotState);
        Tango_SaveMenuState(menuState);
        
        bool done=false;
        int choice;
        while(true)
        {
        if ( Link->PressEx1 ){
          
            Quit();
        }
        
                //if ( done == false && menuOpen == false ) {
                //    menuOpen = true;
                //}
                //if ( done == true && menuOpen == true ){
                //    menuOpen = false;
                //}
            while(Tango_MenuIsActive())
            {
               
                cursorPos=Tango_GetMenuCursorPosition();
                
                Waitframe();
            }
            
            choice=Tango_GetLastMenuChoice();
            
            if(choice==1) // Look
            {
                int text[]="The Look function is not yet available. Please use your 'L' button for the present.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
            else if(choice==2) // Skills
            {
                int text[]="The Skills function is not yet available.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
            else if(choice==3) // Items
            {
                int text[]="The Items function is not yet available. Use 'R' to pick up, or buy items for the present.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
            else if(choice==4){ // Magic
                DoMagic();
		done=true;
            }
             else if(choice==5) // Search
            {
                int text[]="The Search function is not yet available. Please use your 'L' button for the present.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
             else if(choice==6) // Vista
            {
                int text[]="The Vista function is not yet available.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
            else if(choice==7) // Equip
            {
                int text[]="The Equip function is not yet available.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
             else if(choice==8) // Set
            {
                int text[]="The Set function is not yet available.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
             else if(choice==9) // Stats
            {
                showStats();
		done=true;
            }
             else if(choice==10) // Game
            {
                GameMenu();
		done=true;
            }
            else if(choice==11) // Talk
            {
                int text[]="The Talk function is not yet available. Please use your 'L' button for the present.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
            
            else if(choice==12) // Ask
            {
                int text[]="The Ask function is not yet available.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
            
            else if(choice==13) // !Words
            {
                int text[]="Words of Power are not yet available.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
            
            else if(choice==14) // Misc.
            {
                int text[]="Misc. is not yet available.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
            
            else if(choice==15) // Read
            {
                int text[]="Read is not yet available.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
            
            else if(choice==16) // Maps
            {
                int text[]="Maps are not yet available.";
                ShowString(text, WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32);
                done=true;
            }
                
            else if (Link->PressEx1){
              
                Quit();
            }
            else{
               
                done=true;
            }
            
            // If we need to return to the top-level menu,
            // restore the state and loop again.
            if(done){
                
                break;
            }
            else
            {
                Tango_RestoreSlotState(WINDOW_SLOT_1, slotState);
                Tango_RestoreMenuState(menuState);
                Tango_SetMenuCursorPosition(cursorPos);
            }
        }
        
        Tango_ClearSlot(WINDOW_SLOT_1);
    }
}

bool DoMagic()
{
    //SetUpWindow(WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32, SIZE_LARGE);
    //int spellFormat[]="@choice(%d)Spell %d";
    int lineBreak[]="@26";
    int menuEnd[]="@domenu(1)@suspend()";
    //int spellIce[]="@choice(%d)Water/Ice";
    //int spellFire[]="@choice(%d)Fire/Heat";
    
    //for(int i=1; i<9; i++)
    //{
    //    int buffer[40];
    //    sprintf(buffer, spellFormat, i, i);
    //    Tango_AppendString(WINDOW_SLOT_2, buffer);
    //    if(i<7)
    //        Tango_AppendString(WINDOW_SLOT_2, lineBreak);
    //}
    
    int line1[]="@choice(1)Air/Lit@26";
    int line2[]="@choice(2)Water/Ice@26";
    int line3[]="@choice(3)Light@26";
    int line4[]="@choice(4)Fire/Heat@26";
    int line5[]="@choice(5)Darkness@26";
	int line6[]="@choice(6)Earth/Sonic@26";
	 int line7[]="@choice(7)Utility@26";
    
    //@choice(2)Light@domenu(1)@suspend()
    
    SetUpWindow(WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32, SIZE_LARGE);
        Tango_LoadString(WINDOW_SLOT_2, line1);
        Tango_AppendString(WINDOW_SLOT_2, line2);
        Tango_AppendString(WINDOW_SLOT_2, line3);
        Tango_AppendString(WINDOW_SLOT_2, line4);
	 Tango_AppendString(WINDOW_SLOT_2, line5);
	  Tango_AppendString(WINDOW_SLOT_2, line6);
	   Tango_AppendString(WINDOW_SLOT_2, line7);
        Tango_AppendString(WINDOW_SLOT_2, menuEnd);
        Tango_ActivateSlot(WINDOW_SLOT_2);
    
    
    //Tango_AppendString(WINDOW_SLOT_2, menuEnd);
    //Tango_ActivateSlot(WINDOW_SLOT_2);
    
    while(!Tango_MenuIsActive()){
        
        Waitframe();
    }
    
    // Save the state again...
    int slotState[278];
    int menuState[960];
    int cursorPos;
    Tango_SaveSlotState(WINDOW_SLOT_2, slotState);
    Tango_SaveMenuState(menuState);
    
    bool done = false;
    int choice;
    while(true)
    {
    
        while(Tango_MenuIsActive())
        {
            
            cursorPos=Tango_GetMenuCursorPosition();
          
            Waitframe();
        }
        
        choice=Tango_GetLastMenuChoice();
        if(choice==0) // Canceled
            done=true;
            
        else if(choice == 1) 
        {
            done=true;
            menuCommand=52; //FFC Slot of spell.
            menuArg=choice;
        }
        
        else if(choice == 2) 
        {
            int text[]="Water Magic.";
            ShowString(text, WINDOW_SLOT_3, WINDOW_STYLE_3, 48, 48);
        }
        
        else if(choice == 3) 
        {
            int text[]="Light Magic.";
            ShowString(text, WINDOW_SLOT_3, WINDOW_STYLE_3, 48, 48);
        }
        
        else if(choice == 4){
            fireSpells();
	    done = true;
            }
	    
	else if ( choice == 5 ) {
	 int text[]="Light Magic.";
            ShowString(text, WINDOW_SLOT_3, WINDOW_STYLE_3, 48, 48);
	}
	
	else if ( choice == 6 ) {
	 int text[]="Earth and Sonic Magic.";
            ShowString(text, WINDOW_SLOT_3, WINDOW_STYLE_3, 48, 48);
	}
	
	else if ( choice == 7 ) {
	UtilitySpellsMenu();
	done = true;
	}
            
        else if (Link->PressEx1){
                done = true;
        }
        else
            done=true;

        

        
        if(done){
            
            break;
        }
        else
        {
            Tango_RestoreSlotState(WINDOW_SLOT_2, slotState);
            Tango_RestoreMenuState(menuState);
            Tango_SetMenuCursorPosition(cursorPos);
        }
    }
    
    Tango_ClearSlot(WINDOW_SLOT_2);
    
    if(done)
        return true; // Tell parent menu to close
    else
        return false; // Tell parent not to close
}

int fireArray[8]={1,0,1,0,0,0,0,0};

bool fireSpells()
{
    int line1[]="@choice(1)Blaze@26";
    int line2[]="@choice(2)Infernos@26";
    int line3[]="@choice(3)Fireball@26";
    int line4[]="@choice(4)Burn@26";

    int lineBreak[]="@26";
    int menuEnd[]="@domenu(1)@suspend()";


    
    
    SetUpWindow(WINDOW_SLOT_3, WINDOW_STYLE_2, 32, 32, SIZE_LARGE);
    
        if ( fireArray[0] > 0 ) {
            Tango_LoadString(WINDOW_SLOT_3, line1);
        }
        else if ( fireArray[0] == 0 ) {
            Tango_LoadString(WINDOW_SLOT_3, lineBreak);
        }
        
        
        if ( fireArray[1] > 0 ){
            Tango_AppendString(WINDOW_SLOT_3, line2);
        }
        else if ( fireArray[1] == 0 ) {
            Tango_AppendString(WINDOW_SLOT_3, lineBreak);
        }
        
        if ( fireArray[2] > 0 ){
            Tango_AppendString(WINDOW_SLOT_3, line3);
        }
        else if ( fireArray[2] == 0 ) {
            Tango_AppendString(WINDOW_SLOT_3, lineBreak);
        }
        
        if ( fireArray[3] > 0 ){
            Tango_AppendString(WINDOW_SLOT_3, line4);
        }
        else if ( fireArray[3] == 0 ) {
            Tango_AppendString(WINDOW_SLOT_3, lineBreak);
        }
        
        Tango_AppendString(WINDOW_SLOT_3, menuEnd);
        Tango_ActivateSlot(WINDOW_SLOT_3);
    
    
    while(!Tango_MenuIsActive()){
        
        Waitframe();
    }
    
    // Save the state again...
    int slotState[278];
    int menuState[960];
    int cursorPos;
    Tango_SaveSlotState(WINDOW_SLOT_3, slotState);
    Tango_SaveMenuState(menuState);
    
    int done=0;
    int choice;
    while(true)
    {
        while(Tango_MenuIsActive())
        {
            
            cursorPos=Tango_GetMenuCursorPosition();
                
            Waitframe();
        }
        
        choice=Tango_GetLastMenuChoice();
        if(choice==0) // Canceled
            done=2;
        else if(choice == 1) 
        {
            int text[]="Blaze Magic.";
            Tango_ClearSlot(3);

             
            burnSpellOptions();
        }
        
        else if(choice == 2) 
        {
            int text[]="Infernos Magic.";

             
            ShowString(text, WINDOW_SLOT_4, WINDOW_STYLE_3, 48, 48);
        }
        
        else if(choice == 3) 
        {
            int text[]="Fireball Magic.";

             
            ShowString(text, WINDOW_SLOT_4, WINDOW_STYLE_3, 48, 48);
        }
        
        else if(choice == 4) 
        {
            burnSpellOptions();
        }
        
        else // And odd-numbered spells do
        {
            done=1;
            menuCommand=52; //FFC Slot of spell.
            menuArg=choice;
        }
        
        if(done>0) {
            
            break;
        }
        else
        {
            Tango_RestoreSlotState(WINDOW_SLOT_3, slotState);
            Tango_RestoreMenuState(menuState);
            Tango_SetMenuCursorPosition(cursorPos);
        }
    }
    
    Tango_ClearSlot(WINDOW_SLOT_3);
    
    if(done==1)
        return true; // Tell parent menu to close
    else
        return false; // Tell parent not to close
}

bool burnSpellOptions()
{
    int line1[]="@choice(1)Line@26";
    int line2[]="@choice(2)Area@26";

    int lineBreak[]="@26";
    int menuEnd[]="@domenu(1)@suspend()";


    
    
    SetUpWindow(WINDOW_SLOT_4, WINDOW_STYLE_2, 32, 32, SIZE_LARGE);
    
    Tango_LoadString(WINDOW_SLOT_4, line1);
    Tango_AppendString(WINDOW_SLOT_4, line2);

    Tango_AppendString(WINDOW_SLOT_4, menuEnd);
    Tango_ActivateSlot(WINDOW_SLOT_4);
    
    
    while(!Tango_MenuIsActive()){
        
        Waitframe();
    }
    
    // Save the state again...
    int slotState[278];
    int menuState[960];
    int cursorPos;
    Tango_SaveSlotState(WINDOW_SLOT_4, slotState);
    Tango_SaveMenuState(menuState);
    
    int done=0;
    int choice;
    while(true)
    {
        while(Tango_MenuIsActive())
        {
            

                
            cursorPos=Tango_GetMenuCursorPosition();
            
            Waitframe();
        }
        
        choice=Tango_GetLastMenuChoice();
        if(choice==0) // Canceled
            done=2;
        else if(choice == 1) 
        {
            int text[]="...in a Line.";
            Tango_ClearSlot(3);
            ShowString(text, WINDOW_SLOT_5, WINDOW_STYLE_2, 48, 48);

                
        }
        
        else if(choice == 2) 
        {
            int text[]="...in an area clicked.";
            ShowString(text, WINDOW_SLOT_5, WINDOW_STYLE_2, 48, 48);

              
        }

        
        
        if(done>0){
            
            break;
        }
        else
        {
            Tango_RestoreSlotState(WINDOW_SLOT_4, slotState);
            Tango_RestoreMenuState(menuState);
            Tango_SetMenuCursorPosition(cursorPos);
        }
    }
    
    Tango_ClearSlot(WINDOW_SLOT_4);
    
    if(done==1)
        return true; // Tell parent menu to close
    else
        return false; // Tell parent not to close
}




bool showStats()
{

    
    Tango_D[0] = getMuscStat();
    Tango_D[1] = getBodyStat();
    Tango_D[2] = getMindStat();
    Tango_D[3] = getMystStat();
    Tango_D[4] = getLuckStat();
    Tango_D[5] = getInflStat();
    Tango_D[6] = Game->Counter[CR_LEVEL];
    
    int line0[]="@choice(1)Done@26@26";
    int line1[]="MUSCLE@tab(56)@number(@d0)@26";
    int line2[]="BODY@tab(56)@number(@d1)@26";
    int line3[]="MIND@tab(56)@number(@d2)@26";
    int line4[]="MYSTIC@tab(56)@number(@d3)@26";
    int line5[]="LUCK@tab(56)@number(@d4)@26";
    int line6[]="INFL@tab(56)@number(@d5)@domenu(1)@suspend()";
 

    int lineBreak[]="@26";
    int menuEnd[]="@domenu(1)@suspend()";


    
     SetUpWindow(WINDOW_SLOT_2, WINDOW_STYLE_2, 32, 32, SIZE_LARGE);
     Trace(__Tango_Data[__TDIDX_SCREEN_FREEZE]);
               
        Tango_LoadString(WINDOW_SLOT_2, line0);
        Tango_AppendString(WINDOW_SLOT_2, line1);
        Tango_AppendString(WINDOW_SLOT_2, line2);
        Tango_AppendString(WINDOW_SLOT_2, line3);
        Tango_AppendString(WINDOW_SLOT_2, line4);
        Tango_AppendString(WINDOW_SLOT_2, line5);
        Tango_AppendString(WINDOW_SLOT_2, line6);
        Tango_AppendString(WINDOW_SLOT_2, menuEnd);
        Tango_ActivateSlot(WINDOW_SLOT_2);
    
    
    
    
    while(!Tango_MenuIsActive()){
        
        Waitframe();
    }
    
    // Save the state again...
    int slotState[278];
    int menuState[960];
    int cursorPos;
    Tango_SaveSlotState(WINDOW_SLOT_2, slotState);
    Tango_SaveMenuState(menuState);
    
    int done=0;
    int choice;
    while(true)
    {
    
        while(Tango_MenuIsActive())
        {
            

                
            cursorPos=Tango_GetMenuCursorPosition();
            
            Waitframe();
        }
        
        choice=Tango_GetLastMenuChoice();
        if(choice==0) // Canceled
            done=2;
         else if(choice == 1) 
        {
            done=2;

        }

        
        
        if(done>0){
            
            break;
        }
        else
        {
            Tango_RestoreSlotState(WINDOW_SLOT_2, slotState);
            Tango_RestoreMenuState(menuState);
            Tango_SetMenuCursorPosition(cursorPos);
        }
    }
    
    Tango_ClearSlot(WINDOW_SLOT_2);
    
    if(done==1)
        return true; // Tell parent menu to close
    else
        return false; // Tell parent not to close
}

bool UtilitySpellsMenu(){

    int lineBreak[]="@26";
    int menuEnd[]="@domenu(1)@suspend()";

    
    int line2[]="@choice(2)Done@26";
    int line1[]="@choice(1)!Escape@26";
 


    
    SetUpWindow(WINDOW_SLOT_3, WINDOW_STYLE_3, 32, 32, SIZE_LARGE);
        Tango_LoadString(WINDOW_SLOT_3, line1);
        Tango_AppendString(WINDOW_SLOT_3, line2);
        Tango_AppendString(WINDOW_SLOT_3, menuEnd);
        Tango_ActivateSlot(WINDOW_SLOT_3);
    
    
    while(!Tango_MenuIsActive()){
        
        Waitframe();
    }
    
    // Save the state again...
    int slotState[278];
    int menuState[960];
    int cursorPos;
    Tango_SaveSlotState(WINDOW_SLOT_3, slotState);
    Tango_SaveMenuState(menuState);
    
    bool done = false;
    int choice;
    while(true)
    {
    
        while(Tango_MenuIsActive())
        {
            
            cursorPos=Tango_GetMenuCursorPosition();
          
            Waitframe();
        }
        
        choice=Tango_GetLastMenuChoice();
        if(choice==0) // Canceled
            done=true;
            
        else if(choice == 1) 
        {
		done = true;
           EscapeMenu();
        }
	
	else if(choice == 2) 
        {
            done = true;
        }
         
        else if (Link->PressEx1){
                done = true;
        }
        else
            done=true;

        

        
        if(done){
            
            break;
        }
        else
        {
            Tango_RestoreSlotState(WINDOW_SLOT_3, slotState);
            Tango_RestoreMenuState(menuState);
            Tango_SetMenuCursorPosition(cursorPos);
        }
    }
    
    Tango_ClearSlot(WINDOW_SLOT_3);
    
    if(done)
        return true; // Tell parent menu to close
    else
        return false; // Tell parent not to close
}

bool EscapeMenu(){

    int lineBreak[]="@26";
    int menuEnd[]="@domenu(1)@suspend()";

    
    int line2[]="@26";
    int line1[]="@choice(1)Start@tab(56)@choice(2)Home@26";


    
    SetUpWindow(WINDOW_SLOT_4, WINDOW_STYLE_3, 32, 32, SIZE_LARGE);
        Tango_LoadString(WINDOW_SLOT_4, line1);
        Tango_AppendString(WINDOW_SLOT_4, line2);
        Tango_AppendString(WINDOW_SLOT_4, menuEnd);
        Tango_ActivateSlot(WINDOW_SLOT_4);
    
    
    while(!Tango_MenuIsActive()){
        
        Waitframe();
    }
    
    // Save the state again...
    int slotState[278];
    int menuState[960];
    int cursorPos;
    Tango_SaveSlotState(WINDOW_SLOT_4, slotState);
    Tango_SaveMenuState(menuState);
    
    bool done = false;
    int choice;
    while(true)
    {
    
        while(Tango_MenuIsActive())
        {
            
            cursorPos=Tango_GetMenuCursorPosition();
          
            Waitframe();
        }
        
        choice=Tango_GetLastMenuChoice();
        if(choice==0) // Canceled
            done=true;
            
        else if(choice == 1) 
        {
		done = true;
		escapeSpell(ESCAPE_START,TELEPORT_WAVE);
            
        }
	
	else if(choice == 2) 
        {
		done = true;
            escapeSpell(ESCAPE_HOME,TELEPORT_WAVE);
	    
        }
         
        else if (Link->PressEx1){
                done = true;
        }
        else
            done=true;

        

        
        if(done){
            
            break;
        }
        else
        {
            Tango_RestoreSlotState(WINDOW_SLOT_4, slotState);
            Tango_RestoreMenuState(menuState);
            Tango_SetMenuCursorPosition(cursorPos);
        }
    }
    Tango_ClearSlot(WINDOW_SLOT_4);
    Tango_ClearSlot(WINDOW_SLOT_4);
    Tango_ClearSlot(WINDOW_SLOT_4);
    Tango_ClearSlot(WINDOW_SLOT_4);
    
    if(done)
        return true; // Tell parent menu to close
    else
        return false; // Tell parent not to close
}

////Move this to user-defined Tango functions:

int ShowMessage(int msg, int style, int x, int y)
{
    int slot=Tango_GetFreeSlot(TANGO_SLOT_ANY);
    if(slot==TANGO_INVALID)
        return TANGO_INVALID;
    
    Tango_ClearSlot(slot);
    Tango_LoadMessage(slot, msg);
    Tango_SetSlotStyle(slot, style);
    Tango_SetSlotPosition(slot, x, y);
    Tango_ActivateSlot(slot);
    
    return slot;
}

int ShowMessage(int msg, int slot, int style, int x, int y)
{
    if(slot==TANGO_INVALID)
        return TANGO_INVALID;
    
    Tango_ClearSlot(slot);
    Tango_LoadMessage(slot, msg);
    Tango_SetSlotStyle(slot, style);
    Tango_SetSlotPosition(slot, x, y);
    Tango_ActivateSlot(slot);
    
    return slot;
}