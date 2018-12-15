//
//  ZoomButtonView.m
//  GameControl
//
//  Created by Milan Toth on 2/17/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//

#import "SharedButtonView.h"
#import "SharedLabelGenerator.h"

// TODO move out audio handling

#ifdef BUILD_TARGET_IOS
#import <AudioToolbox/AudioToolbox.h>
#endif


@implementation SharedButtonView



	// constructor

	- ( id )    initWithId   : ( uint       ) pButtonId
                withLabel    : ( NSString*  ) pLabel
                withFrame    : ( CGRect     ) pRect 
                withColors   : ( float*     ) pColors
                withDelegate : ( id         ) pDelegate
    {

		// NSLog( @"ButtonView initWithFrame" );

		expandedRect = pRect;
        originalRect = CGRectInset( pRect , 5 , 5 );

        #ifdef BUILD_TARGET_OSX
        self = [ super initWithFrame : NSRectFromCGRect( originalRect ) ];
        #else
        self = [ super initWithFrame : originalRect ];        
        #endif

		if ( self )
		{
        
            // create

            delegate    = [ pDelegate retain ];
			buttonId    = pButtonId;
			buttonLabel = [ pLabel retain ];
            
            #ifdef BUILD_TARGET_OSX
			[ self setImageScaling	: NSScaleToFit	];
            #else
			[ self setUserInteractionEnabled : YES  ];
            #endif

            float colorA [ ] = { pColors[ 0 ] , 
								 pColors[ 1 ] , 
								 pColors[ 2 ] , 
								 pColors[ 3 ] };
								 
            float colorB [ ] = { pColors[ 4 ] , 
								 pColors[ 5 ] , 
								 pColors[ 6 ] , 
								 pColors[ 7 ] };

            // setup

			[ self setImage   : [ SharedLabelGenerator  generateImage : buttonLabel 
														withColorA	  : colorA
														withColorB	  : colorB
														inRectangle	  : originalRect 
														hasBackground : YES ] ];

		}
        
        return self;
    }
    
    
    // destructor
    
    - ( void ) dealloc 
    {
    
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
		[ [ self animator 					  ] setFrame 	: expandedRect 	];
        
        #else
        
		[ UIView beginAnimations		: @"" 
				 context				: nil ];
		[ UIView setAnimationDuration	: .05 ];
		[ self setFrame : expandedRect ];
		[ UIView commitAnimations ];
        
        #endif

	}


	// shrinks view

	- ( void ) shrink
	{

		// NSLog( @"ButtonView shrink" );

        #ifdef BUILD_TARGET_OSX
        
		[ [ NSAnimationContext currentContext ] setDuration : .05		   ];
		[ [ self animator 					  ] setFrame 	: originalRect ];
        
        #else
        
		[ UIView beginAnimations		: @"" 
				 context				: nil ];
		[ UIView setAnimationDuration	: .05 ];
		[self setFrame : originalRect ];
		[ UIView commitAnimations ];
        
        #endif

	}
    
    // iphone-only touch events
    
   #ifdef BUILD_TARGET_IOS

	// touch start

	- ( void )  touchesBegan : ( NSSet*		) pTouches
                withEvent	 : ( UIEvent*	) pEvent
	{

		// NSLog( @"ButtonView touchesBegan" );
        
        // bring button to front

		[ self.superview bringSubviewToFront : self ];
        
        // animate expansion
        
        [ self expand ];
        
        // notify delegate about press

        NSNumber* idNumber = [ [ NSNumber alloc ] initWithInt: buttonId ];
        
        [ delegate  eventArrived : kSharedButtonViewEventPress
                    fromInstance : self
                    withUserData : idNumber ];
                    
        [ idNumber release ];

	}


	// touch ended

	- ( void )  touchesEnded : ( NSSet*		) pTouches
                withEvent	 : ( UIEvent*	) pEvent
	{

		// NSLog( @"ButtonView touchesEnded" );
        
        // animate shrinking

        [self shrink];
        
        // notify delegate

        NSNumber* idNumber = [ [ NSNumber alloc ] initWithInt: buttonId ];
        
        [ delegate  eventArrived : kSharedButtonViewEventRelease
                    fromInstance : self
                    withUserData : idNumber ];
                    
        [ idNumber release ];
        
        // vibrate phone
        
        // TODO take out sound handling

        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

	}
    
    #endif

    // os x only mouse events

    #ifdef BUILD_TARGET_OSX
    
    // mouse down event

	- ( void ) mouseDown : ( NSEvent* ) pEvent 
	{

		// NSLog( @"ButtonView mouseDown" );

		[ self expand ];

	}


	// mouse up event

	- ( void ) mouseUp	: ( NSEvent* ) pEvent 
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
