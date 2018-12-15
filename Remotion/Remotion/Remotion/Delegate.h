//  Delegate.h
//  Remotion
//
//  Created by Milan Toth on 1/28/11.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <UIKit/UIKit.h>
	#import "UdpClient.h"               // for networking
	#import "StateHandler.h"            // application state handler
	#import "EventDelegate.h"           // delegate is a view event delegate
	#import "MotionHandler.h"           // dispatches motion sensor events
	#import "BonjourBrowser.h"          // browses for bonjour hosts
	#import "RootViewController.h"      // root view controller


	@interface Delegate : NSObject < UIApplicationDelegate , 
                                     EventDelegate         >
	{
        
		UIWindow*               mainWindow;
        UdpClient*              connection;

		StateHandler*			stateHandler;
        MotionHandler*          motionHandler;
        BonjourBrowser*         bonjourBrowser;
        RootViewController*     rootViewController;

	}


	@end

