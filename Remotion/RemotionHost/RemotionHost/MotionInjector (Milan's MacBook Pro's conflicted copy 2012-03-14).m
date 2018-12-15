//
//  MotionInjector.m
//  GameControlOSX
//
//  Created by Milan Toth on 3/1/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//

#import "MotionInjector.h"

@implementation MotionInjector


	// constructor

	- ( id ) init
	{
	
		NSLog( @"MotionInjector init" );
	
		self = [ super init ];
		
		if ( self )
		{
		
			// init
			
			didReset	= YES;
		
			bounds		= [ [ NSScreen mainScreen ] frame ];

			center		= CGPointMake( bounds.origin.x + bounds.size.width  / 2 , 
									   bounds.origin.y + bounds.size.height / 2 );			
									   
			actual		= CGPointMake( center.x , center.y );
			previous	= CGPointMake( center.x , center.y );
			remaining	= CGPointMake( 0 , 0 );
		
		}
	
		return self;
	
	}
	
	
	// destructor
	
	- ( void ) dealloc
	{

		NSLog( @"MotionInjector dealloc" );

		[ super dealloc ];
	
	}
	
	
	// reset injection
	
	- ( void ) reset
	{
	
		NSLog( @"MotionInjector reset" );

		didReset  = YES;
	
		actual	  = center;
		previous  = center;
		remaining = CGPointMake( 0 , 0 );
	
	}

	// updates rotation data

	- ( void ) updateRotation : ( void* ) pData
	{

		// NSLog( @"MotionInjector updateRotation" );
	
		// get rotation struct from char array
	
		Rotation rotation;
		
		memcpy( &rotation ,
				pData ,
				sizeof( Rotation ) );
				
		if ( didReset )
		{
		
			// store attitude if reset happened
		
			didReset = NO;
			starting = rotation;
		
		}
		
		// calculate x position
				
		actual.x = center.x + ( starting.x - rotation.z ) * 1000;
		actual.y = center.y - rotation.y * 1000;
		
		// calculate deltas

		double deltaX = actual.x - previous.x - remaining.x;
		double deltaY = actual.y - previous.y - remaining.y;

		// store actual as previous
	
		previous = actual;
		
		// remaining is needed for proper delta calculation
		
		remaining.x = deltaX - round( deltaX );
		remaining.y = deltaY - round( deltaY );
		
		// check turn treshold
		
		double addition = 0;
//		
//		if ( actual.x < center.x - 20 ) addition = ( actual.x - center.x - 20 ) / 20; else
//		if ( actual.x > center.x + 20 ) addition = ( actual.x - center.x + 20 ) / 20;
		
		// create and inject event
		
		CGEventRef mouseEvent = CGEventCreateMouseEvent( NULL				, 
														 kCGEventMouseMoved , 
														 actual				,
														 0					);

		CGEventSetIntegerValueField( mouseEvent , 
									 kCGMouseEventDeltaX , 
									 ( int64_t ) ( round( deltaX + addition ) ) );
									 
		CGEventSetIntegerValueField( mouseEvent , 
									 kCGMouseEventDeltaY , 
									 ( int64_t ) ( round( deltaY + addition ) ) );
									 
//		CGEventSetFlags			   ( mouseEvent , 256 );
		CGEventPost				   ( kCGHIDEventTap , mouseEvent );
		CFRelease				   ( mouseEvent	);
		
	}

	
@end
