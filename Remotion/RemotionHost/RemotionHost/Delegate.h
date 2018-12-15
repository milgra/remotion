//  Delegate.h
//  Remotion
//
//  Created by Milan Toth on 1/30/11.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import "UdpHost.h"
	#import "StateHandler.h"
	#import "EventDelegate.h"
	#import "ButtonInjector.h"
	#import "MotionInjector.h"
	#import "BonjourPublisher.h"
	#import "MainViewController.h"

	
	#define kStateWaiting	0
	#define kStateConnected 1


	@interface Delegate : NSObject < EventDelegate >
	{

		NSWindow*				mainWindow;
		MainViewController*	mainController;

		StateHandler*			stateHandler;
		UdpHost*				udpHost;
		BonjourPublisher*		pusher;
		
		ButtonInjector*			buttonInjector;
		MotionInjector*			motionInjector;		
	
	}


	@end