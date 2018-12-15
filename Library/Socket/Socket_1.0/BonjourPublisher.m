//  BonjourPublisher.m
//  Remotion
//
//  Created by Milan Toth on 2/27/11.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "BonjourPublisher.h"


	@implementation BonjourPublisher


	// constructor

	- ( id ) initWithDomain : ( NSString* ) theDomain
			 withType		: ( NSString* ) theType
			 withName		: ( NSString* ) theName
			 withPort		: ( uint	  ) thePort
	{
	
		// NSLog( @"BonjourPublisher initWithPort : %u" , pPort );
	
		self = [ super init ];
		
		if ( self )
		{
		
			// init
			
			service		= [ [ NSNetService alloc ]	initWithDomain	: theDomain 
													type			: theType
													name			: theName
													port			: thePort ];	// needs release
							
			services	= [ [ NSMutableArray alloc ] init ];                        // needs release
							
			// setup

			if ( service )
			{
			
				[ service setDelegate : self ];
				[ service publish ];
				
			}
			else return nil;
		
		}
		
		return self;
		
	}
	
	
	// destructor
	
	- ( void ) dealloc
	{

		// NSLog( @"BonjourPublisher dealloc" );
		
		// rollback
		
		[ service setDelegate : nil ];
		
		// destruct
	
		[ service	release ];
		[ services	release ];
		[ super		dealloc ];
	
	}
	
	
	// stops service
	
	- ( void ) stop
	{
	
		// NSLog( @"BonjourPublisher stop" );
		
		[ service stop ];
	
	}


	// netservice was published successfully

	- ( void ) netServiceWillPublish : ( NSNetService* ) theService
	{
	
		// NSLog( @"BonjourPublisher netServiceWillPublish : %@" , pService );
		
		[ services addObject : theService ];
		
	}
	 
	
	// netservice publish failed

	- ( void )	netService		: ( NSNetService* ) theService
				didNotPublish	: ( NSDictionary* ) theErrorMap
	{

		// NSLog( @"BonjourPublisher netService : %@ DidNotPublish : %@" , pService , pErrorMap );

		[ services removeObject : theService ];
		
	}
	
		 
	// netservice stopped
	
	- ( void ) netServiceDidStop : ( NSNetService* ) theService
	{
	
		// NSLog( @"BonjourPublisher netServiceDidStop" );
		
		[ services removeObject : theService ];

	}


	@end