//
//  Rectangle.m
//  MemeBox
//
//  Created by Milán Tóth on 5/28/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "Rectangle.h"


	@implementation Rectangle


	@synthesize x;
	@synthesize y;
	@synthesize width;
	@synthesize height;


	// constructor for cgrect

	- ( id ) initWithCGRect : ( CGRect ) theRect
	{
	
		// NSLog( @"Rectangle initWithCGRect" );
	
		self = [ super init ];
		
		if ( self )
		{
		
			x		= theRect.origin.x;
			y		= theRect.origin.y;
			width	= theRect.size.width;
			height	= theRect.size.height;
		
		}
		
		return self;
	
	}


	// constructor for rectangle

	- ( id ) initWithRectangle	: ( Rectangle* ) theRectangle
	{

		// NSLog( @"Rectangle initWithRectangle" );
	
		self = [ super init ];
		
		if ( self )
		{
		
			x		= theRectangle.x;
			y		= theRectangle.y;
			width	= theRectangle.width;
			height	= theRectangle.height;
		
		}
		
		return self;
	
	}


	// descriptor

	- ( NSString* ) description
	{

		return [ NSString stringWithFormat : @"x %f y %f width %f height %f" , x , y ,width , height ];

	}


	@end
