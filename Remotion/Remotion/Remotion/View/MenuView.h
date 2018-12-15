//  MenuView.h
//  Remotion
//
//  Created by Milan Toth on 2/18/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <UIKit/UIKit.h>
	#import "EventDelegate.h"
	#import "ButtonView.h"


    @interface MenuView : UIView
    {
    
        id < EventDelegate >	delegate;
		int						menuState;
    
        ButtonView* buttonA;
        ButtonView* buttonB;
        ButtonView* buttonC;
    
    }


    - ( id )    initWithFrame		: ( CGRect  ) theFrame 
                withDelegate		: ( id      ) theDelegate;
	- ( void )	setMenuState		: ( int		) theState;
    

	@end