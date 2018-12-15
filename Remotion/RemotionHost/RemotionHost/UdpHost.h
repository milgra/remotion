//  UdpHost.h
//  Remotion
//
//  Created by Milan Toth on 3/1/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import "UdpSocket.h"
	#import "UdpSocketDelegate.h"
	#import "Protocol.h"
	#import "EventDelegate.h"


	#define kUdpHostConnectionSuccess 0
	#define kUdpHostConnectionClosure 1
	#define kUdpHostButtonData		  2
	#define kUdpHostRotationData	  3
	#define kUdpHostAccelerationData  4


	@interface UdpHost : NSObject < UdpSocketDelegate >
	{
		
		UdpSocket*				 socket;
        struct sockaddr_storage  address;
		
		id < EventDelegate >	 delegate;
        long					 lastPing;
		BOOL					 connected;
        NSTimer*				 checkTimer;
		
		
	}
	
	
	- ( id	 ) initWithDelegate : ( id ) theDelegate;
	- ( uint ) portNumber;


	@end
