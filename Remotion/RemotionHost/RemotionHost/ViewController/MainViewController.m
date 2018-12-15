//  MainViewController.m
//  Remotion
//
//  Created by Milan Toth on 3/1/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "MainViewController.h"


	@implementation MainViewController


	// constructor

	- ( id ) initWithDelegate : ( id ) theDelegate
	{
	
		// NSLog( @"MainViewController initWithDelegate %@" , pDelegate );

		self = [ super init ];
		
		if ( self ) 
		{
		
			// init
			
			delegate = [ theDelegate retain ];	// needs release

		}
		
		return self;
		
	}
	
	
	// destructor
	
	- ( void ) dealloc
	{

		// NSLog( @"MainViewController dealloc" );
		
		// rollback
		
		[ controlView	removeFromSuperview ];
		[ baseView		removeFromSuperview ];
		[ sliderView	removeFromSuperview ];
		[ welcomeView	removeFromSuperview ];
	
		// release
	
		[ delegate		release ];
		[ baseView		release ];
		[ controlView   release ];
		[ sliderView	release ];
		[ welcomeView	release ];
		[ super			dealloc ];
	
	}


	// loads views

	- ( void ) loadView
	{
	
		// NSLog( @"MainViewController loadView" );
	
		NSRect baseViewRect		= NSMakeRect( 0 , 0  , 320 , 560 );
		NSRect mainViewRect		= NSMakeRect( 0 , 80 , 320 , 480 );
		NSRect sliderViewRect	= NSMakeRect( 2 , 2  , 316 , 76 );
		NSRect welcomeViewRect	= NSMakeRect( 0 , 0  , 320 , 560 );

       float yellowColors [ ]	= { .9  , .6 , .2  , 1.0 , 
									.8  , .5 , .1  , 1.0 };

		baseView	= [ [ FlippedView	alloc ] initWithFrame : baseViewRect ];	// needs release

		controlView	= [ [ ControlView 	alloc ]	initWithFrame : NSRectToCGRect( mainViewRect )
												withDelegate  : nil ];			// needs release

		sliderView  = [ [ SliderView	alloc ] initWithFrame : sliderViewRect 
												withDelegate  : self ];			// needs release
        
		welcomeView = [ [ ButtonView	alloc ]	initWithId	  : 0 
												withLabel	  : @"WAITING FOR CONNECTION" 
												withFrame	  : NSRectToCGRect( welcomeViewRect )
												withColors	  : yellowColors 
												withDelegate  : delegate ];		// needs release
				
		[ self setView : baseView ];
	
	}
	
	
	// shows control screen
	
	- ( void ) showControl
	{

		// NSLog( @"MainViewController showControl" );
	
		// show slider
		// show main button view
		
		if ( baseView != nil )
		{
		
			[ welcomeView	removeFromSuperview ];
			[ baseView		addSubview : sliderView ];
			[ baseView		addSubview : controlView ];
		
		}
	
	}
	
	
	// shows welcome screen
	
	- ( void ) showWelcome
	{

		// NSLog( @"MainViewController showWelcome" );
	
		// waiting for connection
		// this computer's id is HOSTNAME
		
		if ( baseView != nil )
		{
		
			[ sliderView	removeFromSuperview ];
			[ controlView 	removeFromSuperview ];
			[ baseView		addSubview : welcomeView ];
		
		}
	
	}


	// expand main button

	- ( void ) expandButton	: ( uint ) theId
	{

		// NSLog( @"MainViewController expandButton %u" , pId );
	
		NSNumber* buttonId = [ [ NSNumber alloc ] initWithUnsignedInt : theId ];	// needs release
		
		[ controlView	performSelectorOnMainThread : @selector(expandButton:) 
						withObject					: buttonId
						waitUntilDone				: NO ];
					
		[ buttonId release ];
	
	}
	
	
	// shrink main button
	
	- ( void ) shrinkButton : ( uint ) theId
	{

		// NSLog( @"MainViewController shrinkButton %u" , pId );
	
		NSNumber* buttonId = [ [ NSNumber alloc ] initWithUnsignedInt : theId ];	// needs release
		
		[ controlView	performSelectorOnMainThread : @selector(shrinkButton:) 
						withObject					: buttonId
						waitUntilDone				: NO ];
					
		[ buttonId release ];
	
	}


	// sets sensitivity sliders position

	- ( void ) setSensitivity : ( double ) theSensitivity
	{

		// NSLog( @"MainViewController setSensitivity %f" , pSensitivity );
	
		[ sliderView setRatio : theSensitivity ];
	
	}


	// event arrived

	- ( void )	eventArrived : ( uint	) theId 
				fromInstance : ( void*	) theInstance 
				withUserData : ( void*	) theUserData
	{
	
		// NSLog( @"MainViewController eventArrived %u fromInstance %@ withUserData" , pId , pInstance );
		
		if ( theInstance == sliderView )
		{
		
			[ delegate	eventArrived	: kMainViewControllerEventSensitivity 
						fromInstance	: self 
						withUserData	: theUserData ];
		
		}
	
	}


	@end
