//  MainViewController.h
//  Remotion
//
//  Created by Milan Toth on 3/1/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Cocoa/Cocoa.h>
	#import "FlippedView.h"
	#import "EventDelegate.h"
	#import "ControlView.h"
	#import "SliderView.h"


	#define kMainViewControllerEventSensitivity 0


	@interface MainViewController : NSViewController < EventDelegate >
	{

		ControlView*			controlView;
		FlippedView*			baseView;
		SliderView*				sliderView;
		ButtonView*				welcomeView;
		
		id < EventDelegate >	delegate;
		
	}


	- ( id	 ) initWithDelegate : ( id	   ) theDelegate;	
	- ( void ) setSensitivity	: ( double ) theSensitivity;
	
	- ( void ) expandButton		: ( uint   ) theId;
	- ( void ) shrinkButton		: ( uint   ) theId;
	
	- ( void ) showWelcome;
	- ( void ) showControl;

	
	@end
