//  Delegate.m
//  Remotion
//
//  Created by Milan Toth on 1/28/11.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "Delegate.h"


	@implementation Delegate


	// application entering point

	- ( void ) applicationDidFinishLaunching : ( UIApplication* ) theApplication 
	{

		// NSLog( @"Delegate applicationDidFinishLaunching" );
		
		// init
        
        CGRect screenFrame   = [ [ UIScreen mainScreen ] bounds ];

		mainWindow           = [ [ UIWindow             alloc ] initWithFrame	 : screenFrame ];       // needs release
        connection           = [ [ UdpClient			alloc ] initWithDelegate : self ];              // needs release
        motionHandler        = [ [ MotionHandler        alloc ] initWithDelegate : self ];              // needs release
        bonjourBrowser       = [ [ BonjourBrowser       alloc ] initWithDelegate : self ];              // needs release
        rootViewController   = [ [ RootViewController   alloc ] initWithDelegate : self ];              // needs release

		stateHandler		 = [ [ StateHandler			alloc ] initWithConnection		: connection    // needs release
																withMotionHandler		: motionHandler 
																withBonjourBrowser		: bonjourBrowser 
																withRootViewController	: rootViewController ];

		// setup window

		[ mainWindow makeKeyAndVisible                          ];
        [ mainWindow setRootViewController : rootViewController ];

		[ [ UIApplication sharedApplication ] setStatusBarHidden   : YES ];
		[ [ UIApplication sharedApplication ] setIdleTimerDisabled : NO  ];
		
		// prepare socket for faster connection before startup
		
		[ connection prepareSocket ];

	}
    

	// destructor

	- ( void ) 
	dealloc
	{

		// NSLog( @"Delegate dealloc" );
		
		// rollback
		
        [ mainWindow setRootViewController : nil ];
		
		// release

		[ mainWindow			release ];
		[ connection			release ];
        [ motionHandler         release ];
        [ bonjourBrowser        release ];
        [ rootViewController    release ];
		[ stateHandler			release ];
        
		[ super					dealloc ];

	}
    
    
    // application background event, disconnect from host application
    
    - ( void ) applicationDidEnterBackground : ( UIApplication* ) theApplication
    {
	
		// NSLog( @"Delegate applicationDidEnterBackground" );
		
		[ stateHandler switchToMenuState ];
    
    }
	
	
	// application foreground event
	
	- ( void ) applicationDidBecomeActive : ( UIApplication* ) theApplication
	{
	
		// NSLog( @"Delegate applicationDidBecomeActive" );
	
		[ connection prepareSocket ];
	
	}


    // control event HUB
    
    - ( void )  eventArrived : ( uint  ) theId
                fromInstance : ( void* ) theInstance
                withUserData : ( void* ) theUserData
    {
    
        // NSLog( @"Delegate eventArrived %u fromInstance %@ withUserData" , pId , pInstance );
        
        if ( theInstance == motionHandler      ) [ self motionHandlerEvent  : theId withUserData : theUserData ]; else 
        if ( theInstance == connection         ) [ self connectionEvent     : theId withUserData : theUserData ]; else 
        if ( theInstance == bonjourBrowser     ) [ self bonjourEvent		: theId withUserData : theUserData ]; else
        if ( theInstance == rootViewController ) [ self viewEvent			: theId withUserData : theUserData ];
    
    }
    
    
    // event from bonjour handler
    
    - ( void ) bonjourEvent : ( uint  ) theId
               withUserData : ( void* ) theUserData
    {

		// NSLog( @"Delegate bonjourEvent %u withUserData" , pId );
    
        switch ( theId ) 
        {
        
            case kBonjourBrowserSearchSuccess : 
            {
                
                // service list arrived, showing up in view
				
				[ stateHandler setServices : ( NSMutableArray* ) theUserData ];
            
                if ( [ [ stateHandler services ] count ] > 1 )
				{
					
					[ stateHandler switchToSelectingState ];
					
				}
                else 
				{
				
					[ stateHandler setSelectedService : [ [ stateHandler services ] objectAtIndex : 0 ] ];
					[ stateHandler switchToResolvingState ];
				
				}
                
                break;
            
            }
            case kBonjourBrowserResolveSuccess :
            {

                // resolve success, connecting to host application
				
				[ stateHandler setServiceAddresses : ( NSMutableArray* ) theUserData ];
				[ stateHandler switchToConnectingState ];
                    
                break;
                
            }
            case kBonjourBrowserSearchFailure	: [ stateHandler switchToNoHostState ]; break;
            case kBonjourBrowserResolveFailure	: [ stateHandler switchToNoHostState ]; break;
        
        }
    
    }
	    
    
    // event from connection handler
    
    - ( void ) connectionEvent : ( uint  ) theId
               withUserData    : ( void* ) theUserData
    {

		// NSLog( @"Delegate connectionEvent %u withUserData" , pId );
    
        switch ( theId ) 
        {

            case kConnectionSuccess		: [ stateHandler switchToConnectedState		]; break;
            case kConnectionTimeout		: [ stateHandler switchToConnectingState	]; break;
            case kConnectionDisconnect	: [ stateHandler switchToDisconnectedState	]; break;
        
        }
    
    }

    
    // event from root view controller
    
    - ( void )  viewEvent	  : ( uint  ) theId
                withUserData  : ( void* ) theUserData
    {

		// NSLog( @"Delegate viewEvent %u withUserData" , pId );
    
        switch ( theId ) 
        {
        
            case kRootViewControllerEventConnectSelected : [ stateHandler switchToBrowsingState ]; break;
            case kRootViewControllerEventMenuSelected	 : [ stateHandler switchToMenuState		]; break;
            case kRootViewControllerEventServiceSelected :
            {
            
                // service selected in service list, trying to resolve service, showing connecting view
				
				[ stateHandler setSelectedService : ( NSNetService* ) theUserData ];
				[ stateHandler switchToResolvingState ];

                break;
                
            }
            case kRootViewControllerEventSendHostSelected :
            {

                // opening mail composer, attaching host application from bundle

                NSString*   hostPath    = [ [ NSBundle	mainBundle ] pathForResource : @"RemotionHost" 
																	 ofType          : @"dmg" ];		 // autorelease
                NSData*     sourceData  = [ [ NSData	alloc	   ] initWithContentsOfFile : hostPath ]; // needs release
                
                [ rootViewController openMailView : sourceData ];
                
                [ sourceData release ];
				
                break;
                
            }
            case kRootViewControllerEventShowInformationSelected :
            {
                // opening webview with tutorial pdf
                
                NSString*       pdfPath = [ [ NSBundle mainBundle ] pathForResource : @"Information" 
                                                                    ofType          : @"pdf" ];         // autorelease
                NSURL*          url     = [ [ NSURL         alloc ] initFileURLWithPath : pdfPath ];    // needs release
                NSURLRequest*   request = [ [ NSURLRequest  alloc ] initWithURL : url ];                // needs release
                
                [ rootViewController openWebView : request ];
                
                [ request   release ];
                [ url       release ];
                
                break;

            }
            case kRootViewControllerEventControlButtonPressed :
            {
			
				// button pressed in controler view
            
                char data[ kProtocolPacketSize ];
                
                data[ 0 ] = ( char ) kProtocolTypeButton;
                data[ 1 ] = ( char ) * ( int* ) theUserData;
                data[ 2 ] = ( char ) kProtocolButtonStateDown;
                
                [ connection send : data ];

                break;
            
            }
            case kRootViewControllerEventControlButtonReleased :
            {
			
				// button released in control view
            
                char data[ kProtocolPacketSize ];
                
                data[ 0 ] = ( char ) kProtocolTypeButton;
                data[ 1 ] = ( char ) * ( int* ) theUserData;
                data[ 2 ] = ( char ) kProtocolButtonStateUp;
                
                [ connection send : data ];

                break;
            
            }
            
        }
        
    }
		    
    
    // event from motion handler
    
    - ( void ) motionHandlerEvent   : ( uint  ) theId
               withUserData         : ( void* ) theUserData
    {
	
		// NSLog( @"Delegate motionHandlerEvent %u withUserData" , pId );

        switch ( theId ) 
        {

            case kMotionHandlerRotationEvent :
            {
            
                // rotation event came, sending to host application
				
				char packet[ kProtocolPacketSize ];
				
				packet[ 0 ] = kProtocolTypeRotation;
				
				memcpy( packet + 1 , theUserData , 24 );
            
                [ connection send : packet ];
				
                break;
            
            }

        }
    
    }
	
    
	@end
