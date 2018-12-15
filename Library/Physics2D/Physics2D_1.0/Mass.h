//
//  MassPoint.h
//  DescentEditor
//
//  Created by Milan Toth on 11/12/11.
//  Copyright (c) 2011 The MilGra Experience. All rights reserved.
//

	#ifndef FILE_MASSPOINT
	#define FILE_MASSPOINT
	
    #include <math.h>
	#include <stdio.h>
	#include <stdlib.h>
    #include "Vector.h"
    #include "Segment.h"


	struct Mass
	{
    
        int					hadCollosion;		// collosion flag

		double				weight;
		double				friction;
		double				buoyancy;
        
        struct Vector*		originalForce;		// original force of particle
        struct Vector*		originalPosition;	
        
        struct Vector*		partialForce;		// partial force of particle for collosion iterations
        struct Vector*		partialPosition;
        
        struct Segment*		lastTouchedWallA;
        struct Segment*		lastTouchedWallB;
        
        struct Segment*		lastWallA;
        struct Segment*		lastWallB;
        
        struct Segment*		baseWallA;			// touching wall a
        struct Segment*		baseWallB;			// touching wall b
				
	};


    struct Mass*	MassInit( double pWeight , double pFriction , double pBuoyancy );
	void			MassDestruct( struct Mass* pMass );
	

    #endif