//  MotionHandler.m
//  Remotion
//
//  Created by Milan Toth on 2/18/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "MotionHandler.h"


	#define kFilteringFactor	0.5
	#define kUpdateInterval		0.02


	@implementation MotionHandler


    // constructor

    - ( id ) initWithDelegate : ( id ) theDelegate
    {
    
        // NSLog( @"MotionHandler initWithDelegate %@" , theDelegate );

        self = [ super init ];
        
        if ( self )
        {
		
			// init

            delegate = [ theDelegate retain ];										// needs release
            
            // create motionmanager

            if ( [ CMMotionManager class ] )
            {
            
                motionQueue     = [ [ NSOperationQueue  currentQueue ] retain   ];  // needs release
                motionManager   = [ [ CMMotionManager   alloc        ] init     ];  // needs release

            }
                
        }
        
        return self;

    }


    // destructor

    - ( void ) dealloc
    {

        // NSLog( @"MotionHandler dealloc" );
		
		// destruct
    
        [ motionQueue   release ];
        [ motionManager release ];
    
		[ delegate		release ];
        [ super         dealloc ];
    
    }

    
    // starts listening to control events
    
    - ( void ) start
    {
    
        // NSLog( @"MotionHandler start" );

        // start sensor listening 
        
        if ( [ CMMotionManager class ] )
        {
        
            if ( motionManager.gyroAvailable )
            {
			
				// define motionhandler block
            
                CMDeviceMotionHandler motionHandler = ^( CMDeviceMotion *motion, NSError *error)
                {
													
					attitude.x = motionManager.deviceMotion.attitude.roll	* kFilteringFactor + attitude.x * ( 1.0 - kFilteringFactor );
					attitude.y = motionManager.deviceMotion.attitude.pitch	* kFilteringFactor + attitude.y * ( 1.0 - kFilteringFactor );
					
					// at -180 to +180 jump don't filter
					
					if ( fabs( motionManager.deviceMotion.attitude.yaw - attitude.z ) > M_PI )
					{
						attitude.z = motionManager.deviceMotion.attitude.yaw;
					}
					else 
					{
						attitude.z = motionManager.deviceMotion.attitude.yaw * kFilteringFactor	+ attitude.z * ( 1.0 - kFilteringFactor );
					}

					// flatten attitude and send

                    char* flatRotation = malloc( sizeof( attitude ) );

                    memcpy( flatRotation ,
                            &attitude ,
                            sizeof( attitude ) );
                            
                    [ delegate  eventArrived : kMotionHandlerRotationEvent 
                                fromInstance : self 
                                withUserData : flatRotation ];
								
					free( flatRotation );
                    
                };
                
                [ motionManager setDeviceMotionUpdateInterval   : kUpdateInterval ];
                [ motionManager startDeviceMotionUpdatesToQueue : motionQueue 
                                withHandler                     : motionHandler	  ];
                                
            }

        }

    }
    
    
    // stops listening to control events
    
    - ( void )
    stop
    {
    
        // NSLog( @"MotionHandler stop" );
     
		[ motionManager stopDeviceMotionUpdates ];

    }


	@end
