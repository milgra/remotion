//  StateHandler.h
//  RemotionHost
//
//  Created by Milan Toth on 3/25/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import "MainViewController.h"
	#import "MotionInjector.h"


	#define kStateIdle				0
	#define kStateBrowsing			1


	@interface StateHandler : NSObject
	{
	
        uint					applicationState;
		MotionInjector*			motionInjector;
		MainViewController*		mainController;
		
	}
	
	
	- ( id	 )	initWithMainController	: ( MainViewController* ) theMainController
				withMotionInjector		: ( MotionInjector*		) theMotionHandler;
	- ( void )	switchToIdleState;
	- ( void )	switchToControlState;


	@end
