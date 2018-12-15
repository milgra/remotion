//  MenuViewController.m
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "MenuViewController.h"


	@implementation MenuViewController


    // constructor

    - ( id ) initWithDelegate : ( id ) theDelegate
    {
	
		// NSLog( @"MenuViewController initWithDelegate" );
    
        self = [ super init ];
        
        if ( self ) 
        {
        
            delegate = [ theDelegate retain ]; // needs release

        }
        
        return self;
        
    }
    
    
    // destructor
    
    - ( void ) dealloc
    {
	
		// NSLog( @"MenuViewController dealloc" );
		
		// rollback
		
		[ menuView removeFromSuperview ];
		
		// release
		
		[ menuView  release ];
        [ delegate  release ];
        [ super     dealloc ];
    
    }
    
    
    // loads view

    - ( void ) loadView
    {
	
		// NSLog( @"MenuViewController loadView" );

        menuView  = [ [ MenuView alloc ]    initWithFrame   : [ [ UIScreen mainScreen ] bounds ] 
                                            withDelegate    : delegate ];		// needs release
        [ self setView : menuView ];

    }


	// sets first start state
	
	- ( void )	setMenuState : ( int ) theState
	{

		// NSLog( @"MenuViewController setMenuState %i" , pState );
	
		[ menuView setMenuState : theState ];
	
	}


    // should rotate

    - ( BOOL ) shouldAutorotateToInterfaceOrientation : ( UIInterfaceOrientation ) theOrientation
    {
    
        return ( theOrientation == UIInterfaceOrientationPortrait );
        
    }


	@end