item script Remove_Drunkeness
{
          void run()
          {
                    Game->Counter[CR_DRUNKENESS]=NULL;
          }
}
 
item script Beer{
    void run (int num_beer){
        Game->Counter[CR_BEER] += num_beer;
        Game->Counter[CR_DRUNKENESS] += DRUNK_TIME * num_beer;
    }
}