//
//  UniMainView.h
//  GameControl
//
//  Created by Milan Toth on 2/17/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//

#import "Protocol.h"
#import "SharedButtonView.h"


    #define kSharedMainViewEvent    0


    #ifdef BUILD_TARGET_OSX    
    #import <AppKit/AppKit.h>
    @interface SharedMainView : NSView
    #else
    #import <UIKit/UIKit.h>
    @interface SharedMainView : UIView
    #endif
    {
    
        id < EventDelegate >      delegate;
    
		SharedButtonView*         buttonA;
		SharedButtonView*         buttonB;

		SharedButtonView*         buttonC;
		SharedButtonView*         buttonD;
		SharedButtonView*         buttonE;

		SharedButtonView*         buttonF;
		SharedButtonView*         buttonG;
		SharedButtonView*         buttonH;

		SharedButtonView*         buttonI;
		SharedButtonView*         buttonJ;
		SharedButtonView*         buttonK;
		SharedButtonView*         buttonL;

		SharedButtonView*         buttonM;
		SharedButtonView*         buttonN;
		SharedButtonView*         buttonO;
		SharedButtonView*         buttonP;
    
    }


    - ( id   ) initWithFrame : ( CGRect ) pFrame
               withDelegate  : ( id     ) pDelegate;

	- ( void ) expandButton : ( uint ) pId;
	- ( void ) shrinkButton : ( uint ) pId;
    
@end
