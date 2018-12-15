//
//  Letter.h
//  MemeBox
//
//  Created by Milán Tóth on 5/28/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import "Rectangle.h"


	@interface PixelFont : NSObject
	{

		NSMutableArray*		pixels;
		Rectangle*			rectangle;
		NSString*			character;

	}
	
	
	@property (retain) NSArray*		pixels;
	@property (retain) Rectangle*	rectangle;
	@property (retain) NSString*	character;


	@end
