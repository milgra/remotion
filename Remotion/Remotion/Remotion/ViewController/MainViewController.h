//  MainViewController.h
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <UIKit/UIKit.h>
	#import "ControlView.h"


    @interface MainViewController : UIViewController
    {
    
        id < EventDelegate >    delegate;
        ControlView*			controlView;
            
    }


    - ( id ) initWithDelegate : ( id ) theDelegate;


	@end
