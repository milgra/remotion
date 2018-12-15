//  EventDelegate.h
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	

	@protocol EventDelegate < NSObject >


    - ( void )  eventArrived : ( uint  ) theId
                fromInstance : ( void* ) theInstance
                withUserData : ( void* ) theUserData;
                

	@end
