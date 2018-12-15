//  ControlView.m
//  Remotion
//
//  Created by Milan Toth on 2/17/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "ControlView.h"


	@implementation ControlView


	// constructor
	
    - ( id   ) initWithFrame : ( CGRect ) theFrame
               withDelegate  : ( id     ) theDelegate
	{
	
		// NSLog( @"ControlView initWithFrame" );
        
        #ifdef BUILD_TARGET_OSX
        self = [ super initWithFrame : NSRectFromCGRect( theFrame ) ];
        #else
        self = [ super initWithFrame : theFrame ];        
        #endif

		if ( self )
		{

            // init
			
            float colors [ ] = { .2 , .2 , .6  , 1.0 , 
								 .2 , .6 , 1.0 , 1.0 };
        
            delegate = [ theDelegate retain ];									// needs release

			buttonA  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonA 
												withLabel	 : @"L" 
												withFrame	 : CGRectMake( 0   , 0 , 160 , 160  ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
													
			buttonB  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonB 
												withLabel	 : @"R" 
												withFrame	 : CGRectMake( 160 , 0 , 160 , 160  ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
													
			buttonC  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonC 
												withLabel	 : @"l" 
												withFrame	 : CGRectMake( 0   , 400 , 105 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
													
			buttonD  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonD 
												withLabel	 : @"r" 
												withFrame	 : CGRectMake( 215 , 400 , 105 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
												
			buttonE  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonE 
												withLabel	 : @"d" 
												withFrame	 : CGRectMake( 105 , 400 , 110 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
													
			buttonF  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonF 
												withLabel	 : @"u" 
												withFrame	 : CGRectMake( 105 , 320 , 110 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
												
			buttonG  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonG 
												withLabel	 : @"I" 
												withFrame	 : CGRectMake( 0   , 320 , 105 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
													
			buttonH  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonH 
												withLabel	 : @"J" 
												withFrame	 : CGRectMake( 215 , 320 , 105 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release

			buttonI  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonI 
												withLabel	 : @"A" 
												withFrame	 : CGRectMake( 0   , 160 , 80 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
													
			buttonJ  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonJ 
												withLabel	 : @"B" 
												withFrame	 : CGRectMake( 80  , 160 , 80 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
													
			buttonK  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonK 
												withLabel	 : @"C" 
												withFrame	 : CGRectMake( 160 , 160 , 80 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
													
			buttonL  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonL 
												withLabel	 : @"D" 
												withFrame	 : CGRectMake( 240 , 160 , 80 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release

			buttonM  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonM 
												withLabel	 : @"E" 
												withFrame	 : CGRectMake( 0   , 240 , 80 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
													
			buttonN  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonN 
												withLabel	 : @"F" 
												withFrame	 : CGRectMake( 80  , 240 , 80 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
													
			buttonO  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonO 
												withLabel	 : @"G" 
												withFrame	 : CGRectMake( 160 , 240 , 80 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
													
			buttonP  = [ [ ButtonView alloc ]	initWithId	 : kProtocolButtonP 
												withLabel	 : @"H" 
												withFrame	 : CGRectMake( 240 , 240 , 80 , 80 ) 
												withColors	 : colors 
												withDelegate : delegate ];		// needs release
    
            // setup

			[ self addSubview : buttonA ];
			[ self addSubview : buttonB ];
			[ self addSubview : buttonC ];
			[ self addSubview : buttonD ];
			[ self addSubview : buttonE ];
			[ self addSubview : buttonF ];
			[ self addSubview : buttonG ];
			[ self addSubview : buttonH ];
			[ self addSubview : buttonI ];
			[ self addSubview : buttonJ ];
			[ self addSubview : buttonK ];
			[ self addSubview : buttonL ];
			[ self addSubview : buttonM ];
			[ self addSubview : buttonN ];
			[ self addSubview : buttonO ];
			[ self addSubview : buttonP ];            
            
        }

		return self;

	}
    
    
    // destructor
    
    - ( void ) dealloc
    {

		// NSLog( @"ControlView dealloc" );
		
		// rollback
		
        [ buttonA  removeFromSuperview ];
        [ buttonB  removeFromSuperview ];
        [ buttonC  removeFromSuperview ];
        [ buttonD  removeFromSuperview ];
        [ buttonE  removeFromSuperview ];
        [ buttonF  removeFromSuperview ];
        [ buttonG  removeFromSuperview ];
        [ buttonH  removeFromSuperview ];
        [ buttonI  removeFromSuperview ];
        [ buttonJ  removeFromSuperview ];
        [ buttonK  removeFromSuperview ];
        [ buttonL  removeFromSuperview ];
        [ buttonM  removeFromSuperview ];
        [ buttonN  removeFromSuperview ];
        [ buttonO  removeFromSuperview ];
        [ buttonP  removeFromSuperview ];
		
		// destruct
		
		[ delegate release ];
    
        [ buttonA  release ];
        [ buttonB  release ];
        [ buttonC  release ];
        [ buttonD  release ];
        [ buttonE  release ];
        [ buttonF  release ];
        [ buttonG  release ];
        [ buttonH  release ];
        [ buttonI  release ];
        [ buttonJ  release ];
        [ buttonK  release ];
        [ buttonL  release ];
        [ buttonM  release ];
        [ buttonN  release ];
        [ buttonO  release ];
        [ buttonP  release ];
    
        [ super	   dealloc ];
    
    }


	// expands button

	- ( void ) expandButton : ( NSNumber* ) theId
	{
	
		// NSLog( @"ControlView expandButton %u" , [ pId unsignedIntValue ] );

		[ [ [ self subviews ] objectAtIndex : [ theId unsignedIntValue ] ] expand ];

	}


	// shrinks button

	- ( void ) shrinkButton : ( NSNumber* ) theId
	{

		// NSLog( @"ControlView shrinkButton %u" , [ pId unsignedIntValue ] );

		[ [ [ self subviews ] objectAtIndex : [ theId unsignedIntValue ] ] shrink ];

	}


    #ifdef BUILD_TARGET_OSX
    
    
    // set flipped coordinate system on os x
    
    - ( BOOL ) isFlipped
    {
    
        return YES;
    
    }
    

	// draw rectangle

	- ( void ) drawRect : ( NSRect ) theRect
	{

		// NSLog( @"ControlView drawRect" );
		
		NSColor* color = [ NSColor blackColor ];

		[ color			set				   ];
		[ NSBezierPath	fillRect : theRect ];

	}
    
    #endif    


	@end