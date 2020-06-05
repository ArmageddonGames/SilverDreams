import "std.zh"
import "ffcscript.zh"
import "string.zh"


const int I_ATTACKRING = 200; //Attack ring item number
const float ATTACKRING_POWER = 2; //How much to multiply damage by (allows decimals)

const int MISC_WEAP_BOOSTED = 5; //Weapon->Misc[] slot for boosted weapons

global script active{
    void run(){
        while(true){
            if(Link->Item[I_ATTACKRING]){
                for(int i = 1; i <= Screen->NumLWeapons(); i++){
                    lweapon weap = Screen->LoadLWeapon(i);
                    if(weap->Misc[MISC_WEAP_BOOSTED] == 0){
                        weap->Damage *= ATTACKRING_POWER;
                        weap->Misc[MISC_WEAP_BOOSTED] == 1;
                    }
                }
            }
            Waitframe();
        }
    }
}