//
//  RootViewController.h
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <UIKit/UIKit.h>
	#import <MessageUI/MessageUI.h>
	#import <MessageUI/MFMailComposeViewController.h> 

	#import "EventDelegate.h"
	#import "WebViewController.h"
	#import "MenuViewController.h"
	#import "StatusViewController.h"
	#import "MainViewController.h"
	#import "ServicesViewController.h"

	// events

    #define kRootViewControllerEventConnectSelected             0
    #define kRootViewControllerEventFailureSelected             1
    #define kRootViewControllerEventServiceSelected             2
    #define kRootViewControllerEventSendHostSelected            3
    #define kRootViewControllerEventShowInformationSelected     4
    #define kRootViewControllerEventControlButtonPressed		5
    #define kRootViewControllerEventControlButtonReleased		6
    #define kRootViewControllerEventMenuSelected				7
    
    
	#define kRootViewControllerStateMenu						0
	#define kRootViewControllerStateStatus						1
	#define kRootViewControllerStateServices					2
	#define kRootViewControllerStateControl						3
	
	
    @interface RootViewController : UINavigationController < UINavigationControllerDelegate , 
                                                             MFMailComposeViewControllerDelegate >
    {
	
		uint						state;
    
        id < EventDelegate >		delegate;
        NSMutableArray*				waitingList;
    
        WebViewController*			webController;
        MenuViewController*			menuController;
        MainViewController*			controlController;
        StatusViewController*		statusController;
        ServicesViewController*		servicesController;
    
    }
    

    - ( id   ) initWithDelegate		: ( id              ) theDelegate;
	- ( void ) setMenuState			: ( BOOL			) theState;
	- ( void ) setStatusLabel		: ( NSString*		) theLabel
			   withRed				: ( BOOL			) theRed;
    - ( void ) openWebView			: ( NSURLRequest*   ) theContent;
    - ( void ) openMailView			: ( NSData*         ) theContent;
    - ( void ) openListView			: ( NSArray*        ) theArray;
    - ( void ) openMenuView;
    - ( void ) openStatusView;
    - ( void ) openControlView;	
    

@end
