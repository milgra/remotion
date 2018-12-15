//  UdpClient.m
//  Remotion
//
//  Created by Milan Toth on 2/25/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "UdpClient.h"


	@implementation UdpClient


    // constructor

    - ( id ) initWithDelegate : ( id ) theDelegate
    {
    
        // NSLog( @"UdpClient init %@" , theDelegate );
    
        self = [ super init ];
        
        if ( self )
        {
		
			// init
			
            connected   = NO;
			reachable	= NO;
        
            delegate    = [ theDelegate retain ];								// needs release

        }
        
        return self;    
    
    }
    
    
    // destructor
    
    - ( void ) dealloc
    {

        // NSLog( @"UdpClient dealloc" );
		
		// rollback

		[ self		stopPing ];
		[ socket	close ];
		
		// destruct
		
		[ delegate	release ];    
		[ socket	release ];
        [ super		dealloc ];
    
    }
	
	
	// inits an udp socket in advance
	
	- ( void ) prepareSocket
	{

		// NSLog( @"UdpClient prepareSocket" );
			
		if ( socket == nil )
		{
	
			socket = [ [ UdpSocket alloc ] initWithFamily : AF_INET6 
										   withDelegate   : self ];	// needs release
												
			[ socket listenWithPacketSize : kProtocolPacketSize ];
			
		}
	
	}
    
    
    // start sending keepalive
    
    - ( void ) startPing
    {
    
        // NSLog( @"UdpClient startPing" );
    
        [ self stopPing ];
        
        lastPong  = ( long ) [ [ NSDate date ] timeIntervalSince1970 ];
        pingTimer = [ NSTimer  scheduledTimerWithTimeInterval  : kProtocolPingDelay 
                               target                          : self 
                               selector                        : @selector(sendPing) 
                               userInfo                        : nil 
                               repeats                         : YES   ];
    
    }
    
    
    // stops sending keepalive
    
    - ( void ) stopPing
    {

        // NSLog( @"UdpClient stopPing" );
    
        if ( pingTimer != nil ) 
        {
        
            [ pingTimer invalidate ];
            pingTimer = nil;
            
        }
    
    }


    // sends keepalive request

    - ( void ) sendPing 
    {
    
        // NSLog( @"UdpClient sendPing" );
    
     	char packet[ kProtocolPacketSize ];

		packet[ 0 ] = kProtocolTypePing;
                
        [ socket    sendBytes : packet 
                    withSize  : kProtocolPacketSize 
                    toAddress : address ];

        // check pong, timeout if needed
    
        long duration = ( long )[ [ NSDate date ] timeIntervalSince1970 ] - ( long ) lastPong;
        
        if ( duration > kProtocolTimeOut )
        {
        
            [ self stopPing ];
        
            if ( connected )
            {
			
                [ delegate  eventArrived : kConnectionDisconnect 
                            fromInstance : self 
                            withUserData : nil ];
							
            }
            else
            {
			
                [ delegate  eventArrived : kConnectionTimeout
                            fromInstance : self 
                            withUserData : nil ];

            }
        
        }
        
    }
    
    
    // data arrived from socket
    
    - ( void )  dataArrived : ( char*					) theData
                fromAddress : ( struct sockaddr_storage ) theAddress
                withLength  : ( socklen_t				) theLength
    {

        // NSLog( @"UdpClient dataArrived %i" , pData[ 0 ] );
		
		if ( reachable )
		{
		
			switch ( theData[ 0 ] ) 
			{
			
				case kProtocolTypePong :
				{
				
					if ( !connected )
					{
					
						connected = YES;
						
						[ delegate  eventArrived : kConnectionSuccess 
									fromInstance : self 
									withUserData : nil ];
					
					}
				
					lastPong = ( long ) [ [ NSDate date ] timeIntervalSince1970 ];

					break;

				}

			}
			
		}
    
    }
    
    
    // socket read error
    
    - ( void )  readError
    {
    
        // NSLog( @"UdpClient readError" );

		reachable = NO;
        connected = NO;
    
        [ self stopPing ];        
        [ socket close ];
        
        socket = nil;
    
    }
    

    // socket send error
    
    - ( void )  sendError
    {

        // NSLog( @"UdpClient sendError" );
    
		reachable = NO;
        connected = NO;
    
        [ self stopPing ];        
        [ socket close ];
        
        socket = nil;
    
    }


    // connecting to address

    - ( void ) connectToAddress : ( struct sockaddr_storage ) theAddress
    {
    
        // NSLog( @"UdpClient connectToAddress : %@ connected %i" , [ AddressUtilities describeAddress : pAddress ] , connected );

		if ( !connected )
		{
		
			reachable = YES;

            [ AddressUtilities  convertAddress  : &theAddress 
                                toAddress       : &address
                                toFamily        : AF_INET6 ];
								
			[ self prepareSocket ];
            [ self startPing ];
            [ self sendPing ];

        }
            
    }
    
    
    // send disconnect message
    
    - ( void )  disconnect
    {
	
		// NSLog( @"UdpClient disconnect" );
		
		if ( connected )
		{
    		
			reachable = NO;
			connected = NO;
			
			char packet[ kProtocolPacketSize ];

			packet[ 0 ] = kProtocolTypeDisconnect;
					
			[ self		stopPing ];        
			[ socket    sendBytes : packet 
						withSize  : kProtocolPacketSize 
						toAddress : address ];
			[ socket	close ];
			[ socket	release ];
			
			socket = nil;
						
		}

    }

    
    // send packet
    
	- ( void ) 	send : ( void* ) theData
	{
    
        // NSLog( @"UdpClient send %i" , connected );
		
		if ( connected )
		{
                        
			[ socket    sendBytes : theData
						withSize  : kProtocolPacketSize 
						toAddress : address ];
					
		}

	}


	@end
