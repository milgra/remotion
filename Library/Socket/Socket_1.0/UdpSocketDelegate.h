//  UdpSocketDelegate.h
//  Remotion
//
//  Created by Milan Toth on 2/25/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>

	#import <sys/socket.h>
	#import <netinet/in.h>


	@protocol UdpSocketDelegate <NSObject>


    - ( void )  dataArrived : ( char*					) theData
                fromAddress : ( struct sockaddr_storage ) theAddress
                withLength  : ( socklen_t				) theLength;
    - ( void )  readError;
    - ( void )  sendError;


	@end