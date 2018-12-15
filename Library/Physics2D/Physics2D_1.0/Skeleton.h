//
//  Animator.h
//  DescentEditor
//
//  Created by Milan Toth on 12/12/11.
//  Copyright (c) 2011 The MilGra Experience. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chain.h"
#import "Vector.h"


    @interface Skeleton : NSObject
    {

        struct Vector* pivot;
        struct Chain*  activePoints;
        struct Chain*  referencePoints;

    }

    - ( id   )  initWithPivot   : ( struct Vector* ) pVectorA;
    - ( void )  step;
    - ( void )  addPoint        : ( struct Vector* ) pPoint;

@end
