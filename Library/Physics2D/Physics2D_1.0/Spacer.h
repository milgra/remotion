//
//  Spacer.h
//  DescentEditor
//
//  Created by Milan Toth on 11/28/11.
//  Copyright (c) 2011 The MilGra Experience. All rights reserved.
//

#ifndef DescentEditor_Spacer_h
#define DescentEditor_Spacer_h


	#include <stdio.h>
	#include <stdlib.h>
    #include "Mass.h"
    #include "Vector.h"
	

	struct Spacer
	{

        struct Mass*	massA;
        struct Mass*	massB;
        struct Vector*	vector;        
        double			space;
				
	};


    struct Spacer*     SpacerInit ( struct Mass* aMassA , struct Mass* aMassB );
	void			   SpacerDestruct ( struct Spacer* pSpacer );
    void               SpacerRespace ( struct Spacer* aSpacer );


#endif
