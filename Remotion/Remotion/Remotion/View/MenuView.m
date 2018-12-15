//  MenuView.m
//  Remotion
//
//  Created by Milan Toth on 2/18/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "MenuView.h"


	@implementation MenuView


	#define kMenuViewFirstStartKey @"kDelegateFirstStartKey"


    // constructor

    - ( id )    initWithFrame   : ( CGRect ) theFrame
                withDelegate    : ( id     ) theDelegate
    {
    
        // NSLog( @"MenuView initWithFrame withDelegate %@" , pDelegate );
    
        self = [ super initWithFrame : theFrame ];
        
        if ( self )
        {

			// init
        
            float greenColors [ ]	= { .1  , .8 , .1  , 1.0 , 
										.2  , .6 , .2  , 1.0 };
            float yellowColors [ ]	= { .9  , .6 , .2  , 1.0 , 
										.8  , .5 , .1  , 1.0 };

            delegate  = [ theDelegate retain ];
			menuState = [ [ NSUserDefaults standardUserDefaults ] integerForKey : kMenuViewFirstStartKey ];
        
            buttonA   = [ [ ButtonView alloc ]	initWithId      : 0
												withLabel       : @"CONNECT TO HOST APPLICATION" 
												withFrame       : CGRectMake( 0 , 0 , 320 , 160  )
												withColors      : yellowColors
												withDelegate    : delegate ];      // needs release
        
            buttonB   = [ [ ButtonView alloc ]	initWithId      : 1
												withLabel       : @"SEND HOST APPLICATION TO COMPUTER" 
												withFrame       : CGRectMake( 0 , 160 , 320 , 160 ) 
												withColors      : greenColors
												withDelegate    : delegate ];      // needs release
        
            buttonC   = [ [ ButtonView alloc ]	initWithId      : 2
												withLabel       : @"INFORMATION" 
												withFrame       : CGRectMake( 0 , 320 , 320 , 160 ) 
												withColors      : greenColors
												withDelegate    : delegate ];      // needs release

			// setup
		
            [ self addSubview : buttonA ];
            [ self addSubview : buttonB ];
            [ self addSubview : buttonC ];
			
			if ( menuState == 0 )
			{
			
				menuState = 1;
				[ self setMenuState : 0 ];
				
			}
        
        }
        
        return self;
        
    }
    
    
    // destructor
    
    - ( void ) dealloc
    {

        // NSLog( @"MenuView dealloc" );
		
		// destruct
    
        [ buttonA release ];
        [ buttonB release ];
        [ buttonC release ];
    
        [ super dealloc ];
    
    }


	// swtiching send and connect buttons

	- ( void )	setMenuState : ( int ) theState
	{
		
		if ( menuState != theState )
		{

			// NSLog( @"MenuView setFirstStartState %i" , pState );
		
			[ buttonA removeFromSuperview ];
			[ buttonB removeFromSuperview ];
			
			[ buttonA release ];
			[ buttonB release ];
			
            float greenColors [ ]	= { .1  , .8 , .1  , 1.0 , 
										.2  , .6 , .2  , 1.0 };
            float yellowColors [ ]	= { .9  , .6 , .2  , 1.0 , 
										.8  , .5 , .1  , 1.0 };

			if ( !theState )
			{
			
				buttonA = [ [ ButtonView alloc ]  initWithId      : 0
												  withLabel       : @"CONNECT TO HOST APPLICATION" 
												  withFrame       : CGRectMake( 0 , 160 , 320 , 160 ) 
												  withColors      : greenColors
												  withDelegate    : delegate ];      // needs release
			
				buttonB = [ [ ButtonView alloc ]  initWithId      : 1
												  withLabel       : @"SEND HOST APPLICATION TO COMPUTER" 
												  withFrame       : CGRectMake( 0 , 0 , 320 , 160  )
												  withColors      : yellowColors
												  withDelegate    : delegate ];      // needs release
											  
			}
			else 
			{
			
				buttonA = [ [ ButtonView alloc ]  initWithId      : 0
												  withLabel       : @"CONNECT TO HOST APPLICATION" 
												  withFrame       : CGRectMake( 0 , 0 , 320 , 160  )
												  withColors      : yellowColors
												  withDelegate    : delegate ];      // needs release
			
				buttonB = [ [ ButtonView alloc ]  initWithId      : 1
												  withLabel       : @"SEND HOST APPLICATION TO COMPUTER" 
												  withFrame       : CGRectMake( 0 , 160 , 320 , 160 ) 
												  withColors      : greenColors
												  withDelegate    : delegate ];      // needs release

			}
			
			// setup
		
			[ self addSubview : buttonA ];
			[ self addSubview : buttonB ];
					
			[ [ NSUserDefaults standardUserDefaults ]	setInteger	: theState
														forKey		: kMenuViewFirstStartKey ];
			[ [ NSUserDefaults standardUserDefaults ]	synchronize ];
			
			menuState = theState;
			
		}

	}


	@end