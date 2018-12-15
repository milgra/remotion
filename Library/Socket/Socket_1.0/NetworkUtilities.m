//  NetworkUtilities.m
//  Remotion
//
//  Created by Milan Toth on 3/17/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "NetworkUtilities.h"


	@implementation NetworkUtilities


	// checking wifi availability

	+ ( BOOL ) wirelessAvailable
	{
	
		// NSLog( @"NetworkUtilities wirelessAvailable" );
	
		BOOL				result = NO;
		struct sockaddr_in	localWifiAddress;
		
		bzero( &localWifiAddress , sizeof( localWifiAddress ) );
		localWifiAddress.sin_len = sizeof( localWifiAddress );
		localWifiAddress.sin_family = AF_INET;
		localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);
		
		SCNetworkReachabilityRef	reachability;
		SCNetworkReachabilityFlags	flags;
		
		reachability = SCNetworkReachabilityCreateWithAddress(	kCFAllocatorDefault , 
																( const struct sockaddr* ) &localWifiAddress );		
		
		if ( SCNetworkReachabilityGetFlags( reachability , &flags ) )
		{
		
			if ( ( flags & kSCNetworkReachabilityFlagsReachable ) && 
				 ( flags & kSCNetworkReachabilityFlagsIsDirect  ) )	result = YES;
			
		}
		
		CFRelease( reachability );
		return result;

	}


	@end