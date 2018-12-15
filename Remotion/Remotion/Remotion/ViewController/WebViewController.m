//  WebViewController.m
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "WebViewController.h"


	@implementation WebViewController


    // constructor

    - ( id ) initWithDelegate : ( id ) theDelegate
    {
	
        // NSLog( @"WebViewController initWithDelegate %@" , pDelegate );
    
        self = [ super init ];
        
        if ( self )
        {
        
            delegate = [ theDelegate retain ];	// needs release
        
        }
        
        return self;
    
    }
    
    
	// destructor
	
    - ( void ) dealloc
    {

        // NSLog( @"WebViewController dealloc" );
		
		// rollback
		
		[ webView removeFromSuperview ];
		
		// release
		
		[ request	release ];
		[ webView	release ];
        [ delegate	release ];
        [ super		dealloc ];
    
    }


	// loads url request

    - ( void ) loadUrlRequest : ( NSURLRequest* ) theRequest;
    {
    
        // NSLog( @"WebViewController loadUrlRequest %@ webView %@" , pRequest , webView );
		
		if ( ![ request isEqual : theRequest ] )
		{ 
    
			[ request release ];
			request = [ theRequest retain ];
			
			if ( webView != nil ) [ webView loadRequest : theRequest ];
			
		}
    
    }


	// loads view

    - ( void ) loadView
    {
    
        // NSLog( @"WebViewController loadView" );

        webView = [ [ UIWebView alloc ] initWithFrame : [ [ UIScreen mainScreen ] bounds ] ];
		
        [ webView setScalesPageToFit : YES ];
		[ webView loadRequest		 : request ];
        
        [ self setView : webView ];

    }
    
	
	// view unloaded
    
    - ( void ) viewDidUnload
    {

        // NSLog( @"WebViewController viewDidUnload" );
    
        webView = nil;    
    
    }
	
	
	// should rotate

    - ( BOOL ) shouldAutorotateToInterfaceOrientation : ( UIInterfaceOrientation ) theOrientation
    {
    
        return ( theOrientation == UIInterfaceOrientationPortrait );
        
    }


	@end