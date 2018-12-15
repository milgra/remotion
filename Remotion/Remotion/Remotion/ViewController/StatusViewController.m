//  SearchViewController.m
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.

	
	#import "StatusViewController.h"


    @implementation StatusViewController
    
    
    // constructor

    - ( id ) initWithDelegate : ( id ) theDelegate;
    {
        
        // NSLog( @"SearchViewController initWithDelegate %@" , pDelegate );

        self = [ super init ];
        
        if ( self ) 
        {
        
            delegate = [ theDelegate retain ];
        
        }
        
        return self;
        
    }


    // destructor

    - ( void ) dealloc
    {

        // NSLog( @"SearchViewController dealloc" );
		
		// rollback
		
		[ statusView removeFromSuperview ];
		
		// release

		[ statusView	release ];
        [ delegate		release ];
		[ label			release ];    
        [ super			dealloc ];
    
    }


    // loads view

    - ( void ) loadView
    {

        // NSLog( @"SearchViewController loadView" );

        statusView = [ [ StatusView alloc ] initWithFrame   : [ [ UIScreen mainScreen ] bounds ] 
                                            withDelegate    : delegate ];		// needs release
											
		if ( label != nil ) [ statusView	setLabel : label withRed : color ];

        [ self setView : statusView ];

    }


    // rotation

    - ( BOOL ) shouldAutorotateToInterfaceOrientation : ( UIInterfaceOrientation ) theOrientation
    {
    
        return ( theOrientation == UIInterfaceOrientationPortrait );
        
    }
	
	
	// sets label
	
	- ( void )	setLabel	: ( NSString*	) theLabel
				withRed 	: ( BOOL		) theRed
	{
	
		[ label release ];
	
		label = [ theLabel retain ];
		color = theRed;
	
		[ statusView	setLabel : theLabel 
						withRed	 : theRed ];
	
	}


	@end
