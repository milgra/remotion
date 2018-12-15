//
//  Triangle3D.h
//  Terrain
//
//  Created by Milan Toth on 11/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector3D.h"


    @interface Triangle3D : NSObject 
    {

        Vector3D*	A;      // side A vector
        Vector3D*	B;      // side B vector
        Vector3D*	C;      // side C vector
        Vector3D*	N;      // normal vector

    }


    @property ( assign ) Vector3D* A;
    @property ( assign ) Vector3D* B;
    @property ( assign ) Vector3D* C;
    @property ( assign ) Vector3D* N;


    - ( Triangle3D* )   A : ( Vector3D* ) pA
                        B : ( Vector3D* ) pB 
                        C : ( Vector3D* ) pC;


@end
