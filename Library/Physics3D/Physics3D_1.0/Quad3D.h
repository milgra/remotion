//
//  Quad3D.h
//  Terrain
//
//  Created by Milan Toth on 11/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Triangle3D.h"

    
    @interface Quad3D : NSObject 
    {

        Triangle3D*	A;
        Triangle3D*	B;

    }


    @property ( assign ) Triangle3D* A;
    @property ( assign ) Triangle3D* B;


    - ( Quad3D* )   A : ( Triangle3D* ) pTriangleA 
                    B : ( Triangle3D* ) pTriangleB;
    

@end
