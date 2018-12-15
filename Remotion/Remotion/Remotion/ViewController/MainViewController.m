//  MainViewController.m
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "MainViewController.h"


	@implementation MainViewController


    // constructor

    - ( id ) initWithDelegate : ( id ) theDelegate
    {
	
		// NSLog( @"MainViewController initWithDelegate %@" , theDelegate );
    
        self = [ super init ];
        
        if ( self )
        {
        
            delegate = [ theDelegate retain ];		// needs release
        
        }
        
        return self;
    
    }
    
    
    // destructor
    
    - ( void ) dealloc
    {
	
		// NSLog( @"MainViewController dealloc" );
    
        [ delegate  release ];
        [ super     dealloc ];
    
    }


    // loads view

    - ( void ) loadView
    {
	
		// NSLog( @"MainViewController loadView" );

        controlView = [ [ ControlView  alloc ]	initWithFrame   : [ [ UIScreen mainScreen ] bounds ] 
												withDelegate    : delegate ];

        [ self setView : controlView ];

    }


    // rotation

    - ( BOOL ) shouldAutorotateToInterfaceOrientation : ( UIInterfaceOrientation ) theOrientation
    {
    
        return ( theOrientation == UIInterfaceOrientationPortrait );
        
    }
    

@end
