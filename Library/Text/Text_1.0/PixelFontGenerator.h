//  LetterMap.h
//  MemeBox
//
//  Created by Milán Tóth on 5/18/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import "PixelFont.h"
	#import "Rectangle.h"

	
	@interface PixelFontGenerator : NSObject


    + ( PixelFont* )	createLetter : ( NSString* ) theLetter
						gridSize	 : ( float	   ) theGridSize
						pixelSize    : ( float     ) thePixelSize;
				

	@end
