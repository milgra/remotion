//
//  MassPoint.m
//  DescentEditor
//
//  Created by Milan Toth on 11/12/11.
//  Copyright (c) 2011 The MilGra Experience. All rights reserved.
//

#include "Mass.h"


	// constructor

    struct Mass* MassInit(  double           pWeight   , 
                            double           pFriction , 
                            double           pBuoyancy )
    {

		struct Mass* newMass = malloc( sizeof( struct Mass ) );
		
		newMass->weight				= pWeight;
		newMass->friction			= pFriction;
		newMass->buoyancy			= pBuoyancy;
		newMass->hadCollosion		= 0;

        newMass->originalPosition	= VectorInit( 0 , 0 );
        newMass->originalForce		= VectorInit( 0 , 0 );

        newMass->partialPosition	= VectorInit( 0 , 0 );
        newMass->partialForce		= VectorInit( 0 , 0 );
        
        newMass->lastTouchedWallA	= NULL;
        newMass->lastTouchedWallB	= NULL;
        
        newMass->baseWallA			= NULL;
        newMass->baseWallB			= NULL;
		
		return newMass;    
    
    }
	
	
	// destructor
	
	void MassDestruct( struct Mass* pMass )
	{
	
		free( pMass );
	
	}

