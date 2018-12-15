//  ControlView.h
//  Remotion
//
//  Created by Milan Toth on 2/17/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "Protocol.h"
	#import "ButtonView.h"


    #define kSharedMainViewEvent    0


    #ifdef BUILD_TARGET_OSX    
    #import <AppKit/AppKit.h>
    @interface ControlView : NSView
    #else
    #import <UIKit/UIKit.h>
    @interface ControlView : UIView
    #endif
    {
    
        id < EventDelegate >      delegate;
    
		ButtonView*         buttonA;
		ButtonView*         buttonB;

		ButtonView*         buttonC;
		ButtonView*         buttonD;
		ButtonView*         buttonE;

		ButtonView*         buttonF;
		ButtonView*         buttonG;
		ButtonView*         buttonH;

		ButtonView*         buttonI;
		ButtonView*         buttonJ;
		ButtonView*         buttonK;
		ButtonView*         buttonL;

		ButtonView*         buttonM;
		ButtonView*         buttonN;
		ButtonView*         buttonO;
		ButtonView*         buttonP;
    
    }


    - ( id   ) initWithFrame : ( CGRect   ) theFrame
               withDelegate  : ( id       ) theDelegate;

	- ( void ) expandButton : ( NSNumber* ) theId;
	- ( void ) shrinkButton : ( NSNumber* ) theId;


	@end
