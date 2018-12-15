//  StatusView.h
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <UIKit/UIKit.h>
	#import "ButtonView.h"
	#import "EventDelegate.h"


    @interface StatusView : UIView
    {

		id < EventDelegate >	delegate;
		ButtonView*				buttonView;
    
    }


    - ( id   )  initWithFrame   : ( CGRect		) theFrame 
                withDelegate    : ( id			) theDelegate;
	- ( void )	setLabel		: ( NSString*	) theLabel
				withRed			: ( BOOL		) theRed;


	@end