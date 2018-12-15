//  WebViewController.h
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <UIKit/UIKit.h>
	#import "EventDelegate.h"


    @interface WebViewController : UIViewController
    {

		NSURLRequest*			request;
        UIWebView*              webView;
        id < EventDelegate >    delegate;

    }


    - ( id   ) initWithDelegate : ( id              ) theDelegate;
    - ( void ) loadUrlRequest   : ( NSURLRequest*   ) theRequest;


	@end