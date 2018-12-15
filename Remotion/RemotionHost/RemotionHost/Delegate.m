//  Delegate.m
//  Remotion
//
//  Created by Milan Toth on 1/30/11.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "Delegate.h"


	#define kDelegateSensitivityKey @"kDelegateSensitivityKey"


	@implementation Delegate


	// application entering point

	- ( void )	applicationDidFinishLaunching : ( NSNotification* ) theNotification
	{

		// NSLog( @"Delegate applicationDidFinishLaunching" );
		
		// create
		
		NSRect mainScreen  = [ [ NSScreen mainScreen ] frame ];
											
		NSRect windowRect  = NSMakeRect( mainScreen.size.width / 2 - 160 , 
										 mainScreen.size.height / 2 - 280 , 
										 320 , 
										 560 );

		mainWindow		= [ [ NSWindow	alloc ]	initWithContentRect : windowRect
												styleMask			: NSTitledWindowMask | NSClosableWindowMask
												backing				: NSBackingStoreBuffered
												defer				: NO ];							// needs release
		
		buttonInjector	= [ [ ButtonInjector	 alloc ] initWithDelegate		: self ];			// needs release
		motionInjector	= [ [ MotionInjector	 alloc ] init ];									// needs release
		mainController	= [ [ MainViewController alloc ] initWithDelegate		: self ];			// needs release
		stateHandler	= [ [ StateHandler		 alloc ] initWithMainController : mainController
														 withMotionInjector		: motionInjector ];	// needs release

		// setup

		[ mainWindow setHasShadow			: YES					];
		[ mainWindow makeKeyAndOrderFront	: nil					];
		[ mainWindow setContentView			: mainController.view	];
		[ mainWindow setReleasedWhenClosed  : NO					];
		
		// start
		
		udpHost = [ [ UdpHost alloc ] initWithDelegate : self ];					// needs release
		
		if ( udpHost )
		{
		
			pusher = [ [ BonjourPublisher alloc ]	initWithDomain	: @"" 
													withType		: @"_gamecontrol._udp."  
													withName		: @"" 
													withPort		: [ udpHost portNumber ] ]; // needs release

			[ mainController	showWelcome		];
			[ self				loadSensitivity ];
							 
			NSLog( @"Socket opened on port : %u, started listening...\n" , [ udpHost portNumber ] );
		
		}
	
	}
	
	
	// destructor
	
	- ( void )	dealloc
	{
	
		// NSLog( @"Delegate dealloc" );
	
		[ pusher			release ];
		[ udpHost			release ];
		[ mainWindow		release ];
		
		[ buttonInjector	release ];
		[ motionInjector	release ];
		[ mainController 	release ];
	
		[ super				dealloc ];
	
	}
	
	
	// loads previous sensitivity values
	
	- ( void )	loadSensitivity
	{
	
		// NSLog( @"Delegate loadSensitivity" );
			
		NSNumber* sensitivity = [ [ NSUserDefaults standardUserDefaults ] objectForKey : kDelegateSensitivityKey ];
		
		if ( sensitivity == nil )
		{
		
			sensitivity = [ NSNumber numberWithDouble : .5 ];		// autorelease
			
			[ [ NSUserDefaults standardUserDefaults ]	setObject	: sensitivity 
														forKey		: kDelegateSensitivityKey ];
			[ [ NSUserDefaults standardUserDefaults ]	synchronize ];
		
		}
		
		[ mainController setSensitivity : [ sensitivity doubleValue ] ];
		[ motionInjector setSensitivity : [ sensitivity doubleValue ] ];

	}

    
    // control event HUB
    
    - ( void )  eventArrived : ( uint  ) theId
                fromInstance : ( void* ) theInstance
                withUserData : ( void* ) theUserData
    {

		// NSLog( @"Delegate eventArrived fromInstance withUserData" );
        
        if ( theInstance == mainController ) [ self mainViewEvent   : theId withUserData : theUserData ]; else
        if ( theInstance == buttonInjector ) [ self buttonEvent     : theId withUserData : theUserData ]; else
		if ( theInstance == udpHost        ) [ self hostEvent		: theId withUserData : theUserData ];
    
    }
	
	
	// host event
	
	- ( void )	hostEvent		: ( uint  ) theId
				withUserData	: ( void* ) theUserData
	{
	
		// NSLog( @"Delegate hostEvent withUserData" );
		
		switch ( theId )
		{
		
			case kUdpHostConnectionSuccess : [ stateHandler switchToControlState ]; break;
			case kUdpHostConnectionClosure : [ stateHandler switchToIdleState    ]; break;
			case kUdpHostButtonData :
			{
			
				[ buttonInjector updateButton : theUserData ];			

				char* data = ( char* ) theUserData;
				char type  = data[ 0 ];
				char state = data[ 1 ];
				
				if ( state == kProtocolButtonStateDown ) [ mainController expandButton : type ];
				else [ mainController shrinkButton : type ];

				break;
				
			}
			case kUdpHostRotationData :
			{
			
				[ motionInjector updateRotation : theUserData ];
				break;
				
			}

		}
	
	}
	
	
	// event came from main view controller
	
	- ( void )	mainViewEvent	: ( uint  ) theId
				withUserData	: ( void* ) theUserData
	{

		// NSLog( @"Delegate mainViewEvent withUserData" );
	
		if ( theId == kMainViewControllerEventSensitivity )
		{
		
			NSNumber* sensitivity = [ NSNumber numberWithDouble :  * ( double* ) ( theUserData ) ];	// autorelease
		
			[ motionInjector setSensitivity : [ sensitivity doubleValue ] ];

			[ [ NSUserDefaults standardUserDefaults ]	setObject	: sensitivity					// autorelease
														forKey		: kDelegateSensitivityKey ];
			[ [ NSUserDefaults standardUserDefaults ]	synchronize ];
		
		}
	
	}

	
	// event came from button injector
	
	- ( void )	buttonEvent		: ( uint  ) theId
				withUserData	: ( void* ) theUserData
	{
	
		// NSLog( @"Delegate buttonEvent withUserData" );

		switch ( theId )
		{
		
			case kButtonInjectorEventLeftMouseDown  : [ motionInjector	setLeftMouseButtonState : YES ]; break;
			case kButtonInjectorEventLeftMouseUp	: [ motionInjector	setLeftMouseButtonState : NO  ]; break;
			
		}
	
	}
	
	
	// dock icon clicked
	
	- ( BOOL )	applicationShouldHandleReopen : ( NSApplication* ) theApplication
				hasVisibleWindows			  : ( BOOL			 ) theFlag
	{

		// NSLog( @"Delegate applicationShouldHandleReopen hasVisibleWindows" );

		[ mainWindow makeKeyAndOrderFront : nil	];
		
		return YES;
		
	}


	@end
