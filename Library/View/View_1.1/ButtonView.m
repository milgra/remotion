//  ButtonView.m
//  Remotion
//
//  Created by Milan Toth on 2/17/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "ButtonView.h"
	#import "LabelGenerator.h"


	@implementation ButtonView


	// constructor

	- ( id )    initWithId   : ( uint       ) theButtonId
                withLabel    : ( NSString*  ) theLabel
                withFrame    : ( CGRect     ) theRect 
                withColors   : ( float*     ) theColors
                withDelegate : ( id         ) theDelegate
    {

		// NSLog( @"ButtonView initWithFrame" );

		expandedRect = CGRectInset( theRect , 7 , 7 );
        originalRect = CGRectInset( theRect , 2 , 2 );

        #ifdef BUILD_TARGET_OSX
        self = [ super initWithFrame : NSRectFromCGRect( originalRect ) ];
        #else
        self = [ super initWithFrame : originalRect ];        
        #endif

		if ( self )
		{
        
            // init

			buttonId    = theButtonId;
			
            delegate    = [ theDelegate retain ];								// needs release
			buttonLabel = [ theLabel    retain ];								// needs release
            
            #ifdef BUILD_TARGET_OSX
			[ self setImageScaling : NSScaleToFit ];                            // set scaling on os x
            #else
			[ self setUserInteractionEnabled : YES  ];
            #endif

            float colorA [ ] = { theColors[ 0 ] , 
								 theColors[ 1 ] , 
								 theColors[ 2 ] , 
								 theColors[ 3 ] };
								 
            float colorB [ ] = { theColors[ 4 ] ,
								 theColors[ 5 ] ,
								 theColors[ 6 ] ,
								 theColors[ 7 ] };
								 
			CGRect imageRect = CGRectMake(  0 , 
                                            0 , 
                                            originalRect.size.width * 2, 
                                            originalRect.size.height * 2 );

            // setup

			[ self setImage : [ LabelGenerator generateImage : buttonLabel 
											   withColorA	 : colorA
											   withColorB	 : colorB
											   inRectangle   : imageRect 
											   hasBackground : YES ] ];		// autorelease

		}
        
        return self;
    }
    
    
    // destructor
    
    - ( void ) dealloc 
    {
	
		// NSLog( @"ButtonView dealloc" );
		
		// rollback
		
		[ self setImage : nil ];
		
		// destruct
    
        [ delegate      release ];
        [ buttonLabel   release ];
        [ super         dealloc ];
    
    }


	// expands view

	- ( void ) expand
	{

		// NSLog( @"ButtonView expand" );

        #ifdef BUILD_TARGET_OSX
        
		[ [ NSAnimationContext currentContext ] setDuration	: .05			];
		[ [ self			   animator		  ] setFrame 	: NSRectFromCGRect( expandedRect ) ];
        
        #else
        
		[ UIView beginAnimations		: @"" 
				 context				: nil			];
		[ UIView setAnimationDuration	: .05			];
		[ self	 setFrame				: expandedRect	];
		[ UIView commitAnimations						];
        
        #endif

	}


	// shrinks view

	- ( void ) shrink
	{

		// NSLog( @"ButtonView shrink" );

        #ifdef BUILD_TARGET_OSX
        
		[ [ NSAnimationContext currentContext ] setDuration : .05		   ];
		[ [ self			   animator		  ] setFrame 	: NSRectFromCGRect( originalRect ) ];
        
        #else
        
		[ UIView beginAnimations		: @"" 
				 context				: nil			];
		[ UIView setAnimationDuration	: .05			];
		[ self	 setFrame				: originalRect	];
		[ UIView commitAnimations						];
        
        #endif

	}

    
    // iphone-only touch events
    
   #ifdef BUILD_TARGET_IOS

	// touch start

	- ( void )  touchesBegan : ( NSSet*		) theTouches
                withEvent	 : ( UIEvent*	) theEvent
	{

		// NSLog( @"ButtonView touchesBegan" );
        
        // bring button to front

		[ self.superview bringSubviewToFront : self ];
        
        // animate expansion
        
        [ self expand ];
        
        // notify delegate about press

        NSNumber* idNumber = [ [ NSNumber alloc ] initWithInt : buttonId ];		// needs release
        
        [ delegate  eventArrived : kSharedButtonViewEventPress
                    fromInstance : self
                    withUserData : &buttonId ];
                    
        [ idNumber release ];

	}


	// touch ended

	- ( void )  touchesEnded : ( NSSet*		) theTouches
                withEvent	 : ( UIEvent*	) theEvent
	{

		// NSLog( @"ButtonView touchesEnded" );
        
        // animate shrinking

        [ self shrink ];
        
        // notify delegate

        NSNumber* idNumber = [ [ NSNumber alloc ] initWithInt : buttonId ];		// needs release
        
        [ delegate  eventArrived : kSharedButtonViewEventRelease
                    fromInstance : self
                    withUserData : &buttonId ];
                    
        [ idNumber release ];

	}
    
    #endif

    // os x only mouse events

    #ifdef BUILD_TARGET_OSX
    
    // mouse down event

	- ( void ) mouseDown : ( NSEvent* ) theEvent 
	{

		// NSLog( @"ButtonView mouseDown" );

		[ self expand ];

	}


	// mouse up event

	- ( void ) mouseUp	: ( NSEvent* ) theEvent 
	{

		// NSLog( @"ButtonView mouseUp" );

		[ self shrink ];

	}    
    
    
    // view origo should be at top left, like on ios
    
    - ( BOOL ) isFlipped
    {
    
        return YES;
    
    }
    
    #endif

    
	@end