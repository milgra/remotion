//
//  Vector3D.m
//  Terrain
//
//  Created by Milan Toth on 11/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Vector3D.h"


@implementation Vector3D


	@synthesize x;
	@synthesize y;
	@synthesize z;


	- ( Vector3D* ) 
	x : ( GLfloat ) pX 
	y : ( GLfloat ) pY 
	z : ( GLfloat ) pZ
	{

		if ( self = [ super init ] )
		{	

			x = ( GLfloat ) pX;
			y = ( GLfloat ) pY;
			z = ( GLfloat ) pZ;
		
		}
		
		return self;

	}
	
	
	- ( NSString* )
	description
	{
	
		return [ NSString stringWithFormat: @"x : %f y : %f z : %f" , x , y , z ];
	
	}

	
	+ ( Vector3D* ) add : ( Vector3D* ) first
                    and : ( Vector3D* ) second
	{
	
		return [ [ Vector3D alloc ]
			x : first.x + second.x   
			y : first.y + second.y
			z : first.z + second.z ];

	}


	+ ( Vector3D* ) sub : ( Vector3D* ) first
                    and : ( Vector3D* ) second
	{
	
		return [ [ Vector3D alloc ]
			x : first.x - second.x   
			y : first.y - second.y
			z : first.z - second.z ];

	}


	+ ( Vector3D* ) cross : ( Vector3D* ) first 
                    and   : ( Vector3D* ) second
	{

		return [ [ Vector3D alloc ]
			x : first.y * second.z - first.z * second.y
			y : first.z * second.x - first.x * second.z
			z : first.x * second.y - first.y * second.x	];
			
	}
	
	
	+ ( Vector3D* ) multiply : ( Vector3D* ) vector
                    with : ( float ) number
	{
	
		return [ [ Vector3D alloc ]
			x : vector.x * number
			y : vector.y * number
			z : vector.z * number ];
	
	}

	
	+ ( Vector3D* ) rotateY : ( Vector3D* ) vector
                    angle	: ( float	  ) angle
	{
	
		float yAngle = atan2( vector.z , vector.x );
		float length = sqrt( vector.z * vector.z + vector.x * vector.x );
		
		float newZ = sin( yAngle + angle ) * length;
		float newX = cos( yAngle + angle ) * length;
		
		return [ [ Vector3D alloc ] x : newX y : vector.y z : newZ ];
	
	}
	

	+ ( Vector3D* ) rotateZ : ( Vector3D* ) vector
                    angle	: ( float	  ) angle
	{
	
		float zAngle = atan2( vector.y , vector.x );
		float length = sqrt( vector.y * vector.y + vector.x * vector.x );
		
		float newY = sin( zAngle - angle ) * length;
		float newX = cos( zAngle - angle ) * length;
		
		return [ [ Vector3D alloc ] x : newX y : newY z : vector.z ];
	
	}
	
	
	+ ( Vector3D* )	rotate : ( Vector3D* ) vector
                    around : ( Vector3D* ) axis
                    angle  : ( float	 ) angle
	{
	
		NSLog( @"rotate angle : %f" , angle * 180 / M_PI );
	
		float yAxisAngle = atan2( axis.z , axis.x );
		float zAxisAngle = asin( axis.x / [ Vector3D length : axis ] );
		
		NSLog( @"r0: %@" , vector );		
		Vector3D* r1 = [ self rotateY : vector	angle : yAxisAngle  ];
		NSLog( @"rotated with %f on Y: %@" , yAxisAngle * 180 / M_PI , r1 );
		Vector3D* r2 = [ self rotateZ : r1		angle : zAxisAngle  ];
		NSLog( @"rotated with %f on Z: %@" , zAxisAngle * 180 / M_PI , r2 );
		Vector3D* r3 = [ self rotateY : r2		angle : angle	    ];
		NSLog( @"rotated with %f on Y: %@" , angle * 180 / M_PI , r3 );
		Vector3D* r4 = [ self rotateZ : r3		angle : -zAxisAngle ];
		NSLog( @"rotated back with %f on Z: %@" , zAxisAngle * 180 / M_PI , r4 );
		Vector3D* r5 = [ self rotateY : r4		angle : -yAxisAngle ];
		NSLog( @"rotated back with %f on Y: %@" , yAxisAngle * 180 / M_PI , r5 );
		
		return r5;
	
	}


	+ ( float ) dot : ( Vector3D* ) first 
                and : ( Vector3D* ) second
	{

		return ( first.x * second.x + first.y * second.y + first.z * second.z );

	}	

	
	+ ( float )	angle : ( Vector3D* ) first
                and	  : ( Vector3D* ) second
	{

        // getting the cosine by dividing the dot product by the lengths of the vectors:
			
		float ratio = [ Vector3D dot : first and : second ] / ( [ Vector3D length : first ] * [ Vector3D length : second ] );
		
		return acos( ratio );
	
	}
	
	
	+ ( float ) length : ( Vector3D* ) vector
	{
	
		return sqrt( vector.x * vector.x + vector.y * vector.y + vector.z * vector.z );
	
	}
	

@end
