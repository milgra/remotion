//
//  Wall.c
//  DescentEditor
//
//  Created by Milan Toth on 11/26/11.
//  Copyright (c) 2011 The MilGra Experience. All rights reserved.
//

#include "Segment.h"


	// construcotr

    struct Segment* SegmentInit ( struct Vector* pCornerA , 
                                  struct Vector* pCornerB )
    {
    
        struct Segment* newWall = malloc( sizeof( struct Segment ) );
        
        newWall->cornerA  = pCornerA;
        newWall->cornerB  = pCornerB;
        newWall->friction = 1;
    
        return newWall;

    }
	
	
	// destructor
	
    void SegmentDestruct ( struct Vector* pSegment )
	{
	
		free( pSegment );
	
	}


	// hittest
    
    int SegmentPointInside ( struct Vector* pVector )
    {
    
        return 0;
    
    }
