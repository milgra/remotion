//
//  Animator.m
//  DescentEditor
//
//  Created by Milan Toth on 12/12/11.
//  Copyright (c) 2011 The MilGra Experience. All rights reserved.
//

#import "Skeleton.h"

@implementation Skeleton


    // constructor

    - ( id  ) initWithPivot : ( struct Vector* ) pVectorA
    {
    
        self = [ super init ];
        
        if ( self )
        {
        
            pivot           = pVectorA;
            activePoints    = ChainInit( );
            referencePoints = ChainInit( );
        
        }
        
        return self;
    
    }


    // add reference point

    - ( void ) addPoint : ( struct Vector* ) pPoint
    {
        
        ChainAdd( activePoints      , pPoint );
        ChainAdd( referencePoints   , VectorInit( pPoint->x , pPoint->y ) );
        
    }


    // simulation step

    - ( void )  step
    {

        struct Chain* activeLink    = activePoints;
        struct Chain* referenceLink = referencePoints;
        
        // keep active points relative to pivot
        
        while ( activeLink != NULL )
        {
        
            struct Vector* activePoint    = ( struct Vector* ) activeLink->value;
            struct Vector* referencePoint = ( struct Vector* ) referenceLink->value;
            
            activePoint->x = pivot->x - referencePoint->x;
            activePoint->y = pivot->y - referencePoint->y;
        
            activeLink      = activeLink->next;
            referenceLink   = referenceLink->next;
            
        }

    }


@end
