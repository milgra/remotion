//  TextGenerator.h
//  MemeBox
//
//  Created by Milán Tóth on 5/28/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import "PixelFont.h"
	#import "PixelFontGenerator.h"


	#define kTextGeneratorHorizontalAlignmentLeft	0
	#define kTextGeneratorHorizontalAlignmentCenter 1
	#define kTextGeneratorHorizontalAlignmentRight	2

	#define kTextGeneratorVerticalAlignmentTop		0
	#define kTextGeneratorVerticalAlignmentCenter	1
	#define kTextGeneratorVerticalAlignmentBottom	2


	@interface PixelTextGenerator : NSObject


	+ ( NSArray* ) createLetters : ( NSString*   ) theText
				   inFrame		 : ( Rectangle*  ) theRectangle
				   gridSize		 : ( float		 ) theGridSize
				   pixelSize	 : ( float		 ) thePixelSize
				   letterGap	 : ( float		 ) theLetterGap
				   lineGap		 : ( float		 ) theLineGap
				   horizontal	 : ( uint		 ) theHorizontal
				   vertical		 : ( uint		 ) theVertical;


	@end