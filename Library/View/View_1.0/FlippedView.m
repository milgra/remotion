//
//  FlippedView.m
//  GameControlOSX
//
//  Created by Milan Toth on 3/1/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//

#import "FlippedView.h"

@implementation FlippedView


	// set coordinate flipping

	- ( BOOL ) isFlipped 
	{
	
		return YES; 
		
	}


	// draw rectangle

	- ( void ) drawRect : ( NSRect ) pRect
	{

		// NSLog( @"SharedMainView drawRect" );
		
		NSColor* color = [ NSColor blackColor ];

		[ color			set				 ];
		[ NSBezierPath	fillRect : pRect ];

	}


@end
