//  StatusView.m
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "StatusView.h"


	@implementation StatusView


    // constructor

    - ( id )    initWithFrame   : ( CGRect ) theFrame
                withDelegate    : ( id     ) theDelegate
    {
		
		// NSLog( @"SearchView initWithFrame withDelegate" );
    
        self = [ super initWithFrame : theFrame ];
        
        if ( self ) 
        {
		
			delegate = [ theDelegate retain ];	// needs release

        }
        
        return self;
        
    }
    
    
    // destructor
    
    - ( void ) dealloc
    {
	
		// NSLog( @"SearchView dealloc" );
		
		// rollback
    
        [ buttonView removeFromSuperview ];
		
		// destruct
		
        [ buttonView	release ];
		[ delegate		release ];
        [ super         dealloc ];
    
    }


	// sets label

	- ( void )	setLabel : ( NSString*	) theLabel
				withRed  : ( BOOL		) theRed
	{
	
		// NSLog( @"SearchView setLabel %@" , pLabel );
        
		float redColors [ ]		= { .7  , .2 , .1  , 1.0 , 
									.7  , .1 , .2  , 1.0 };
        float yellowColors [ ]	= { .9  , .6 , .2  , 1.0 , 
									.8  , .5 , .1  , 1.0 };

		[ buttonView removeFromSuperview ];
		[ buttonView release ];
		
		buttonView  = [ [ ButtonView alloc ]	initWithId	 : 0 
												withLabel	 : theLabel
												withFrame	 : [ self frame ]
												withColors	 : theRed ? redColors : yellowColors 
												withDelegate : delegate ];	// needs release
		
		// setup

		[ self addSubview : buttonView ];
	
	}


	@end
