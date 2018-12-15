//  StateHandler.m
//  Remotion
//
//  Created by Milan Toth on 3/24/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.

	
	#import "StateHandler.h"

	
	@implementation StateHandler
	
	
	@synthesize services;
	@synthesize serviceAddresses;
	@synthesize selectedService;


	// constructor

	- ( id ) initWithConnection		: ( UdpClient*          ) pConnection
			 withMotionHandler		: ( MotionHandler*		) pMotionHandler
			 withBonjourBrowser		: ( BonjourBrowser*		) pBonjourBrowser
			 withRootViewController : ( RootViewController* ) pViewController
	{
	
		// NSLog( @"StateHandler initWithConnection withMotionHandler withBonjoruBrowser withRootViewController" );
	
		self = [ super init ];
		
		if ( self )
		{
		
			connection			= [ pConnection		retain ];
			motionHandler		= [ pMotionHandler	retain ];
			bonjourBrowser		= [ pBonjourBrowser retain ];
			rootViewController	= [ pViewController retain ];

			applicationState	= kStateMenu;
		
		}
		
		return self;
	
	}
	
	
	// destructor
	
	- ( void ) dealloc
	{
	
		// NSLog( @"StateHandler dealloc" );
		
		[ connection			release ];
		[ motionHandler			release ];
		[ bonjourBrowser		release ];
		[ rootViewController	release ];
		
		[ super					dealloc ];
	
	}
	
	
	// switching to menu state
	
	- ( void )	switchToMenuState
	{
	
		// NSLog( @"StateHandler swithToMenuState" );
	
		// menu state switching can happen from every state
	
		switch ( applicationState ) 
		{
		
			case kStateBrowsing  :
			case kStateSelecting :
			case kStateResolving :
			case kStateNoService :
			{
			
				[ bonjourBrowser	stop ];
			
				break;
			}		
			case kStateTimeout :
			case kStateConnecting :
			case kStateDisconnected :
			{
			
				[ bonjourBrowser	stop ];
				[ connection		disconnect ];
			
				break;
			}
			case kStateConnected :
			{
			
				[ motionHandler		stop ];
				[ connection		disconnect ];
				
				break;

			}
		
		}

		applicationState = kStateMenu;
		[ rootViewController openMenuView ];
	
	}
	

	// switching to browsing state, can happen only from menu state
	
	- ( void )	switchToBrowsingState
	{

		// NSLog( @"StateHandler swithToBrowsingState" );
	
		// browsing state switching can happen only from menu state
	
		if ( applicationState == kStateMenu )
		{
			
			if ( [ NetworkUtilities wirelessAvailable ] ) 
			{

				applicationState = kStateBrowsing;
				
				[ bonjourBrowser		search ];
				
				[ rootViewController	setStatusLabel	: @"CONNECTING..." 
										withRed			: NO ];
				[ rootViewController	openStatusView ];
				
			}
			else
			{
			
				applicationState = kStateNoService;
				
				[ rootViewController	setStatusLabel	: @"NO WI-FI CONNECTION" 
										withRed			: YES ];
				[ rootViewController	openStatusView ];
			
			}
		
		}
	
	}
	

	// switching to selecting state, can happen only from browsing state
	
	- ( void )	switchToSelectingState
	{

		// NSLog( @"StateHandler swithToSelectingState" );

		// selecting state can happen only from browsing state
	
		if ( applicationState == kStateBrowsing )
		{
		
			applicationState = kStateSelecting;
		
			[ rootViewController openListView : services ];
		
		}
	
	}
	

	// switching to resolving state, can happen only from browsing and selecting state
	
	- ( void )	switchToResolvingState
	{

		// NSLog( @"StateHandler swithToResolvingState" );
	
		// only from browsing or selecting state
	
		if ( applicationState == kStateBrowsing ||
			 applicationState == kStateSelecting )
		{

			applicationState = kStateResolving;
		
			[ rootViewController	setStatusLabel	: @"CONNECTING..." 
									withRed			: NO ];
			[ rootViewController	openStatusView ];
			[ bonjourBrowser		resolve : selectedService ];
		
		}
	
	}
	

	// switching to no host state, can happen only from resolving or browsing state
	
	- ( void )	switchToNoHostState
	{

		// NSLog( @"StateHandler swithToNoHostState" );
	
		// only from browsing or selecting state
	
		if ( applicationState == kStateResolving || 
			 applicationState == kStateBrowsing )
		{

			applicationState = kStateNoService;
		
			[ rootViewController setStatusLabel : @"NO HOSTS AVAILABLE"
								 withRed		: YES ];
			[ rootViewController openStatusView ];
		
		}
	
	}


	// switching to connecting state, can happen only from resolving state

	- ( void )	switchToConnectingState
	{

		// NSLog( @"StateHandler swithToConnectingState %i" , applicationState );
	
		// only from browsing or selecting state
	
		if ( applicationState == kStateResolving ||
			 applicationState == kStateConnecting )
		{
		
			[ bonjourBrowser stop ];
		
			if ( [ serviceAddresses count ] > 0 )
			{

				applicationState = kStateConnecting;
				
				NSData*						rawdata			= [ serviceAddresses objectAtIndex : 0 ];
				struct sockaddr_storage*	clientAddress	= ( struct sockaddr_storage* ) [ rawdata bytes ];
				
				[ serviceAddresses	removeObjectAtIndex : 0 ];
				[ connection		disconnect ];
				[ connection		connectToAddress	: *clientAddress ];
				
			}
			else 
			{

				applicationState = kStateNoService;

				[ rootViewController setStatusLabel : @"NO HOSTS AVAILABLE"
									 withRed		: YES ];
				[ rootViewController openStatusView ];

			}
		
		}
	
	}


	// switching to timout state, can happen only from connecting state
    
	- ( void )	switchToTimeoutState
	{

		// NSLog( @"StateHandler swithToTimeoutState" );
	
		if ( applicationState == kStateConnecting )
		{
		
			applicationState = kStateTimeout;
			
			[ rootViewController setStatusLabel : @"NO HOSTS AVAILABLE"
								 withRed		: YES ];
			[ rootViewController openStatusView ];
		
		}
	
	}


	// switching to connected state, can happen only from connecting state

	- ( void )	switchToConnectedState
	{

		// NSLog( @"StateHandler swithToConnectedState state : %i" , applicationState );
	
		if ( applicationState == kStateConnecting )
		{
		
			applicationState = kStateConnected;
			
			[ rootViewController openControlView ];
            [ motionHandler      start			 ];
		
		}
	
	}


	// switching to disconnected state, can happen only from connected state

	- ( void )	switchToDisconnectedState
	{

		// NSLog( @"StateHandler swithToDisconnectedState" );
	
		if ( applicationState == kStateConnected )
		{
		
			applicationState = kStateDisconnected;
			
            [ motionHandler      stop				  ];
			[ connection		 disconnect			  ];

			[ rootViewController setStatusLabel : @"DISCONNECTED" 
								 withRed		: YES ];
			[ rootViewController openStatusView ];
		
		}
	
	}
	

	@end
