//  ButtonView.h
//  Remotion
//
//  Created by Milan Toth on 2/17/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


    #import "EventDelegate.h"


	#define kSharedButtonViewEventPress		0
	#define kSharedButtonViewEventRelease	1


	#ifdef BUILD_TARGET_OSX

    #import <AppKit/AppKit.h>
    @interface ButtonView : NSImageView
	
	#else

    #import <UIKit/UIKit.h>
    @interface ButtonView : UIImageView
	
	#endif
	{
    
        id < EventDelegate >	delegate;

		int						buttonId;
		NSString*				buttonLabel;

		CGRect					originalRect;
		CGRect					expandedRect;

	}
    

	- ( id )    initWithId   : ( uint       ) theButtonId
                withLabel    : ( NSString*  ) theLabel
                withFrame    : ( CGRect     ) theRect 
                withColors   : ( float*     ) theColors
                withDelegate : ( id         ) theDelegate;
                
    - ( void )  shrink;
    - ( void )  expand;


    @end
