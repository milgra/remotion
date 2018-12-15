//  SliderView.h
//  Remotion
//
//  Created by Milan Toth on 3/15/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Cocoa/Cocoa.h>
	#import "EventDelegate.h"
	#import "LabelGenerator.h"


	@interface SliderView : NSView
	{
	
		id < EventDelegate >	delegate;
		double					ratio;
		
		NSImageView*			back;
		NSImageView*			slider;

	}


	- ( id	 )	initWithFrame	: ( NSRect  ) theRect
				withDelegate	: ( id		) theDelegate;
	- ( void )	setRatio		: ( double	) theRatio;
	

	@end
