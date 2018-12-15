//
//  Rectangle.h
//  MemeBox
//
//  Created by Milán Tóth on 5/28/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>

	#ifdef BUILD_TARGET_OSX
    #import <AppKit/AppKit.h>
	#else
    #import <UIKit/UIKit.h>
	#endif


	@interface Rectangle : NSObject
	{

		float x;
		float y;
		float width;
		float height;

	}


	@property (readwrite,atomic) float x;
	@property (readwrite,atomic) float y;
	@property (readwrite,atomic) float width;
	@property (readwrite,atomic) float height;
	
	
	- ( id ) initWithCGRect		: ( CGRect		) theRect;
	- ( id ) initWithRectangle	: ( Rectangle*	) theRectangle;


	@end
