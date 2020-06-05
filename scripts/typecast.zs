import "std.zh"

int ptrs[256];

bool stuff[940];



global script a{
	void run(){
		ffc fff[32];
		ffc ffb[32];
		itemdata id[250];
		npc n[75];
		eweapon ew[50];
		lweapon lw[9];
		item i[99];
		ptrs[0] = fff->GetPointer(fff);
        ptrs[1] = fff->GetPointer(ffb);
		Trace(ptrs[0]); Trace(ptrs[1]);
		Trace( SizeOfArray( Game->GetPointer(stuff) ) );
		Trace( SizeOfArray( fff->GetPointer(fff) ) );
Trace( SizeOfArray( ew->GetPointer(ew) ) );
Trace( SizeOfArray( lw->GetPointer(lw) ) );
Trace( SizeOfArray( n->GetPointer(n) ) );
Trace( SizeOfArray( id->GetPointer(id) ) );
Trace( SizeOfArray( i->GetPointer(i) ) );
	}
}
