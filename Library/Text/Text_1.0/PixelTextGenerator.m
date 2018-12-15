//
//  TextGenerator.m
//  MemeBox
//
//  Created by Milán Tóth on 5/28/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//

	#import "PixelTextGenerator.h"


    #define kLineGap    10
    #define kWordGap    10


	@implementation PixelTextGenerator


	// generates letters based on frame, pixelsize and alignment

	+ ( NSArray* ) createLetters : ( NSString*   ) theText
				   inFrame		 : ( Rectangle*  ) theRectangle
				   gridSize		 : ( float		 ) theGridSize
				   pixelSize	 : ( float		 ) thePixelSize
				   letterGap	 : ( float		 ) theLetterGap
				   lineGap		 : ( float		 ) theLineGap
				   horizontal	 : ( uint		 ) theHorizontal
				   vertical		 : ( uint		 ) theVertical
	{
	
		// NSLog( @"TextGenerator createText %@ inFrame %@ pixelSize %f horizontal %u vertical %u" , pText , pRectangle , pPixelSize , pHorizontal , pVertical );
		
		NSMutableArray* letters = [ [ NSMutableArray alloc ] init ];			// needs release
		
		if ( [ theText length ] > 0 )
		{
			
			float wordWidth = 0;
			float lineWidth = 0;
			float textHeight = 0;
			
			NSMutableArray* line    = [ [ NSMutableArray alloc ] init ];
			NSMutableArray* word    = [ [ NSMutableArray alloc ] init ];
			
			NSMutableArray* lines   = [ [ NSMutableArray alloc ] init ];
			NSMutableArray* widths  = [ [ NSMutableArray alloc ] init ];
			NSMutableArray* heights = [ [ NSMutableArray alloc ] init ];
			
			// generate unpositioned letter array
						
			for ( int index = 0 ; 
					  index < [ theText length ] ; 
					  index++ )
			{
			
				NSRange range = NSMakeRange( index , 1 );
				
				// get letter
				
				PixelFont* letter = [ PixelFontGenerator	createLetter : [ theText substringWithRange : range ]
															gridSize     : theGridSize
															pixelSize	 : thePixelSize ];			// needs release
				
				// store letter
				
				[ letters addObject : letter ];
				
				// release
				
				[ letter release ];													// release
				
				// count line width
				
				wordWidth += [ [ letter rectangle ] width ] + theLetterGap;
				lineWidth += [ [ letter rectangle ] width ] + theLetterGap;
				
				// add letter to word
				
				[ word addObject : letter ];
				
				// if letter is space, store letters in old word, start new world
				
				if ( [ [ letter character ] isEqualToString : @" " ] )
				{

					[ line addObjectsFromArray : word ];
					[ word removeAllObjects ];
					wordWidth = 0;
					
				}
				
				// line got wider than our bounding rectangle
				
				if ( lineWidth > [ theRectangle width ] )
				{

					lineWidth -= wordWidth;
					
					[ lines		addObject : line ];
					[ widths	addObject : [ NSNumber numberWithFloat : lineWidth ] ];
					[ heights	addObject : [ NSNumber numberWithFloat : [ [ letter rectangle ] height ] ] ];
					
					[ line release ];
					
					line = [ [ NSMutableArray alloc ] init ];
					lineWidth = wordWidth;
					textHeight += [ [ letter rectangle ] height ];
					
				}
			
			}
			
			// add last word
			
			if ( [ word count ] > 0 )
			{
			
				[ line addObjectsFromArray : word ];
			
			}
			
			// add last line
			
			if ( [ line count ] > 0 )
			{
				
				[ lines		addObject : line ];
				[ widths	addObject : [ NSNumber numberWithFloat : lineWidth ] ];
				[ heights	addObject : [ NSNumber numberWithFloat : [ [ [ line lastObject ] rectangle ] height ] ] ];
				
				textHeight += [ [ [ line lastObject ] rectangle ] height ] + theLineGap;

			}

			// release line and word

			[ word release ];
			[ line release ];
			
			// align letters
				
			float startX = 0;
			float startY = 0;
			
			// calculate vertical starting position

			float deltaY = [ theRectangle height ] - textHeight;

			if ( theVertical == kTextGeneratorVerticalAlignmentTop	) startY = 0; else
			if ( theVertical == kTextGeneratorVerticalAlignmentCenter	) startY = deltaY / 2; else
			if ( theVertical == kTextGeneratorVerticalAlignmentBottom	) startY = deltaY;
			
			startY += theRectangle.y;
			
			for ( int index = 0 ;
					  index < [ lines count ] ;
					  index ++ )
			{
			
				float width  = [ [ widths  objectAtIndex : index ] floatValue ];
				float height = [ [ heights objectAtIndex : index ] floatValue ];
				
				// calculate horizontal starting position
				
				float deltaX = [ theRectangle width ] - width;
								
				if ( theHorizontal == kTextGeneratorHorizontalAlignmentLeft   ) startX = 0; else
				if ( theHorizontal == kTextGeneratorHorizontalAlignmentCenter ) startX = deltaX / 2; else
				if ( theHorizontal == kTextGeneratorHorizontalAlignmentRight  ) startX = deltaX;
				
				startX += theRectangle.x;
				
				line = [ lines objectAtIndex : index ];
				
				// set character coordinates
				
				for ( int character = 0;
						  character < [ line count ] ;
						  character ++ )
				{
				
					[ [ [ line objectAtIndex : character ] rectangle ] setX : fabs( startX ) ];
					[ [ [ line objectAtIndex : character ] rectangle ] setY : fabs( startY ) ];
					
					// increase horizontal position
					
					startX += [ [ [ line objectAtIndex : character ] rectangle ] width ] + theLetterGap;
				
				}
				
				// increase vertical position
				
				startY += height + theLineGap;
			
			}
			
			[ lines release ];
			[ widths release ];
			[ heights release ];
			
		}
		
		return letters;
	
	}


	@end
