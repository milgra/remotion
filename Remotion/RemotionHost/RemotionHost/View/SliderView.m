//  SliderView.m
//  Remotion
//
//  Created by Milan Toth on 3/15/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "SliderView.h"


	#define kSliderWidth 80


	@implementation SliderView


	// construct

	- ( id )	initWithFrame	: ( NSRect	) theFrame
				withDelegate	: ( id		) theDelegate
	{
	
		// NSLog( @"SliderView initWithFrame withDelegate" );

		self = [ super initWithFrame : theFrame ];
		
		if ( self ) 
		{
		
			// init
			
			delegate = [ theDelegate retain ];	// needs release

            float colorA [ ] = { .2 , 
								 .2 , 
								 .6 , 
								 1.0 };
								 
            float colorB [ ] = { .2 ,
								 .6 ,
								 1.0 ,
								 1.0 };

            float colorC [ ] = { .9 , 
								 .6 , 
								 .2 , 
								 1.0 };
								 
            float colorD [ ] = { .8 ,
								 .5 ,
								 .1 ,
								 1.0 };
								 
			NSRect backImageRect	= NSMakeRect(	0 , 
													0 , 
													theFrame.size.width , 
													theFrame.size.height );
												
			NSRect sliderImageRect	= NSMakeRect(	0 , 
													0 , 
													kSliderWidth , 
													theFrame.size.height );

			NSRect backRect			= NSMakeRect(	0 , 
													0 , 
													theFrame.size.width , 
													theFrame.size.height );
												
			NSRect sliderRect		= NSMakeRect(	theFrame.size.width / 2 - kSliderWidth / 2 , 
													0 , 
													kSliderWidth , 
													theFrame.size.height );

            // setup

			NSImage* backImage	 = [ LabelGenerator generateImage : @""
													withColorA	  : colorA
													withColorB	  : colorB
													inRectangle   : NSRectToCGRect( backImageRect )
													hasBackground : YES ];		// autorelease

			NSImage* sliderImage = [ LabelGenerator generateImage : @"l r"
													withColorA	  : colorC
													withColorB	  : colorD
													inRectangle   : NSRectToCGRect( sliderImageRect )
													hasBackground : YES ];		// autorelease
											   
			back	= [ [ NSImageView alloc ] initWithFrame : backRect		];	// needs release
			slider	= [ [ NSImageView alloc ] initWithFrame : sliderRect	];	// needs release
			
			// setup
			
			[ back		setImage   : backImage		];
			[ slider	setImage   : sliderImage	];
			
			[ self		addSubview : back	];
			[ self		addSubview : slider	];
			
		}
		
		return self;
		
	}
	
	
	// destructor
	
	- ( void ) dealloc
	{

		// NSLog( @"SliderView dealloc" );
	
		// rollback
		
		[ back		removeFromSuperview ];
		[ slider	removeFromSuperview ];
		
		// release
	
		[ delegate	release ];
		[ back		release ];
		[ slider	release ];
		[ super		dealloc ];
	
	}

    // mouse down event

	- ( void ) mouseDown : ( NSEvent* ) theEvent 
	{

		// NSLog( @"SliderView mouseDown" );
		
		NSPoint local = [ self	convertPoint	: theEvent.locationInWindow 
								fromView		: nil ]; 
								
		[ self updatePosition : local.x ];
		
	}


    // mouse up event, dispatching new value

	- ( void ) mouseUp : ( NSEvent* ) theEvent 
	{

		// NSLog( @"SliderView mouseDown" );
				
		[ delegate	eventArrived : 0 
					fromInstance : self 
					withUserData : &ratio ];
		
	}
	
	
	
	// mouse drag event
	
	- ( void ) mouseDragged : (NSEvent* ) theEvent
	{

		// NSLog( @"SliderView mouseDragged" );
	
		NSPoint local = [ self	convertPoint	: theEvent.locationInWindow 
								fromView		: nil ]; 
								
		[ self updatePosition : local.x ];
	
	}
	
	
	// sets ratio
	
	- ( void ) setRatio : ( double ) theRatio
	{

		// NSLog( @"SliderView setRatio %f" , pRatio );
	
		ratio = theRatio;

		[ self updateSlider ];
	
	}
	
	
	// updates position
	
	- ( void ) updatePosition : ( double ) thePosition
	{
	
		// NSLog( @"SliderView updatePosition %f" , pPosition );

		// check borders
		
		if ( thePosition < kSliderWidth / 2 ) thePosition = kSliderWidth / 2;
		if ( thePosition > self.frame.size.width - kSliderWidth / 2 ) thePosition = self.frame.size.width - kSliderWidth / 2;
		
		// calculate ratio
		
		ratio = ( thePosition - kSliderWidth / 2 ) / ( self.frame.size.width - kSliderWidth );
		
		[ self updateSlider ];
		
	}


	// updates slider
	
	- ( void ) updateSlider
	{

		// NSLog( @"SliderView updateSlider" );

		// update slider
		
		NSRect sliderRect = NSMakeRect( ratio * ( self.frame.size.width - kSliderWidth ) , 
										0 , 
										kSliderWidth , 
										self.frame.size.height );

		[ slider	setFrame	 : sliderRect ];
	
	}

	
	@end
