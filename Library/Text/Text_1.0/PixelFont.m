//  Letter.m
//  MemeBox
//
//  Created by Milán Tóth on 5/28/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "PixelFont.h"


	@implementation PixelFont


	@synthesize pixels;
	@synthesize rectangle;
	@synthesize character;


	- ( void ) dealloc
	{
	
		// NSLog( @"PixelFont dealloc" );
	
		[ pixels	release ];
		[ rectangle release ];
		[ character release ];
	
		[ super dealloc ];
	
	}


	- ( NSString* ) description
	{

		return [ NSString stringWithFormat : @"Letter %@ , frame %@" , character , rectangle ];

	}


	@end
