//  ButtonInjector.m
//  Remotion
//
//  Created by Milan Toth on 3/1/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "ButtonInjector.h"


	@implementation ButtonInjector


	// construcotr

	- ( id	 ) initWithDelegate : ( id ) theDelegate
	{

		// NSLog( @"ButtonIjector initWithDelegate %@" , pDelegate );
	
		self = [ super init ];
		
		if ( self )
		{
		
			delegate = [ theDelegate retain ];
		
		}
		
		return self;
	
	}
	
	
	// destructor
	
	- ( void ) dealloc
	{
	
		// NSLog( @"ButtonIjector dealloc" );
	
		[ delegate	release ];
		[ super		dealloc ];
	
	}


	// mouse button event injection

	- ( void )	injectMouseEvent : ( CGEventType	) theType 
				withButton		 : ( CGMouseButton	) theButton
				withState		 : ( uint			) theState
				
	{
	
		// NSLog( @"ButtonInjector injectMouseEvent %u withButton %u state %i" , pType , pButton , pState );
		
		// create mouse event with proper x and y values
	
		CGEventRef		empty	   = CGEventCreate( NULL );
		CGPoint			point	   = CGEventGetLocation( empty );
		CGEventRef		mouseEvent = CGEventCreateMouseEvent(	NULL	,
																theType	, 
																point	,
																theButton );
		
		// if pressed, adding proper clickstate and event pressure flags
		
		if ( theState )
		{

			CGEventSetIntegerValueField	( mouseEvent , kCGMouseEventClickState , 1 );
			CGEventSetDoubleValueField	( mouseEvent , kCGMouseEventPressure   , 1 );
		
		}

		CGEventSetFlags	( mouseEvent , 256 );
		
		// post and release
		
		CGEventPost		( kCGHIDEventTap ,
						  mouseEvent );
		CFRelease		( mouseEvent );
		CFRelease		( empty );

		// TODO CGEventLeftMouseDragged to enable window dragging

	}
	
	
	// keyboard event injection
	
	- ( void ) injectKeyboardEvent : ( uint ) theCode
			   withState		   : ( uint ) theState
	{

		// NSLog( @"ButtonInjector injectKeyboardEvent %u withState %u" , pCode , pState );	

		CGEventRef keyEvent = CGEventCreateKeyboardEvent (	NULL , 
															theCode , 
															theState );

		CGEventPost	( kCGHIDEventTap , 
					  keyEvent );
					  
		CFRelease	( keyEvent );

	}


	// update button state

	- ( void ) updateButton : ( void* ) theData
	{
	
		char* data = ( char* ) theData;
		
		char type  = data[ 0 ];
		char state = data[ 1 ];

		// NSLog( @"ButtonInjector type %i state %i" , type , state );

		switch ( type ) 
		{
		
			case kProtocolButtonA :
			{
				if ( state ) 
				{
					[ self	injectMouseEvent : kCGEventLeftMouseDown 
							withButton		 : kCGMouseButtonLeft 
							withState		 : state ];
							
					[ delegate	eventArrived : kButtonInjectorEventLeftMouseDown 
								fromInstance : self 
								withUserData : nil ];
						
				}									
				else
				{
					[ self	injectMouseEvent : kCGEventLeftMouseUp	 
							withButton		 : kCGMouseButtonLeft
							withState		 : state ];
							
					[ delegate	eventArrived : kButtonInjectorEventLeftMouseUp 
								fromInstance : self 
								withUserData : nil ];

				}
				break;
			}
			case kProtocolButtonB :
			{
				if ( state )
				{
					[ self	injectMouseEvent : kCGEventRightMouseDown 
							withButton		 : kCGMouseButtonRight
							withState		 : state ];
				}									
				else
				{
					[ self	injectMouseEvent : kCGEventRightMouseUp
							withButton		 : kCGMouseButtonRight
							withState		 : state ];
				}
				break;
			}
			
			case kProtocolButtonC :	[ self injectKeyboardEvent : 123 withState : state ]; break;	// LEFT ARROW
			case kProtocolButtonD :	[ self injectKeyboardEvent : 124 withState : state ]; break;	// RIGHT ARROW
			case kProtocolButtonE :	[ self injectKeyboardEvent : 125 withState : state ]; break;	// UP ARROW
			case kProtocolButtonF :	[ self injectKeyboardEvent : 126 withState : state ]; break;	// DOWN ARROW
			
			case kProtocolButtonG :	[ self injectKeyboardEvent : 34  withState : state ]; break;	// I
			case kProtocolButtonH :	[ self injectKeyboardEvent : 38  withState : state ]; break;	// J									
			case kProtocolButtonI :	[ self injectKeyboardEvent : 0	 withState : state ]; break;	// A
			case kProtocolButtonJ :	[ self injectKeyboardEvent : 11	 withState : state ]; break;	// B
			case kProtocolButtonK :	[ self injectKeyboardEvent : 8	 withState : state ]; break;	// C
			case kProtocolButtonL :	[ self injectKeyboardEvent : 2	 withState : state ]; break;	// D
			case kProtocolButtonM :	[ self injectKeyboardEvent : 14	 withState : state ]; break;	// E
			case kProtocolButtonN :	[ self injectKeyboardEvent : 3	 withState : state ]; break;	// F
			case kProtocolButtonO :	[ self injectKeyboardEvent : 5	 withState : state ]; break;	// G
			case kProtocolButtonP :	[ self injectKeyboardEvent : 4	 withState : state ]; break;	// H

		}
	
	}
	
	
	@end
