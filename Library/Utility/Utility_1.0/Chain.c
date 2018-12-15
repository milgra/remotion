//
//  Chain.c
//  DescentEditor
//
//  Created by Milan Toth on 11/20/11.
//  Copyright (c) 2011 The MilGra Experience. All rights reserved.
//

#include "Chain.h"


	// constructor

    struct Chain* ChainInit ( void )
    {
    
        struct Chain* newChain = malloc( sizeof( struct Chain ) );
        
        newChain->value  = NULL;
        newChain->next   = NULL;

        newChain->end    = newChain;
        newChain->length = 0;
    
        return newChain;
    
    }
    
	
	// destructor, frees chain elements linearly
    
    void ChainDestruct ( struct Chain* pChain )
    {
    
		// loop trough all links, free them
		
		struct Chain* next   = pChain;
		struct Chain* actual = pChain;
		
		while ( actual != NULL ) 
		{
		
			next = actual->next;
			
			free( actual );
			
			actual = next;
  
		}
    
    }
    
	
	// adds value in a new link to the chain
	// should use a separate struct for first element
    
    void ChainAdd ( struct Chain*   pChain , 
                    void*           pValue )
    {
            
        if ( pChain->value )    // not empty chain
        {

            struct Chain* newChain = malloc( sizeof( struct Chain ) );
            
            newChain->value = pValue;
            newChain->next  = NULL;
        
            pChain->end->next = newChain;
            pChain->end       = newChain;
            pChain->length    += 1;
        
        }
        else                    // empty chain
        {
        
            pChain->value = pValue;
            pChain->length = 1;
        
        }
    
    }
	
	
	// removes value and link from the chain
    
    void ChainRemove ( struct Chain* pChain , void* pValue )
    {
    
        struct Chain* actual = pChain;
        // struct Chain* before = NULL;
    
        while ( actual != NULL )
        {
        
            actual = actual->next;
  
        }
    
    }