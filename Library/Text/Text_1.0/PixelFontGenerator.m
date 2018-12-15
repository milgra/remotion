//
//  LetterMap.m
//  MemeBox
//
//  Created by Milán Tóth on 5/18/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "PixelFontGenerator.h"


	@implementation PixelFontGenerator


	static NSMutableDictionary* letterMap; 
	static NSMutableDictionary* sizeCache; 
	static NSMutableDictionary* pixelCache; 

    + ( void ) initialize
    {
	
		// NSLog( @"PixelFontGenerator initialize" );
    
		letterMap  = [ [ NSMutableDictionary alloc ] init ];
		sizeCache  = [ [ NSMutableDictionary alloc ] init ];
		pixelCache = [ [ NSMutableDictionary alloc ] init ];
	
		[ letterMap setObject : @"000 111 101 111 101 101"              forKey: @"A" ];
		[ letterMap setObject : @"010 111 101 111 101 101"              forKey: @"Á" ];
		[ letterMap setObject : @"000 110 101 110 101 110"              forKey: @"B" ];
		[ letterMap setObject : @"000 111 100 100 100 111"              forKey: @"C" ];
		[ letterMap setObject : @"000 110 101 101 101 110"              forKey: @"D" ];
		[ letterMap setObject : @"000 111 100 111 100 111"              forKey: @"E" ];
		[ letterMap setObject : @"010 111 100 111 100 111"              forKey: @"É" ];
		[ letterMap setObject : @"000 111 100 111 100 100"              forKey: @"F" ];
		[ letterMap setObject : @"000 111 100 101 101 111"              forKey: @"G" ];
		[ letterMap setObject : @"000 101 101 111 101 101"              forKey: @"H" ];
		[ letterMap setObject : @"0 1 1 1 1 1"                          forKey: @"I" ];
		[ letterMap setObject : @"1 0 1 1 1 1"                          forKey: @"Í" ];
		[ letterMap setObject : @"000 001 001 001 101 111"              forKey: @"J" ];
		[ letterMap setObject : @"000 101 101 110 101 101"              forKey: @"K" ];
		[ letterMap setObject : @"000 100 100 100 100 111"              forKey: @"L" ];
		[ letterMap setObject : @"00000 11111 10101 10101 10101 10101"  forKey: @"M" ];
		[ letterMap setObject : @"000 111 101 101 101 101"              forKey: @"N" ];
		[ letterMap setObject : @"000 111 101 101 101 111"              forKey: @"O" ];
		[ letterMap setObject : @"010 111 101 101 101 111"              forKey: @"Ó" ];
		[ letterMap setObject : @"101 000 111 101 101 111"              forKey: @"Ö" ];
		[ letterMap setObject : @"101 111 101 101 101 111"              forKey: @"Ő" ];
		[ letterMap setObject : @"000 111 101 111 100 100"              forKey: @"P" ];
		[ letterMap setObject : @"000 111 101 101 101 111 001"          forKey: @"Q" ];
		[ letterMap setObject : @"000 111 101 110 101 101"              forKey: @"R" ];
		[ letterMap setObject : @"000 111 100 111 001 111"              forKey: @"S" ];
		[ letterMap setObject : @"000 111 010 010 010 010"              forKey: @"T" ];
		[ letterMap setObject : @"000 101 101 101 101 111"              forKey: @"U" ];
		[ letterMap setObject : @"010 101 101 101 101 111"              forKey: @"Ú" ];
		[ letterMap setObject : @"101 000 101 101 101 111"              forKey: @"Ü" ];
		[ letterMap setObject : @"101 101 101 101 101 111"              forKey: @"Ű" ];
		[ letterMap setObject : @"000 101 101 101 101 010"              forKey: @"V" ];
		[ letterMap setObject : @"00000 10101 10101 10101 10101 11111"  forKey: @"W" ];
		[ letterMap setObject : @"000 101 101 010 101 101"              forKey: @"X" ];
		[ letterMap setObject : @"000 101 101 111 010 010"              forKey: @"Y" ];
		[ letterMap setObject : @"000 111 001 111 100 111"              forKey: @"Z" ];
		[ letterMap setObject : @"000 010 101 101 101 010"              forKey: @"0" ];
		[ letterMap setObject : @"00 01 11 01 01 01"                    forKey: @"1" ];
		[ letterMap setObject : @"000 110 001 010 100 111"              forKey: @"2" ];
		[ letterMap setObject : @"000 110 001 110 001 110"              forKey: @"3" ];
		[ letterMap setObject : @"000 100 101 111 010 010"              forKey: @"4" ];
		[ letterMap setObject : @"000 111 100 111 001 110"              forKey: @"5" ];
		[ letterMap setObject : @"000 011 100 111 101 111"              forKey: @"6" ];
		[ letterMap setObject : @"000 111 001 011 001 001"              forKey: @"7" ];
		[ letterMap setObject : @"000 111 101 111 101 111"              forKey: @"8" ];
		[ letterMap setObject : @"000 111 101 111 001 111"              forKey: @"9" ];
		[ letterMap setObject : @"0 0 0 0 0 1"                          forKey: @"." ];
		[ letterMap setObject : @"0 1 1 1 0 1"                          forKey: @"!" ];
		[ letterMap setObject : @"0 0 1 0 1 0"                          forKey: @":" ];
		[ letterMap setObject : @"0 0 0 0 0 0"                          forKey: @" " ];
		[ letterMap setObject : @"000 001 001 010 100 100"              forKey: @"/" ];
		[ letterMap setObject : @"000 000 000 111 000 000"              forKey: @"-" ];
		[ letterMap setObject : @"000 000 010 111 010 000"              forKey: @"+" ];
		[ letterMap setObject : @"000 001 010 100 010 001"              forKey: @"l" ];
		[ letterMap setObject : @"000 100 010 001 010 100"              forKey: @"r" ];
		[ letterMap setObject : @"00000 00000 00100 01010 10001 00000"  forKey: @"u" ];
		[ letterMap setObject : @"00000 00000 10001 01010 00100 00000"  forKey: @"d" ];
		[ letterMap setObject : @"0000 1111 1000 1000 1000 0000"        forKey: @"<" ];
		[ letterMap setObject : @"0000 1111 0001 0001 0001 0000"        forKey: @">" ];        
		[ letterMap setObject : @"00 00 00 00 00 00"					forKey: @" " ];
    
    }


	// creates pixels
	
	+ ( void ) generatePixels	: ( NSString* ) theLetter
			   gridSize			: ( float	  ) theGridSize
			   pixelSize		: ( float	  ) thePixelSize
	{
	
		// NSLog( @"PixelFontgenerator generatePixels %@ withSize %f" , pLetter , pPixelSize );

		// get pixelmap and break it to rows

		NSString*		pixelMap	= [ letterMap objectForKey : theLetter ];				// retain stays
		NSArray*		pixelRows	= [ pixelMap componentsSeparatedByString : @" " ];		// autorelease
		NSMutableArray* pixels		= [ [ NSMutableArray alloc ] init ];
		
		// looping through pixel rows
		
		for ( int rowIndex = 0 ;
				  rowIndex < [ pixelRows count ] ;
				  rowIndex ++ )
		{
		
			NSString* actualRow = [ pixelRows objectAtIndex : rowIndex ];					// retain stays
			
			// looping through pixels
			
			for ( int colIndex = 0 ;
					  colIndex < [ actualRow length ] ;
					  colIndex ++ )
			{
			
				if ( [ actualRow characterAtIndex : colIndex ] == *"1" )
				{
				
					Rectangle* rectangle = [ [ Rectangle alloc ] init ];
				
					[ rectangle setX		: colIndex * theGridSize ];
					[ rectangle setY		: rowIndex * theGridSize ];
					[ rectangle setWidth	: theGridSize ];
					[ rectangle setHeight	: theGridSize ];

					[ pixels addObject : rectangle ];
					
					[ rectangle release ];
				
				}
			
			}
		
		}
		
		// calculate pixel array dimensions
		
		Rectangle* size = [ [ Rectangle alloc ] init ];
		
		[ size setWidth		: [ [ pixelRows objectAtIndex : 0 ] length ] * thePixelSize ];
		[ size setHeight	: [ pixelRows count ] * thePixelSize ];
		
		[ pixelCache	setObject : pixels 
						forKey	  : theLetter ];	// retain
		[ sizeCache		setObject : size
						forKey	  : theLetter ];	// retain
		
		[ pixels		release ];                  // release
		[ size			release ];                  // release
	
	}

    
    // creates a letter
    
    + ( PixelFont* )	createLetter : ( NSString* ) theLetter
						gridSize	 : ( float	   ) theGridSize
						pixelSize    : ( float     ) thePixelSize;
    {
	
		// NSLog( @"LetterGenerator createLetter %@ pixelSize %f" , pLetter , pPixelSize );
		
		PixelFont*	letter		= [ [ PixelFont alloc ] init ];	// needs release outside

		// getting cached pixels and rectangle
		
		NSArray*	pixels		= [ pixelCache objectForKey : theLetter ];
		Rectangle*	rectangle	= [ sizeCache  objectForKey : theLetter ];
		
		// if not cached, force generation
		
		if ( pixels == nil )
		{

			[ self	generatePixels  : theLetter
					gridSize		: theGridSize
					pixelSize		: thePixelSize ];
		
			pixels		= [ pixelCache objectForKey : theLetter ];
			rectangle	= [ sizeCache  objectForKey : theLetter ];
			
		}
		
		// setup letter
		
		Rectangle* letterRectangle = [ [ Rectangle alloc ] initWithRectangle : rectangle ];
		
		[ letter setPixels		: pixels ];
		[ letter setCharacter	: theLetter ];
		[ letter setRectangle	: letterRectangle ];
		
		[ letterRectangle release ];
		
		return letter;

    }
	
	
@end
