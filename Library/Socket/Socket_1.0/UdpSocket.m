//  UdpSocket.m
//  Remotion
//
//  Created by Milan Toth on 2/25/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "UdpSocket.h"


	@implementation UdpSocket


    - ( id   )  initWithFamily	: ( uint ) theFamily 
				withDelegate	: ( id	 ) theDelegate
    {
    
        // NSLog( @"UdpSocket initWithFamily %u withDelegate %@" , pFamily , pDelegate );

        self = [ super init ];
        
        if ( self )
        {
        
            // init
		
			delegate	 = [ theDelegate retain ];	// needs release
            
            ipv4Length	 = sizeof( struct sockaddr_in );
            ipv6Length	 = sizeof( struct sockaddr_in6 );
            
            socketFamily = theFamily;
			serverSocket = socket(  socketFamily , 
									SOCK_DGRAM   , 
									IPPROTO_UDP  );
                                    
			if ( serverSocket > -1 ) 
			{
            
                // creation success
            
                if ( socketFamily == AF_INET6 )
                {
                
                    // switching off IPV6 only feature
                    // it it fails, then no IPV4 sockets can connect

                    int option	  = 0;
                    int setStatus = setsockopt( serverSocket , 
                                                IPPROTO_IPV6 , 
                                                IPV6_V6ONLY  , 
                                                &option , 
                                                sizeof option );

                    if ( setStatus == -1 ) NSLog( kUdpSocketTunnelError );
					
                    // create ipv6 address

                    struct sockaddr_in6 serverAddress6;
                    
                    // zero out address
                    memset( &serverAddress6 , 0 , sizeof( serverAddress6 ) );
                    
                    // TODO bzero is deprecated!!!
                    // !!! bzero( &serverAddress6 , sizeof( serverAddress6 ) );
                    
                    serverAddress6.sin6_family   = AF_INET6;
                    serverAddress6.sin6_addr	 = in6addr_any;
                    serverAddress6.sin6_port	 = htons(0);
                    
                    // store server address in universal storage
                    
                    serverAddress = *( ( struct sockaddr_storage* ) &serverAddress6 );
                    
                }
                else
                {
                
                    // create ipv4 address
                
                    struct sockaddr_in serverAddress4;
                    
                    // zero out address
                    memset( &serverAddress4 , 0 , sizeof( serverAddress4 ) );
                    
                    // TODO bzero is deprecated!!!
                    // bzero( &serverAddress4 , sizeof( serverAddress4 ) );
                    
                    serverAddress4.sin_family       = AF_INET;
                    serverAddress4.sin_addr.s_addr  = INADDR_ANY;
                    serverAddress4.sin_port         = htons(0);

                    // store server address in universal storage
                
                    serverAddress = *( ( struct sockaddr_storage* ) &serverAddress4 );

                }
				
				// bind address to socket, os gives a free port number to us
                
                int bindStatus = bind( serverSocket , 
									   ( struct sockaddr* ) &serverAddress  , 
                                       socketFamily == AF_INET6 ? ipv6Length : ipv4Length );
				
				if ( bindStatus != -1 )
                {
                
                    // successful binding
                    // overwriting server address with binded address ( more detail )
                    
                    socklen_t addressLength = socketFamily == AF_INET6 ? ipv6Length : ipv4Length;
                    int addressStatus = getsockname( serverSocket ,
                                                     ( struct sockaddr* ) &serverAddress ,
                                                      &addressLength );
					
					if (  addressStatus != -1 )
                    {
                    
                        // get port
					
                        if ( serverAddress.ss_family == AF_INET  ) port = htons( ( ( struct sockaddr_in*  ) &serverAddress )->sin_port  );else
                        if ( serverAddress.ss_family == AF_INET6 ) port = htons( ( ( struct sockaddr_in6* ) &serverAddress )->sin6_port );
						                    
						NSLog( @"Server socket address : %@" , [ AddressUtilities describeAddress : serverAddress ] );

                    }
					else NSLog( kUdpSocketPortError );
                    
                }
                else NSLog( kUdpSocketBindError );
                
			}
            else NSLog( kUdpSocketCreateError );
                        

        }

        return self;

    }

    
    // destructor

    - ( void )
    dealloc
    {
    
        // NSLog( @"UdpSocket dealloc" );
        
        // rollback
		
        close( serverSocket );
		
		// destruct

		[ delegate	release ];
        [ super		dealloc ];
        
    }
    
    
    // close socket
    
    - ( void ) close
    {
    
        // NSLog( @"UdpSocket close" );
        
        active = NO;
		closed = YES;
        close( serverSocket );
    
    }


    // starts listening
    
    - ( void ) listenWithPacketSize : ( uint ) theSize
    {
    
        // NSLog( @"UdpSocket listenWithPacketSize %u" , pSize );
		
		if ( !active )
		{
        
			packetSize = theSize;
			
			[ NSThread 	detachNewThreadSelector 	: @selector(read) 
						toTarget 					: self 
						withObject					: nil ];
						
		}

    }
    
    
    // reading
    
    - ( void ) read
    {
    
        // NSLog( @"UdpSocket read" );
    
        // listener thread will call internal methods, so we need an autoreleasepool
    
        active = YES;
		
		while ( active )
		{
        
            char                    buffer[ packetSize ];
			struct sockaddr_storage address;
            socklen_t               addressLength = sizeof( address );
			
            memset( &address , 0 , sizeof( address ) );
            
            // blocking receive, always blocks until next packet
            
			long sizeIn = recvfrom( serverSocket					,
									buffer							,
									packetSize						,
									0								,
									( struct sockaddr* ) &address   , 
									&addressLength					);

			if ( sizeIn == -1 )
            {
                
				if ( !closed )
				{
					[ delegate readError ];
					[ self close ];
				}
            
            }
            else 
            {
            
                bytesIn     += sizeIn;
                packetsIn   += 1;
                            
                // else dispatch event to delegate
                    
                [ delegate  dataArrived : buffer 
                            fromAddress : address 
                            withLength  : addressLength ];
            
            }

		}

    }
    
    
    // sending
    
	- ( void )  sendBytes   : ( char* ) theBytes
                withSize    : ( uint  ) theSize
                toAddress   : ( struct sockaddr_storage ) theAddress
	{

		// NSLog( @"UdpSocket send %u %u %u size %u address %@" , pBytes[ 0 ] , pBytes[ 1 ] , pBytes[ 2 ] , pSize , [ AddressUtilities describeAddress:pAddress ] );

        // send buffer

        long sizeOut = sendto( serverSocket                    ,
                               theBytes                        ,
                               theSize                         ,
                               0                               , 
                               ( struct sockaddr*  ) &theAddress , 
                               socketFamily == AF_INET6 ? ipv6Length : ipv4Length );

        bytesOut    += sizeOut;
        packetsOut  += 1;

        if ( sizeOut == -1 )
        {
		
			// NSLog( @"Send error : %i" , errno );
            
            [ delegate sendError ];
            [ self close ];
            
        }

        if ( !active )
        {
        
            NSLog( @"WARNING : socket is not listening, possible response receiving problem!!!" );
        
        }

	}
	
	
	// returns port number
	
	- ( uint ) portNumber
	{
	
		return port;
	
	}
    
    
    // returns active state
    
    - ( BOOL ) isActive
    {
    
        return active;
    
    }
    

    // shows statistics
    
    - ( void ) showStatistics
    {
    
        NSLog( @"\npacketsIn : %lld \n packetsOut : %lld \n bytesIn : %lld \n bytesOut : %lld" , 
               packetsIn ,
               packetsOut ,
               bytesIn ,
               bytesOut );
    
    }


	@end
