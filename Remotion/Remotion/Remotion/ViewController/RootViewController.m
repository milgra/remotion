//  RootViewController.m
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "RootViewController.h"


	@implementation RootViewController


    // constructor

    - ( id ) initWithDelegate : ( id ) theDelegate
    {
    
        // NSLog( @"RootViewController initWithDelegate %@" , pDelegate );
		
		// init
        
		delegate			= [ theDelegate retain ];        
		waitingList			= [ [ NSMutableArray		  alloc ] init ];					  // needs release
        menuController		= [ [ MenuViewController	  alloc ] initWithDelegate : self ];  // needs release
		webController       = [ [ WebViewController       alloc ] initWithDelegate : self ];  // needs release
		statusController    = [ [ StatusViewController    alloc ] initWithDelegate : self ];  // needs release
		controlController   = [ [ MainViewController      alloc ] initWithDelegate : self ];  // needs release
		servicesController  = [ [ ServicesViewController  alloc ] initWithDelegate : self ];  // needs release

        self = [ super initWithRootViewController : menuController ];
        
        if ( self ) 
        {
		
			// setup
			
			state = kRootViewControllerStateMenu;

            [ self setNavigationBarHidden		 : YES];
            [ self setDelegate					 : self ];
			[ [ self navigationBar ] setBarStyle : UIBarStyleBlackOpaque ];
            
        }
        else
        {
        
            // rollback
        
			[ delegate				release ];
			[ waitingList			release ];
			[ webController			release ];
			[ menuController		release ];
			[ statusController		release ];
			[ controlController		release ];
			[ servicesController	release ];
        
        }
        
        return self;
        
    }
    
    
    // destructor
    
    - ( void ) dealloc
    {
    
        // NSLog( @"RootViewController dealloc" );
		
		// rollback
		
		[ self setDelegate : nil ];
		
		// release
        
        [ delegate				release ];
        [ waitingList			release ];
        [ webController			release ];
        [ menuController		release ];
        [ statusController		release ];
        [ controlController		release ];
        [ servicesController	release ];
    
        [ super					dealloc ];
    
    }

    
    // navigation start event
    
    - ( void )  navigationController    : ( UINavigationController* ) theNavigationController 
                willShowViewController  : ( UIViewController*       ) theController 
                animated                : ( BOOL                    ) theAnimated
    {
	
		// NSLog( @"RootViewController navigationController willShowViewController animated" );
    
        if ( theController != webController ) [ self setNavigationBarHidden : YES animated : YES ];
        else [ self setNavigationBarHidden : NO animated : YES ];
    
    }


    // navigation end event
    
    - ( void )  navigationController    : ( UINavigationController* ) theNavigationController 
                didShowViewController   : ( UIViewController*       ) theController 
                animated                : ( BOOL                    ) theAnimated
    {

		// NSLog( @"RootViewController navigationController didShowViewController %@ animated" , pController );
		
        if ( [ waitingList count ] > 0 ) [ waitingList removeObjectAtIndex : 0 ];
        if ( [ waitingList count ] > 0 ) [ super pushViewController : [ waitingList objectAtIndex : 0 ] animated : YES ];
            
    }
	
	
	// push view controller override
    
    - ( void )  pushViewController  : ( UIViewController* ) theController 
                animated            : ( BOOL              ) theAnimated
    {
	
		// NSLog( @"RootViewController pushViewController %@ animated %i " , pController , pAnimated );
	
		// avoiding multiple pushes while animating
		
		if ( ![ waitingList containsObject : theController ] )
		{
    
			[ waitingList addObject : theController ];
			
			if ( [ waitingList count ] == 1 )
			{

				if ( [ [ self viewControllers ] containsObject : theController ] )
				{
					[ super	popToViewController : theController 
							animated			: YES ];
				}
				else 
				{
					[ super pushViewController	: [ waitingList objectAtIndex : 0 ] 
							animated			: YES ];
				}
				
			}
			
		}
    
    }


	// sets first start view state in menu view controller

	- ( void ) setMenuState : ( BOOL ) theState
	{

		// NSLog( @"RootViewController setMenuState %i" , pState );
	
		[ menuController setMenuState : theState ];
	
	}


	// sets first start view state in menu view controller

	- ( void ) setStatusLabel : ( NSString* ) theLabel
			   withRed		  : ( BOOL		) theRed;
	{

		// NSLog( @"RootViewController setStatusLabel %@" , pLabel );
		
		[ statusController	setLabel	: theLabel 
							withRed		: theRed ];
	
	}
    
    
    // opens a web view with content
    
    - ( void ) openWebView : ( NSURLRequest* ) theRequest
    {
    
        // NSLog( @"RootViewController openWebView %@" , pRequest );
    
        if ( ! [ NSThread isMainThread ] )
        {
        
            [ self performSelectorOnMainThread   : @selector(openWebView) 
                   withObject                    : nil 
                   waitUntilDone                 : NO];
                   
            return;
            
        }
        
        [ webController loadUrlRequest		: theRequest ];
        [ self			pushViewController	: webController 
						animated			: YES ];
    
    }


    // opens mail view
    
    - ( void ) openMailView  : ( NSData* ) theContent
    {
	
		// NSLog( @"RootViewController openMailView %i" , [ MFMailComposeViewController canSendMail ] );
		
		if ( [ MFMailComposeViewController canSendMail ] )
		{
                
			MFMailComposeViewController *composer = [ [ MFMailComposeViewController alloc ] init ];
			
			NSString* subjectA	= @"Remotion host application";        
			NSString* bodyA		= @"This is the host application for Remotion for OS X Lion and Snow Leopard. Save the attachment to your desktop, double click on it to open the disk image, drag and drop RemotionHost.app on Applications folder and launch it. It immediately starts listening for connection from your iphone.";
			
			[ composer setMailComposeDelegate		: self ];
			[ composer setSubject					: subjectA ];
			[ composer setMessageBody				: bodyA
					   isHTML						: NO ];
			[ composer addAttachmentData			: theContent 
					   mimeType						: @"application/octet-stream" 
					   fileName						: @"RemotionHost.dmg" ];

			[ self	   presentModalViewController  : composer 
					   animated                    : YES ];

			[ composer release ];
		
		}
		else 
		{
		
			[ menuController	setMenuState	: 1 ];
			[self				setStatusLabel	: @"MAIL NOT AVAILABLE" 
								withRed			: YES ];
			[self				openStatusView ];

		}
    
    }    
    
	
    // mail compose finished event
    
    - ( void )  mailComposeController   : ( MFMailComposeViewController* ) theController 
                didFinishWithResult     : ( MFMailComposeResult          ) theResult 
                error                   : ( NSError*                     ) theError 
    {

		// NSLog( @"RootViewController mailComposeController didFinishWithResult error" );

        [ theController		dismissModalViewControllerAnimated : YES ];		
		[ menuController	setMenuState : 1 ];

    }



    // opens list view
    
    - ( void ) openListView : ( NSArray* ) theArray 
    {
    
        // NSLog( @"RootViewController openListView" );
    
		if ( ! [ NSThread isMainThread ] )
		{
		
			[ self performSelectorOnMainThread   : @selector(openListView) 
				   withObject                    : theArray 
				   waitUntilDone                 : NO];
				   
			return;
			
		}
		
		if ( state != kRootViewControllerStateServices )
		{
		
			state = kRootViewControllerStateServices;

			[ self	pushViewController	: servicesController 
					animated			: YES ];
					
			[ servicesController setDataList : theArray ];
			
		}
            
    }
    
    
    // opens menu view
    
    - ( void ) openMenuView
    {

		// NSLog( @"RootViewController openMenuView" );
				
		if ( ! [ NSThread isMainThread ] )
		{
		
			[ self performSelectorOnMainThread   : @selector(openMenuView) 
				   withObject                    : nil 
				   waitUntilDone                 : NO];
				   
			return;

		}

		if ( state != kRootViewControllerStateMenu )
		{
		
			state = kRootViewControllerStateMenu;

			[ self popToRootViewControllerAnimated : YES ];
			
		}
    
    }


    // sets connecting view state

    - ( void ) openStatusView 
    {

        // NSLog( @"RootViewController openStatusView" );
		
		if ( ! [ NSThread isMainThread ] )
		{
		
			[ self performSelectorOnMainThread   : @selector(openStatusView) 
				   withObject                    : nil 
				   waitUntilDone                 : NO];
				   
			return;
			
		}

		if ( state != kRootViewControllerStateStatus )
		{
		
			state = kRootViewControllerStateStatus;
			
			[ self	pushViewController	: statusController 
					animated			: YES ];
					
		}
    
    }
    
    
    // opens main view
    
    - ( void ) openControlView
    {

        // NSLog( @"RootViewController openControlView" );
		
		if ( ! [ NSThread isMainThread ] )
		{
		
			[ self performSelectorOnMainThread   : @selector(openControlView) 
				   withObject                    : nil 
				   waitUntilDone                 : NO];
				   
			return;
			
		}

		if ( state != kRootViewControllerStateControl )
		{
		
			state = kRootViewControllerStateControl;
		
			[ self	pushViewController	: controlController 
					animated			: YES ];
					
		}

    }
    
    
    // event arrived from sub view controllers
    
    - ( void )  eventArrived : ( uint  ) theId
                fromInstance : ( void* ) theInstance
                withUserData : ( void* ) theUserData
    {
    
        // NSLog( @"RootViewController eventArrived %u %@" , pId , [ ( UIView* ) pInstance superview ] );
    
        if ( [ ( UIView* ) theInstance superview ] == [ menuController view ] )
        {

            if ( theId == kSharedButtonViewEventRelease )
            {            
                int buttonId = *( ( int* ) theUserData );
                
                switch ( buttonId )
                {
                
                    case 0 : 
                    {
                                   
                        [ delegate  eventArrived    : kRootViewControllerEventConnectSelected 
                                    fromInstance    : self 
                                    withUserData    : nil ];
                        break;
                    }                
                    case 1 : 
                    {
                                   
                        [ delegate  eventArrived    : kRootViewControllerEventSendHostSelected 
                                    fromInstance    : self 
                                    withUserData    : nil ];
                        break;
                    }
                    case 2 :
                    {
                                   
                        [ delegate  eventArrived    : kRootViewControllerEventShowInformationSelected
                                    fromInstance    : self 
                                    withUserData    : nil ];
                        break;
                    }
                
                }
                
            }
        
        }
        else 
        if ( [ ( UIView* ) theInstance superview ] == [ controlController view ] )
        {
        
            if ( theId == kSharedButtonViewEventPress )
            {            

                [ delegate  eventArrived    : kRootViewControllerEventControlButtonPressed 
                            fromInstance    : self 
                            withUserData    : theUserData ];
            
            }
            else 
            {

                [ delegate  eventArrived    : kRootViewControllerEventControlButtonReleased
                            fromInstance    : self 
                            withUserData    : theUserData ];

            }

        }
        else 
        if ( [ ( UIView* ) theInstance superview ] == [ statusController view ] )
        {

            if ( theId == kSharedButtonViewEventRelease )
            {            
		
				[ delegate  eventArrived    : kRootViewControllerEventMenuSelected
							fromInstance    : self 
							withUserData    : theUserData ];

			}
        
        }
        else 
        if ( ( UIView* ) theInstance == [ servicesController view ] )
        {

            if ( theId == kServicesViewControllerEventSelect )
            {            
		
				[ delegate  eventArrived    : kRootViewControllerEventServiceSelected
							fromInstance    : self 
							withUserData    : theUserData ];
							
			}
        
        }
    
    }
    
    
	@end
