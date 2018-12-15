//  AdressUtilities.h
//  Remotion
//
//  Created by Milan Toth on 2/25/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import <netinet/in.h>
	#import <sys/socket.h>
	#import <arpa/inet.h>


    @interface AddressUtilities : NSObject


    + ( void )		convertAddress  : ( struct sockaddr_storage* ) theAddressFrom 
					toAddress       : ( struct sockaddr_storage* ) theAddressTo
					toFamily        : ( uint                     ) theFamily;

    + ( NSString* ) describeAddress : ( struct sockaddr_storage  ) theAddress;


	@end
