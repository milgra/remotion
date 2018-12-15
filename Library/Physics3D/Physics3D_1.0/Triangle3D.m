//
//  Triangle3D.m
//  Terrain
//
//  Created by Milan Toth on 11/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Triangle3D.h"


@implementation Triangle3D


	@synthesize A;
	@synthesize B;
	@synthesize C;
	@synthesize N;


	- ( Triangle3D* ) 
	A : ( Vector3D* ) pA 
	B : ( Vector3D* ) pB 
	C : ( Vector3D* ) pC
	{

		if ( self = [ super init ] )
		{

			A = pA;
			B = pB;
			C = pC;

			Vector3D* subB = [ Vector3D sub : B  and : A ];
			Vector3D* subC = [ Vector3D sub : C  and : A ];		
			
			N = [ Vector3D cross : subB and : subC ];
			
		}
		
		return self;

	}
	
	
	- ( NSString* ) description
	{

		return [ NSString stringWithFormat: @"Triangle : A : %@ B : %@ C : %@ N : %@" , A , B , C , N ];

	}


@end
