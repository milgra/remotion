//
//  ZoomButtonView.h
//  GameControl
//
//  Created by Milan Toth on 2/17/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//


    #import "EventDelegate.h"


	#define kSharedButtonViewEventPress		0
	#define kSharedButtonViewEventRelease	1


    #ifdef BUILD_TARGET_OSX
    #import <AppKit/AppKit.h>
    @interface SharedButtonView : NSImageView
    #else
    #import <UIKit/UIKit.h>
    @interface SharedButtonView : UIImageView
    #endif
	{

		int         buttonId;
		NSString* 	buttonLabel;

		CGRect  	originalRect;
		CGRect  	expandedRect;
    
        id < EventDelegate > delegate;

	}
    

	- ( id )    initWithId   : ( uint       ) pButtonId
                withLabel    : ( NSString*  ) pLabel
                withFrame    : ( CGRect     ) pRect 
                withColors   : ( float*     ) pColors
                withDelegate : ( id         ) pDelegate;
                
    - ( void )  shrink;
    - ( void )  expand;

    @end
