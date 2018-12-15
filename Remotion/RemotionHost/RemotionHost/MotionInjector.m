//  MotionInjector.m
//  Remotion
//
//  Created by Milan Toth on 3/1/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "MotionInjector.h"


	@implementation MotionInjector


	#define kMotionInjectorBase		500
	#define kMotionInjectorLook		3000
	#define kMotionInjectorTurn		200
	#define kMotionInjectorRatio	.5


	// constructor

	- ( id ) init
	{
	
		// NSLog( @"MotionInjector init" );
	
		self = [ super init ];
		
		if ( self )
		{
		
			// init
						
			NSRect boundsRect	= [ [ NSScreen mainScreen ] frame ];
			
			xBorders			= CGPointMake( boundsRect.origin.x , 
											   boundsRect.origin.x + boundsRect.size.width );
			yBorders			= CGPointMake( boundsRect.origin.y , 
											   boundsRect.origin.y + boundsRect.size.height );
			deltaPoint			= CGPointMake( 0 , 
											   0 );
			centerPoint			= CGPointMake( boundsRect.origin.x + boundsRect.size.width  / 2 , 
											   boundsRect.origin.y + boundsRect.size.height / 2 );
			actualPoint			= CGPointMake( centerPoint.x , 
											   centerPoint.y );
			screenPoint			= CGPointMake( centerPoint.x , 
											   centerPoint.y );
			previousPoint		= CGPointMake( centerPoint.x , 
											   centerPoint.y );
			
			deltaAngle			= 0;
			centerAngle			= M_PI;
			turningAngle		= 0;
			upperBorderAngle	= 2 * M_PI;
			lowerBorderAngle	= 0;
			
			eventType			= kCGEventMouseMoved;
			sensitivityRatio	= kMotionInjectorRatio;			
			
			// setup
			
			[ [ NSNotificationCenter defaultCenter ] addObserver : self
													 selector	 : @selector(screenInfoChange:) 
													 name		 : NSApplicationDidChangeScreenParametersNotification
													 object		 : nil ];
		
		}
	
		return self;
	
	}
	
	
	// destructor
	
	- ( void ) dealloc
	{

		// NSLog( @"MotionInjector dealloc" );
		
		// rollback
		
		[ [ NSNotificationCenter defaultCenter ] removeObserver : self 
												 name			: NSApplicationDidChangeScreenParametersNotification 
												 object			: nil ];

		[ super dealloc ];
	
	}
	
	
	// screen info changed
	
	- ( void ) screenInfoChange : ( NSNotification* ) theNotification
	{
	
		// NSLog( @"MotionInjector screenInfoChange %@" , theNotification );
	
		NSRect boundsRect	= [ [ NSScreen mainScreen ] frame ];
		
		xBorders			= CGPointMake( boundsRect.origin.x , 
										   boundsRect.origin.x + boundsRect.size.width );
		yBorders			= CGPointMake( boundsRect.origin.y , 
										   boundsRect.origin.y + boundsRect.size.height );
		centerPoint			= CGPointMake( boundsRect.origin.x + boundsRect.size.width  / 2 , 
										   boundsRect.origin.y + boundsRect.size.height / 2 );
	
	}
	
	
	// reset injection
	
	- ( void ) reset
	{
	
		// NSLog( @"MotionInjector reset" );

		centerAngle = M_PI;
	
	}


	// sets sesitivity, range is 0 - 1

	- ( void ) setSensitivity : ( double ) theSensitivity
	{
	
		// NSLog( @"MotionInjector setSensitivity %f" , pSensitivity );
	
		sensitivityRatio = theSensitivity;
		
		if ( sensitivityRatio < 0 ) sensitivityRatio = 0;
		if ( sensitivityRatio > 1 ) sensitivityRatio = 1;
	
	}


	// sets left mouse button state

	- ( void ) setLeftMouseButtonState: ( BOOL ) theState
	{

		// NSLog( @"MotionInjector setLeftMouseButtonState %i" , theState );
	
		eventType = theState ? kCGEventLeftMouseDragged : kCGEventMouseMoved;
	
	}


	// updates rotation data

	- ( void ) updateRotation : ( void* ) theData
	{

		// NSLog( @"MotionInjector updateRotation" );
	
		// get rotation struct from char array
		
		memcpy( &actualRotation ,
				theData ,
				sizeof( Rotation ) );
				
		// we are working with 0 .. 2 * M_PI radians for easier calculations
				
		actualRotation.z += M_PI;
		
		// screen center angle correction when rolling
		
		if ( actualRotation.x < -0.2 ) centerAngle += ( actualRotation.x + 0.2 ) / 100; else
		if ( actualRotation.x >  0.2 ) centerAngle += ( actualRotation.x - 0.2 ) / 100;
		
		// angle overflow
						
		if ( centerAngle < 0 ) centerAngle += 2 * M_PI; else
		if ( centerAngle > 2 * M_PI ) centerAngle -= 2 * M_PI;
		
		// turning borders
		
		upperBorderAngle = centerAngle + M_PI;
		lowerBorderAngle = centerAngle - M_PI;
		
		// calculate yaw delta
		
		deltaAngle = centerAngle - actualRotation.z;
		
		// check angle overflow
		
		if ( actualRotation.z > upperBorderAngle ) deltaAngle = ( 2 * M_PI - actualRotation.z  ) + centerAngle; else
		if ( actualRotation.z < lowerBorderAngle ) deltaAngle = ( centerAngle - 2 * M_PI ) - actualRotation.z;
		
		// calculate actual position
				
		actualPoint.x = centerPoint.x + deltaAngle		 * ( kMotionInjectorBase + kMotionInjectorLook * sensitivityRatio );
		actualPoint.y = centerPoint.y - actualRotation.y * ( kMotionInjectorBase + kMotionInjectorLook * sensitivityRatio );
		
		// calculate deltas

		deltaPoint.x = actualPoint.x - previousPoint.x;
		deltaPoint.y = actualPoint.y - previousPoint.y;

		// store actual as previous
	
		previousPoint = actualPoint;
		
		// check turning treshold
		
		if ( actualRotation.x < -0.06 ) turningAngle = ( actualRotation.x + 0.06 ) * kMotionInjectorTurn * sensitivityRatio; else
		if ( actualRotation.x >  0.06 ) turningAngle = ( actualRotation.x - 0.06 ) * kMotionInjectorTurn * sensitivityRatio;
		
		// prepare screen point and event type
		
		screenPoint = CGPointMake( actualPoint.x , actualPoint.y );								// primitive type, stack release
		
		// check screen borders
		
		if ( screenPoint.x < xBorders.x ) screenPoint.x = xBorders.x + 2; else
		if ( screenPoint.x > xBorders.y ) screenPoint.x = xBorders.y - 2;
		if ( screenPoint.y < yBorders.x ) screenPoint.y = yBorders.x + 2; else
		if ( screenPoint.y > yBorders.y ) screenPoint.y = yBorders.y - 2;
		
		// create event
		
		CGEventRef	mouseEvent = CGEventCreateMouseEvent( NULL			, 
														  eventType		, 
														  screenPoint	,
														  0				);						// pointer, needs release

		// set delta values for fps games

		CGEventSetIntegerValueField( mouseEvent , 
									 kCGMouseEventDeltaX , 
									 ( int64_t ) ( round( deltaPoint.x + turningAngle ) ) );
									 
		CGEventSetIntegerValueField( mouseEvent , 
									 kCGMouseEventDeltaY , 
									 ( int64_t ) ( round( deltaPoint.y ) ) );
									 
		// set flags
									 
		CGEventSetFlags			   ( mouseEvent , 256 );
		
		// post event
		
		CGEventPost				   ( kCGHIDEventTap , mouseEvent );
		
		// cleanup
		
		CFRelease				   ( mouseEvent	);
		
	}

	
	@end
