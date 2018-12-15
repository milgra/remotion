//  MotionInjector.h
//  Remotion
//
//  Created by Milan Toth on 3/1/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import <AppKit/AppKit.h>


	typedef struct 
	{
	
		double x;
		double y;
		double z;
		
	} Rotation;


	@interface MotionInjector : NSObject
	{
	
		// all variables are member variables to avoid continuous allocation
		
		double			deltaAngle;			// difference between actual yaw value and centerAngle
		double			centerAngle;		// yaw position aiming to screen center
		double			turningAngle;		// angle what we add to deltaX for turning when phone is rolled
		double			upperBorderAngle;	// centerAngle + M_PI, maximum possible yaw value
		double			lowerBorderAngle;	// centerAngle - M_PI, minimum possible yaw value

		double			sensitivityRatio;	// sensitivity ratio of controller
						
		CGPoint			xBorders;			// horizontal screen borders, min and max
		CGPoint			yBorders;			// vertical screen borders, min and max

		CGPoint			deltaPoint;			// contains difference of actual point and previous point
		CGPoint			centerPoint;		// center point of main screen
		CGPoint			actualPoint;		// actual position of mouse
		CGPoint			screenPoint;		// screen position of mouse, normalized actualPoint
		CGPoint			previousPoint;		// previous position of mouse

		CGEventType		eventType;			// mouse event type, moved or dragged
		Rotation		actualRotation;		// actual arrived rotation value

	}


	- ( id	 ) init;
	- ( void ) reset;
	- ( void ) updateRotation			: ( void*  ) theData;
	- ( void ) setSensitivity			: ( double ) theSensitivity;
	- ( void ) setLeftMouseButtonState	: ( BOOL   ) theState;


	@end
