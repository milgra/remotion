//  NetworkUtilities.h
//  Remotion
//
//  Created by Milan Toth on 3/17/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <arpa/inet.h>
	#import <Foundation/Foundation.h>
	#import <SystemConfiguration/SystemConfiguration.h>


	@interface NetworkUtilities : NSObject

	
	+ ( BOOL ) wirelessAvailable;
	

	@end