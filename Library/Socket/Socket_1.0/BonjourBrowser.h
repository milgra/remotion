//  BonjourBrowser.h
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import "EventDelegate.h"


    #define kBonjourBrowserSearchSuccess    0
    #define kBonjourBrowserSearchFailure    1
    #define kBonjourBrowserResolveSuccess   2
    #define kBonjourBrowserResolveFailure   3


    @interface BonjourBrowser : NSObject <	NSNetServiceDelegate , 
											NSNetServiceBrowserDelegate >
    {
    
        id < EventDelegate >    delegate;
		
		BOOL					active;
		NSTimer*				timer;
        NSNetServiceBrowser*    browser;
        NSMutableArray*         servers;
        NSMutableArray*     	addresses;

    }


    - ( id   ) initWithDelegate : ( id			  ) theDelegate;
    - ( void ) resolve			: ( NSNetService* ) theService;
    - ( void ) search;
	- ( void ) stop;


	@end
