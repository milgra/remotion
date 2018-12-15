//  MenuViewController.h
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <UIKit/UIKit.h>
	#import "MenuView.h"
	#import "EventDelegate.h"


    @interface MenuViewController : UIViewController
    {
    
        id < EventDelegate > delegate;
        MenuView*            menuView;        

    }


    - ( id	 )	initWithDelegate	: ( id  ) theDelegate;
	- ( void )	setMenuState		: ( int ) theState;


	@end