//
//  Quad3D.m
//  Terrain
//
//  Created by Milan Toth on 11/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Quad3D.h"


@implementation Quad3D
	
    
	@synthesize A;
	@synthesize B;


	- ( Quad3D* ) 
	A : ( Triangle3D* ) triangleAX 
	B : ( Triangle3D* ) triangleBX
	{

		if ( self = [ super init ] )
		{

			A = triangleAX;
			B = triangleBX;	
		
		}
		
		return self;

	}
	

@end
