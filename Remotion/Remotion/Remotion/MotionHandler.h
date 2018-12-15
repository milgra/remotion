//  MotionHandler.h
//  Remotion
//
//  Created by Milan Toth on 2/18/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <CoreMotion/CoreMotion.h>       // for motion detection
	#import "EventDelegate.h"               // for event dispatching


    #define kMotionHandlerAccelerateEvent   0
    #define kMotionHandlerRotationEvent     1


    @interface MotionHandler : NSObject
    {
    
        id < EventDelegate >	delegate;

		CMRotationRate			attitude;
        NSOperationQueue*		motionQueue;
        CMMotionManager*		motionManager;		
        
    }
	
    
    - ( id   ) initWithDelegate : ( id ) theDelegate;
    - ( void ) start;
    - ( void ) stop;


	@end