//
//  Wall.h
//  DescentEditor
//
//  Created by Milan Toth on 11/26/11.
//  Copyright (c) 2011 The MilGra Experience. All rights reserved.
//

#ifndef DescentEditor_Wall_h
#define DescentEditor_Wall_h


	#include <stdio.h>
	#include <stdlib.h>
    #include "Vector.h"
	

	struct Segment
	{

        struct Vector*   cornerA;
        struct Vector*   cornerB;
        
        double			 friction;
				
	};


    struct Segment*     SegmentInit        ( struct Vector* pCornerA , struct Vector* pCornerB );
	void				SegmentDestruct	   ( struct Vector* pSegment );
    int                 SegmentPointInside ( struct Vector* pVector );


#endif
