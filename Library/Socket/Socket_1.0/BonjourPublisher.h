//  BonjourPublisher.h
//  Remotion
//
//  Created by Milan Toth on 2/27/11.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>


	@interface BonjourPublisher : NSObject < NSNetServiceDelegate >
	{

		NSNetService*	service;
		NSMutableArray* services;
		
	}


	- ( id ) initWithDomain : ( NSString* ) theDomain
			 withType		: ( NSString* ) theType
			 withName		: ( NSString* ) theName
			 withPort		: ( uint	  ) thePort;
	

	@end