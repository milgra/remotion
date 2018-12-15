//
//  Chain.h
//  DescentEditor
//
//  Created by Milan Toth on 11/20/11.
//  Copyright (c) 2011 The MilGra Experience. All rights reserved.
//
//	Chain is a struct chain holding arbitrary data
//	It is created for easy manipulation
//

#ifndef DescentEditor_Chain_h
#define DescentEditor_Chain_h


	#include <stdio.h>
	#include <stdlib.h>

	struct Chain
	{

        void*           value;
        struct Chain*   next;
        
        long            length;
        struct Chain*   end;
				
	};


    struct Chain*   ChainInit       ( void );
    void            ChainDestruct   ( struct Chain* pChain );
    void            ChainAdd        ( struct Chain* pChain , void* pValue );
    void            ChainRemove     ( struct Chain* pChain , void* pValue );
	

#endif
