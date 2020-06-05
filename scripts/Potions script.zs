import "std.zh"

item script Potion2
{
void run(int a,int b, int c)
 {
 if(a==0){Link->HP+=b;}
 if(a==1){Link->MP+=c;}
 if(a==2){Link->HP+=b;Link->MP+=c;}
 }
}

item script Potion3
{
void run(int a,int b, int c)
 {
 if(a==0){Link->HP+=b;}
 if(a==1){Link->MP+=c;}
 if(a==2){Link->HP+=b;Link->MP+=c;}
 }
}