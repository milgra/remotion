//
//  StateHandler.m
//  RemotionHost
//
//  Created by Milan Toth on 3/25/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//

	
	#import "StateHandler.h"


	@implementation StateHandler


	// constructor

	- ( id	 )	initWithMainController	: ( MainViewController* ) theMainController
				withMotionInjector		: ( MotionInjector*		) theMotionHandler
	{
	
		// NSLog( @"StateHandler initWithMainController withMotionInjector" );
	
		self = [ super init ];
		
		if ( self )
		{
		
			mainController = [ theMainController	retain ];
			motionInjector = [ theMotionHandler	retain ];
		
		}
		
		return self;
	
	}


	// destructor
	
	- ( void )	dealloc
	{

		// NSLog( @"StateHandler dealloc" );
	
		[ motionInjector release ];
		[ mainController release ];
		[ super			 dealloc ];
	
	}


	// switching to idle state

	- ( void )	switchToIdleState
	{

		// NSLog( @"StateHandler switchToIdleState" );

		[ mainController showWelcome ];
	
	}
	
	
	// switching to control state
	
	- ( void )	switchToControlState
	{

		// NSLog( @"StateHandler switchToControlState" );

		[ mainController showControl ];
		[ motionInjector reset ];
	
	}


	@end
