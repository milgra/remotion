//  UdpHost.m
//  Remotion
//
//  Created by Milan Toth on 3/1/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "UdpHost.h"


	@implementation UdpHost


	// constructor

	- ( id ) initWithDelegate : ( id ) theDelegate;
	{
	
		// NSLog( @"UdpHost init" );
	
		self = [ super init ];
		
		if ( self )
		{
		
			delegate = [ theDelegate retain ];							// needs release
			socket	 = [ [ UdpSocket alloc ] initWithFamily	: AF_INET6 
											 withDelegate	: self ];	// needs release
			
			if ( socket ) [ socket listenWithPacketSize : kProtocolPacketSize ];
		
		}
		
		return self;
	
	}
	
	
	// destructor
	
	- ( void ) dealloc
	{

		// NSLog( @"UdpHost dealloc" );
	
		[ delegate	release ];
		[ socket	release ];
		[ super		dealloc ];
	
	}


    // starts checking last incoming keepalive request delay
    
    - ( void ) startCheckingPing
    {
    
        // NSLog( @"UdpHost startCheckingPing" );
    
        [ self stopCheckingPing ];
        
        checkTimer = [ NSTimer	scheduledTimerWithTimeInterval : kProtocolPingDelay
								target                         : self 
                                selector                       : @selector(checkPing) 
                                userInfo                       : nil 
                                repeats                        : YES   ];

		// notify delegate
                        
		[ delegate  eventArrived : kUdpHostConnectionSuccess 
					fromInstance : self 
					withUserData : nil ];
    
    }


    // stops keepalive if needed
    
    - ( void ) stopCheckingPing
    {

        // NSLog( @"UdpHost stopCheckingPing" );

        if ( checkTimer != nil ) 
		{
		
			[ checkTimer invalidate ];
			checkTimer = nil;
			
		}
    
    }
    
    
    // check arrival of last request
    // disconnect if timeout
    
    - ( void ) checkPing
    {
    
        // NSLog( @"UdpHost checkPing" );
    
        long duration = ( long )[ [ NSDate date ] timeIntervalSince1970 ] - ( long ) lastPing;
        
        if ( duration > kProtocolTimeOut )
        {
                
			[ delegate  eventArrived : kUdpHostConnectionClosure 
						fromInstance : self 
						withUserData : nil ];

            [ self stopCheckingPing ];

            connected = NO;
        
        }

    }
    
    
    // sends keepalive response

    - ( void ) sendPong
    {
    
        // NSLog( @"UdpHost sendPong" );

		char packet[ kProtocolPacketSize ];

		packet[ 0 ] = kProtocolTypePong;
        
        [ socket    sendBytes : packet 
                    withSize  : kProtocolPacketSize 
                    toAddress : address ];

    }
	
	

	// data arrived from socket

    - ( void )  dataArrived : ( char* ) pData
                fromAddress : ( struct sockaddr_storage ) pAddress
                withLength  : ( socklen_t ) pLength 
	{

        // NSLog( @"UdpHost dataArrived %i %i %i" , pData[0] , pData[1] , pData[2] );
	
		switch ( pData[ 0 ] ) 
        {
        
            case kProtocolTypePing :
            {

				if ( !connected )
				{
				
					// if not connected, first ping packet is connection request
					// we accept the connection anyway
					// we don't start pinging
					// we only check last ping request delay
					
					// converts v4 address to v6 if needed
					
					[ AddressUtilities  convertAddress  : &pAddress 
										toAddress       : &address
										toFamily        : AF_INET6 ];

					connected = YES;
					
					// start check timer
					
					[ self	performSelectorOnMainThread : @selector(startCheckingPing) 
							withObject					: nil 
							waitUntilDone				: NO ];
							
				}
                        
				lastPing = ( long ) [ [ NSDate date ] timeIntervalSince1970 ];
				
				[ self sendPong ];
				
				break;
                
            }
			case kProtocolTypeDisconnect :
			{
			
				[ delegate  eventArrived : kUdpHostConnectionClosure 
							fromInstance : self 
							withUserData : nil ];

				[ self stopCheckingPing ];

				connected = NO;

				break;

			}            
            case kProtocolTypeButton :
            {
                        
				[ delegate  eventArrived : kUdpHostButtonData
							fromInstance : self 
							withUserData : pData + 1 ];
            
				break;

            }
            case kProtocolTypeRotation :
            {
            
				[ delegate  eventArrived : kUdpHostRotationData 
							fromInstance : self 
							withUserData : pData + 1 ];

				break;
            
            }
			
		}

	}
	
	
	// socket read error
	
    - ( void )  readError
	{
	 
		// NSLog( @"UdpHost readError" );

        connected = NO;
    
        [ self stopCheckingPing ];
        
        [ socket close ];
        socket = nil;

	}
	
	
	// socket send error
	
    - ( void )  sendError
	{

		// NSLog( @"UdpHost sendError" );

        connected = NO;
    
        [ self stopCheckingPing ];
        
        [ socket close ];
        socket = nil;
	
	}


	// returns port number

	- ( uint ) portNumber
	{
	
		return [ socket portNumber ];
	
	}


	@end
