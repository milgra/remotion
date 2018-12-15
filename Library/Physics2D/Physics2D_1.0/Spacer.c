//
//  Spacer.c
//  DescentEditor
//
//  Created by Milan Toth on 11/28/11.
//  Copyright (c) 2011 The MilGra Experience. All rights reserved.
//

#include "Spacer.h"


	// constructor

    struct Spacer* SpacerInit ( struct Mass* pMassA , 
                                struct Mass* pMassB )
    {

        struct Spacer* newSpacer = malloc( sizeof( struct Spacer ) );
        
        struct Vector* vector = VectorInit( pMassB->originalPosition->x - pMassA->originalPosition->x , 
                                            pMassB->originalPosition->y - pMassA->originalPosition->y );
        
        newSpacer->vector = vector;
        newSpacer->massA  = pMassA;
        newSpacer->massB  = pMassB;
        newSpacer->space  = 40;
                                                
        return newSpacer;
    
    }


	// destructor

	void SpacerDestruct ( struct Spacer* pSpacer )
	{
	
		free( pSpacer );
	
	}
    
	
	// respace step
    
    void SpacerRespace ( struct Spacer* aSpacer )
    {
    
        VectorSet(  aSpacer->vector , 
                    aSpacer->massB->originalPosition->x + aSpacer->massB->originalForce->x - ( aSpacer->massA->originalPosition->x + aSpacer->massA->originalForce->x ) , 
                    aSpacer->massB->originalPosition->y + aSpacer->massB->originalForce->y - ( aSpacer->massA->originalPosition->y + aSpacer->massA->originalForce->y ) );
                    
//        if ( aSpacer->massA->lastWallA != NULL || aSpacer->massB->lastWallA != NULL )
//        {
//        
//            if ( aSpacer->massA->lastWallA != NULL )
//            {
//            
//                double delta = ( aSpacer->vector->length - aSpacer->space );
//                VectorMultiply( aSpacer->vector , delta / aSpacer->vector->length );
//                VectorAddTo( aSpacer->massB->originalForce , aSpacer->vector );
//            
//            }
//            else
//            if ( aSpacer->massB->lastWallA != NULL )
//            {
//            
//                double delta = ( aSpacer->vector->length - aSpacer->space );
//                VectorMultiply( aSpacer->vector , -delta / aSpacer->vector->length );
//                VectorAddTo( aSpacer->massA->originalForce , aSpacer->vector );
//            
//            }
//        
//        }
//        else
//        {
                        
            double delta = ( aSpacer->vector->length - aSpacer->space ) / 4;
            
            VectorMultiply( aSpacer->vector , delta / aSpacer->vector->length );
            
            VectorAddTo( aSpacer->massA->originalForce , aSpacer->vector );

            VectorSet(  aSpacer->vector , 
                        aSpacer->massB->originalPosition->x - aSpacer->massA->originalPosition->x , 
                        aSpacer->massB->originalPosition->y - aSpacer->massA->originalPosition->y );

            VectorMultiply( aSpacer->vector , -delta / aSpacer->vector->length );

            VectorAddTo( aSpacer->massB->originalForce , aSpacer->vector );
            
//        }
    
    };
    
    