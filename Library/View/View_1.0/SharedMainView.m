//
//  UniMainView.m
//  GameControl
//
//  Created by Milan Toth on 2/17/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//

#import "SharedMainView.h"

@implementation SharedMainView


	// constructor
	
    - ( id   ) initWithFrame : ( CGRect ) pFrame
               withDelegate  : ( id     ) pDelegate
	{
	
		NSLog( @"SharedMainView initWithFrame" );
        
        #ifdef BUILD_TARGET_OSX
        self = [ super initWithFrame : NSRectFromCGRect( pFrame ) ];
        #else
        self = [ super initWithFrame : pFrame ];        
        #endif

		if ( self )
		{
        
            delegate = pDelegate;
            float colors [ ] = { .2 , .2 , .6 , 1.0 , .2 , .6 , 1.0 , 1.0 };

            // create

        buttonA = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonA withLabel : @"L" withFrame : CGRectMake( 0   , 0 , 160 , 160  ) withColors : colors withDelegate : delegate ];
        buttonB = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonB withLabel : @"R" withFrame : CGRectMake( 160 , 0 , 160 , 160  ) withColors : colors withDelegate : delegate ];

        buttonC = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonC withLabel : @"l" withFrame : CGRectMake( 0   , 400 , 105 , 80 ) withColors : colors withDelegate : delegate ];
        buttonD = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonD withLabel : @"r" withFrame : CGRectMake( 215 , 400 , 105 , 80 ) withColors : colors withDelegate : delegate ];
        buttonE = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonE withLabel : @"d" withFrame : CGRectMake( 105 , 400 , 110 , 80 ) withColors : colors withDelegate : delegate ];
        buttonF = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonF withLabel : @"u" withFrame : CGRectMake( 105 , 320 , 110 , 80 ) withColors : colors withDelegate : delegate ];
        
        buttonG = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonG withLabel : @"<" withFrame : CGRectMake( 0   , 320 , 105 , 80 ) withColors : colors withDelegate : delegate ];
        buttonH = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonH withLabel : @">" withFrame : CGRectMake( 215 , 320 , 105 , 80 ) withColors : colors withDelegate : delegate ];

        buttonI = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonI withLabel : @"A" withFrame : CGRectMake( 0   , 160 , 80 , 80 ) withColors : colors withDelegate : self ];
        buttonJ = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonJ withLabel : @"B" withFrame : CGRectMake( 80  , 160 , 80 , 80 ) withColors : colors withDelegate : self ];
        buttonK = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonK withLabel : @"C" withFrame : CGRectMake( 160 , 160 , 80 , 80 ) withColors : colors withDelegate : self ];
        buttonL = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonL withLabel : @"D" withFrame : CGRectMake( 240 , 160 , 80 , 80 ) withColors : colors withDelegate : self ];

        buttonM = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonM withLabel : @"E" withFrame : CGRectMake( 0   , 240 , 80 , 80 ) withColors : colors withDelegate : self ];
        buttonN = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonN withLabel : @"F" withFrame : CGRectMake( 80  , 240 , 80 , 80 ) withColors : colors withDelegate : self ];
        buttonO = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonO withLabel : @"G" withFrame : CGRectMake( 160 , 240 , 80 , 80 ) withColors : colors withDelegate : self ];
        buttonP = [ [ SharedButtonView alloc ] initWithId : kProtocolButtonP withLabel : @"H" withFrame : CGRectMake( 240 , 240 , 80 , 80 ) withColors : colors withDelegate : self ];
    
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

		NSLog( @"SharedMainView dealloc" );
    
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
        
        [ buttonA release ];
        [ buttonB release ];
        [ buttonC release ];
        [ buttonD release ];
        [ buttonE release ];
        [ buttonF release ];
        [ buttonG release ];
        [ buttonH release ];
        [ buttonI release ];
        [ buttonJ release ];
        [ buttonK release ];
        [ buttonL release ];
        [ buttonM release ];
        [ buttonN release ];
        [ buttonO release ];
        [ buttonP release ];
    
        [ super dealloc ];
    
    }


	// expands button

	- ( void ) expandButton : ( uint ) pId
	{
	
		NSLog( @"SharedMainView expandButton" );

		[ [ [ self subviews ] objectAtIndex : ( pId + 1 ) ] expand ];

	}


	// shrinks button

	- ( void ) shrinkButton : ( uint ) pId
	{

		NSLog( @"SharedMainView shrinkButton" );

		[ [ [ self subviews ] objectAtIndex : ( pId + 1 ) ] shrink ];

	}


    #ifdef BUILD_TARGET_OSX
    
    
    // set flipped coordinate system on os x
    
    - ( BOOL ) isFlipped
    {
    
        return YES;
    
    }
    

	// draw rectangle

	- ( void ) drawRect : ( NSRect ) pRect
	{

		// NSLog( @"SharedMainView drawRect" );
		
		NSColor* color = [ NSColor blackColor ];

		[ color			set				 ];
		[ NSBezierPath	fillRect : pRect ];

	}
    
    #endif    


@end
