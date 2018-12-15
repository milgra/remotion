//  UdpSocket.h
//  Remotion
//
//  Created by Milan Toth on 2/25/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import <sys/socket.h>
	#import <netinet/in.h>
    
	#import "UdpSocketDelegate.h"
	#import "AddressUtilities.h"


	// error messages

	#define kUdpSocketBindError             @"Cannot bind read socket to address"
	#define kUdpSocketPortError             @"Cannot get socket port"
	#define kUdpSocketCreateError           @"Cannot create socket"
	#define kUdpSocketTunnelError           @"Cannot tunnel IP6 socket"
    

    @interface UdpSocket : NSObject
    {

        id < UdpSocketDelegate >	delegate;

        BOOL						active;
		BOOL						closed;
        int							serverSocket;
        struct sockaddr_storage		serverAddress;
        
        uint						port;
        uint						packetSize;
        uint						socketFamily;
        
        socklen_t					ipv4Length;
        socklen_t					ipv6Length;
        
        // statistics
        
        long long					bytesIn;
        long long					bytesOut;
        long long					packetsIn;
        long long					packetsOut;

    }

    - ( id   )  initWithFamily		 : ( uint					 ) theFamily 
				withDelegate		 : ( id						 ) theDelegate;
	
	- ( void )  sendBytes			 : ( char*					 ) theBytes
                withSize			 : ( uint					 ) theSize
                toAddress			 : ( struct sockaddr_storage ) theAddress;
				
    - ( void )  listenWithPacketSize : ( uint					 ) theSize;
				
    - ( uint )  portNumber;
    - ( BOOL )  isActive;	
    - ( void )  close;


	@end
