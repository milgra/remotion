//  UdpConnection.h
//  Remotion
//
//  Created by Milan Toth on 2/25/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import "UdpSocketDelegate.h"       // for socket events
	#import "AddressUtilities.h"        // for address conversion
	#import "EventDelegate.h"           // for delegate event calls
	#import "UdpSocket.h"               // socket
	#import "Protocol.h"                // protocol


    #define kConnectionSuccess          0
    #define kConnectionTimeout          1
    #define kConnectionDisconnect       2


    @interface UdpClient : NSObject < UdpSocketDelegate >
    {

        id < EventDelegate >        delegate;

        UdpSocket*                  socket;        
        struct sockaddr_storage     address;
		
		BOOL						reachable;
        BOOL                        connected;

        long                        lastPong;
        NSTimer*                    pingTimer;
    
    }
    

    - ( id   )  initWithDelegate    : ( id						) pDelegate;
    - ( void )  connectToAddress    : ( struct sockaddr_storage ) pAddress;
    - ( void )  send                : ( void*					) pData;
    - ( void )  disconnect;
	- ( void )	prepareSocket;


	@end
