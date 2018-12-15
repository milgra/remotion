//
//  Vector3D.h
//  Terrain
//
//  Created by Milan Toth on 11/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
//  the class describes a direction vector from the origo of the coordinate system
//  contains all possible vector operations
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>


	@interface Vector3D : NSObject 
	{

		GLfloat x;  // x axis component
		GLfloat y;  // y axis component
		GLfloat z;  // z axis component

	}
    

	@property ( assign ) GLfloat x;
	@property ( assign ) GLfloat y;
	@property ( assign ) GLfloat z;
    
    
    // constructor, returns a vector

	- ( Vector3D* ) x		: ( GLfloat   ) pX 
					y		: ( GLfloat   ) pY 
					z		: ( GLfloat   ) pZ;
                    
    // adds second vector to the first vector, returns new vector
                    
	+ ( Vector3D* ) add		: ( Vector3D* ) pFirst
					and		: ( Vector3D* ) pSecond;
                    
    // substracts the second vector from the first vector, returns new vector
                    
	+ ( Vector3D* ) sub		: ( Vector3D* ) pFirst
					and		: ( Vector3D* ) pSecond;
                    
    // calculates the cross product of ( normal vector to ) the first and second vector, returns new vector

	+ ( Vector3D* ) cross	: ( Vector3D* ) pFirst 
					and		: ( Vector3D* ) pSecond;
                    
    // multiplies the vector with the number, returns new vector
                    
	+ ( Vector3D* ) multiply: ( Vector3D* ) pVector
					with	: ( float	  ) pNumber;
                    
    // rotates vector around axis with angle, returns new vector
                    
	+ ( Vector3D* ) rotate  : ( Vector3D* ) pVector
					around  : ( Vector3D* ) pAxis
					angle   : ( float	  ) pAngle;
                    
    // calculates dot product of first and second vector
                    
	+ ( float	  ) dot		: ( Vector3D* ) pFirst 
					and		: ( Vector3D* ) pSecond;
                    
    // calculates the angle between the first and second vector
    
	+ ( float     ) angle	: ( Vector3D* ) pFirst
					and		: ( Vector3D* ) pSecond;
                    
    // calculates length of vector
                    
	+ ( float     ) length	: ( Vector3D* ) pVector;
    

@end
