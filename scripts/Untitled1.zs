const int LAVA = 102

int comboLoc = ComboAt(Link->X+8, Link->Y + Cond(BIG_LINK==0, 12, 8));
    if(Screen->ComboF[comboLoc] != LAVA)
    {
        Link->Item[I_FLIPPERS] = true;
    }
    else if (Screen->ComboF[comboLoc] == LAVA)
    {
        Link->Item[I_FLIPPERS] = false;
    }
