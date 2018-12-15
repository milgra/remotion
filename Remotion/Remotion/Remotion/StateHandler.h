//  StateHandler.h
//  Remotion
//
//  Created by Milan Toth on 3/24/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import "UdpClient.h"
	#import "MotionHandler.h"
	#import "BonjourBrowser.h"
	#import "NetworkUtilities.h"
	#import "RootViewController.h"


	#define kStateMenu				0
	#define kStateBrowsing			1
	#define kStateSelecting			2
	#define kStateResolving			3
	#define kStateNoService			4
	#define kStateConnecting		5
	#define kStateTimeout			6
	#define kStateDisconnected		7
	#define kStateConnected			8


	@interface StateHandler : NSObject
	{
	
        uint					applicationState;
        
        UdpClient*              connection;
        MotionHandler*          motionHandler;
        BonjourBrowser*         bonjourBrowser;
        RootViewController*     rootViewController;
		
	}
	
	
	@property ( retain ) NSMutableArray*	services;
	@property ( retain ) NSMutableArray*	serviceAddresses;
	@property ( retain ) NSNetService*		selectedService;
	
	
	- ( id ) initWithConnection		: ( UdpClient*          ) pConnection
			 withMotionHandler		: ( MotionHandler*		) pHandler
			 withBonjourBrowser		: ( BonjourBrowser*		) pBrowser
			 withRootViewController : ( RootViewController* ) pController;


	- ( void )	switchToMenuState;
	- ( void )	switchToBrowsingState;
	- ( void )	switchToSelectingState;
	- ( void )	switchToResolvingState;
	- ( void )	switchToNoHostState;
	- ( void )	switchToConnectingState;
	- ( void )	switchToTimeoutState;
	- ( void )	switchToConnectedState;
	- ( void )	switchToDisconnectedState;
	
	
	@end
