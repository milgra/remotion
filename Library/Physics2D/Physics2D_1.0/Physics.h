//
//  World.h
//  DescentEditor
//
//  Created by Milan Toth on 11/13/11.
//  Copyright (c) 2011 The MilGra Experience. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "Mass.h"
#include "Chain.h"
#include "Vector.h"
#include "Spacer.h"
#include "Segment.h"


    @interface Physics : NSObject
    {
    
        struct Chain*   walls;
        struct Chain*   masses;
        struct Chain*   spacers;
        
        struct Vector*  gravity;

    }
    
    
    @property ( atomic ) struct Chain* walls;
    @property ( atomic ) struct Chain* masses;
    
    
    - ( void ) step;
    - ( BOOL ) bounceMass		: ( struct Mass*	) aMass;
    - ( void ) addSpacer		: ( struct Spacer*	) aSpacer;
    - ( void ) addMassPoint		: ( struct Mass*	) aMass;
    - ( void ) addWallSegment	: ( struct Segment* ) aSegment;
    

@end
