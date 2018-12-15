//  SearchViewController.h
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <UIKit/UIKit.h>
	#import "EventDelegate.h"
	#import "StatusView.h"

    
    @interface StatusViewController : UIViewController
    {
    
        id < EventDelegate >    delegate;
        StatusView*             statusView;
		
		NSString*				label;
		BOOL					color;

    }


    - ( id		) initWithDelegate	: ( id			) theDelegate;
	- ( void	) setLabel			: ( NSString*	) theLabel
				  withRed			: ( BOOL		) theRed;


	@end