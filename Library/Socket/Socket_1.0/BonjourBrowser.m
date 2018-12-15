//  BonjourBrowser.m
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "BonjourBrowser.h"


	@implementation BonjourBrowser


    // constructor

    - ( id ) initWithDelegate : ( id ) theDelegate
    {
    
        // NSLog( @"BonjourBrowser initWithDelegate %@" , pDelegate );
    
        self = [ super init ];
        
        if ( self )
        {
		
			// init

			timer		= nil;
			active		= NO;        
            delegate    = [ theDelegate retain ];						// needs release
			browser     = [ [ NSNetServiceBrowser   alloc ] init ];		// needs release
            servers     = [ [ NSMutableArray        alloc ] init ];		// needs release
            addresses   = [ [ NSMutableArray        alloc ] init ];		// needs release
            
            // setup

			[ browser setDelegate : self ];
        
        }
    
        return self;
    
    }
    
    
    // destructor
    
    - ( void ) dealloc
    {
                
        // NSLog( @"BonjourBrowser dealloc" );
		
		// roolback
		
		[ self			stopTimeout ];

        [ browser		setDelegate : nil ];
        [ browser		stop              ];
		
		// destruct
        
        [ delegate      release ];
        [ browser       release ];
        [ servers       release ];
        [ addresses     release ];

        [ super			dealloc ];
    
    }
	
	
	// start service browsing timeout
	
	- ( void ) startTimeout
	{
	
		// NSLog( @"BonjourBrowser startTimeout" );
	
		[ self stopTimeout ];
	
		timer = [ NSTimer	scheduledTimerWithTimeInterval	: 4.0 
							target							: self 
							selector						: @selector(timeout) 
							userInfo						: nil 
							repeats							: NO ];
	
	}
	
	
	// stop timeout
	
	- ( void ) stopTimeout
	{

		// NSLog( @"BonjourBrowser stopTimeout" );
	
		if ( timer != nil ) [ timer invalidate ];

		timer = nil;
	
	}
	
	
	// timeout, stop browsing, dispatch error
	
	- ( void ) timeout
	{

		// NSLog( @"BonjourBrowser timeout" );

		timer = nil;
		
		if ( active )
		{
		
			[ delegate  eventArrived : kBonjourBrowserSearchFailure
						fromInstance : self
						withUserData : servers ];		
		
		}
		
	}

    
    // initiate search
    
    - ( void ) search
    {

        // NSLog( @"BonjourBrowser search" );
		
		if ( !active )
		{
		
			active = YES;
		
			[ self	  startTimeout ];            
			[ servers removeAllObjects ];
			[ browser searchForServicesOfType : @"_gamecontrol._udp." 
					  inDomain                : @"" ];
					  
		}
        
    }
    
	
	// resets search and services
	
	- ( void ) stop
	{
	
        // NSLog( @"BonjourBrowser reset" );
		
		if ( active )
		{
		
			active = NO;
		
			[ browser stop ];
			[ servers removeAllObjects ];
		
		}
	
	}

    
    // netservice was found
    
    - ( void )  netServiceBrowser   : ( NSNetServiceBrowser* ) theBrowser 
                didFindService      : ( NSNetService*        ) theService 
                moreComing          : ( BOOL                 ) theHasMore
    {
    
        // NSLog( @"BonjourBrowser netServiceBrowser : %@ didFindService %@ moreComing : %i" , pBrowser , pService , pHasMore );

		if ( active )
		{
			
			[ self stopTimeout ];
		
			if ( ![ servers containsObject : theService ] ) [ servers addObject : theService ];
			
			if ( !theHasMore )
			{
			
				[ delegate  eventArrived : kBonjourBrowserSearchSuccess
							fromInstance : self
							withUserData : servers ];
				
				// stop listening for services
				
				[ browser stop ];

			}
			
		}

    }
    
    
    // netservice disappeared
    
    - ( void )  netServiceBrowser   : ( NSNetServiceBrowser* ) theBrowser 
                didRemoveService    : ( NSNetService*        ) theService 
                moreComing          : ( BOOL                 ) theHasMore 
    {
    
        // NSLog( @"BonjourBrowser netServiceBrowser didRemoveService" );
		
		if ( active )
		{

			[ servers removeObject : theService ];

			if ( !theHasMore )
			{
			
				[ delegate  eventArrived : kBonjourBrowserSearchSuccess
							fromInstance : self
							withUserData : servers ];
			
			}
			
		}

    }


    // search stopped

    - ( void ) netServiceBrowserDidStopSearch : ( NSNetServiceBrowser* ) theBrowser
    {
    
        // NSLog( @"BonjourBrowser netServiceBrowser didStopSearch" );
    
    }


    // search error
    
    - ( void )  netServiceBrowser   : ( NSNetServiceBrowser* ) theBrowser 
                didNotSearch        : ( NSDictionary*        ) theErrorMap
    {

        // NSLog( @"BonjourBrowser netServiceBrowser : %@ didNotSearch %@" , pBrowser , pErrorMap );

		if ( active )
		{
		 
			[ delegate  eventArrived : kBonjourBrowserSearchFailure
						fromInstance : self
						withUserData : servers ];
						
		}
       
    }

    
    // service selected in status view, resolving address
    
    - ( void ) resolve : ( NSNetService* ) theService
    {
    
        // NSLog( @"BonjourBrowser resolve : %@" , pService );

		if ( active )
		{
		
			[ theService   setDelegate         : self ];
			[ theService   resolveWithTimeout  : 1.0  ];
			
		}
    
    }
    
    
    // addresss was resolved

    - ( void ) netServiceDidResolveAddress : ( NSNetService* ) theSender
    {
          
        // NSLog( @"BonjourBrowser netServiceDidResolveAddress %@" , pSender );

		if ( active )
		{
			
			[ addresses removeAllObjects ];
			[ addresses addObjectsFromArray : [ theSender addresses ] ];

			[ delegate  eventArrived : kBonjourBrowserResolveSuccess
						fromInstance : self
						withUserData : addresses ];
						
		}
        
    }
    
    
    // couldn't resolve address

    - ( void )  netService      : ( NSNetService* ) theSender 
                didNotResolve   : ( NSDictionary* ) theErrorMap
    {
    
        // NSLog( @"BonjourBrowser netService didNotResolveAddress %@" , pSender );
		
		if ( active )
		{

			[ delegate  eventArrived : kBonjourBrowserResolveFailure
						fromInstance : self
						withUserData : nil ];
						
		}
   
    }

    
	@end
