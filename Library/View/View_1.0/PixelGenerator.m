//
//  LabelGenerator.m
//  GameControl
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//

#import "PixelGenerator.h"

@implementation PixelGenerator


    #define kLineGap    10
    #define kWordGap    10
    #define kLetterGap  2


    static NSMutableDictionary* letterMap; 


    // static initializator
    // building up pixel font maps

    + ( void ) initialize
    {
    
        // NSLog( @"TextGenerator initialize" );
    
        letterMap = [ [ NSMutableDictionary alloc ] init ];
    
        [ letterMap setObject : @"111 101 111 101 101"            forKey: @"A" ];
        [ letterMap setObject : @"111 101 110 101 111"            forKey: @"B" ];
        [ letterMap setObject : @"111 100 100 100 111"            forKey: @"C" ];
        [ letterMap setObject : @"110 101 101 101 110"            forKey: @"D" ];
        [ letterMap setObject : @"111 100 111 100 111"            forKey: @"E" ];
        [ letterMap setObject : @"111 100 111 100 100"            forKey: @"F" ];
        [ letterMap setObject : @"111 100 101 101 111"            forKey: @"G" ];
        [ letterMap setObject : @"101 101 111 101 101"            forKey: @"H" ];
        [ letterMap setObject : @"1 1 1 1 1"                      forKey: @"I" ];
        [ letterMap setObject : @"001 001 001 101 111"            forKey: @"J" ];
        [ letterMap setObject : @"101 101 110 101 101"            forKey: @"K" ];
        [ letterMap setObject : @"100 100 100 100 111"            forKey: @"L" ];
        [ letterMap setObject : @"11111 10101 10101 10101 10101"  forKey: @"M" ];
        [ letterMap setObject : @"111 101 101 101 101"            forKey: @"N" ];
        [ letterMap setObject : @"111 101 101 101 111"            forKey: @"O" ];
        [ letterMap setObject : @"111 101 111 100 100"            forKey: @"P" ];
        [ letterMap setObject : @"111 101 101 101 111 001"        forKey: @"Q" ];
        [ letterMap setObject : @"111 101 110 101 101"            forKey: @"R" ];
        [ letterMap setObject : @"111 100 111 001 111"            forKey: @"S" ];
        [ letterMap setObject : @"111 010 010 010 010"            forKey: @"T" ];
        [ letterMap setObject : @"101 101 101 101 111"            forKey: @"U" ];
        [ letterMap setObject : @"101 101 101 101 010"            forKey: @"V" ];
        [ letterMap setObject : @"10101 10101 10101 10101 11111"  forKey: @"W" ];
        [ letterMap setObject : @"101 101 010 101 101"            forKey: @"X" ];
        [ letterMap setObject : @"101 101 111 010 010"            forKey: @"Y" ];
        [ letterMap setObject : @"111 001 111 100 111"            forKey: @"Z" ];
        [ letterMap setObject : @"010 101 101 101 010"            forKey: @"0" ];
        [ letterMap setObject : @"01 11 01 01 01"                 forKey: @"1" ];
        [ letterMap setObject : @"110 001 010 100 111"            forKey: @"2" ];
        [ letterMap setObject : @"110 001 110 001 110"            forKey: @"3" ];
        [ letterMap setObject : @"100 101 111 010 010"            forKey: @"4" ];
        [ letterMap setObject : @"111 100 111 001 110"            forKey: @"5" ];
        [ letterMap setObject : @"011 100 111 101 111"            forKey: @"6" ];
        [ letterMap setObject : @"111 001 011 001 001"            forKey: @"7" ];
        [ letterMap setObject : @"111 101 111 101 111"            forKey: @"8" ];
        [ letterMap setObject : @"111 101 111 001 111"            forKey: @"9" ];
        [ letterMap setObject : @"0 0 0 0 1"                      forKey: @"." ];
        [ letterMap setObject : @"1 1 1 0 1"                      forKey: @"!" ];
        [ letterMap setObject : @"0 1 0 1 0"                      forKey: @":" ];
        [ letterMap setObject : @"0 0 0 0 0"                      forKey: @" " ];
        [ letterMap setObject : @"001 001 010 100 100"            forKey: @"/" ];
        [ letterMap setObject : @"000 000 111 000 000"            forKey: @"-" ];
        [ letterMap setObject : @"000 010 111 010 000"            forKey: @"+" ];
        [ letterMap setObject : @"001 010 100 010 001"            forKey: @"l" ];
        [ letterMap setObject : @"100 010 001 010 100"            forKey: @"r" ];
        [ letterMap setObject : @"00000 00100 01010 10001 00000"  forKey: @"u" ];
        [ letterMap setObject : @"00000 10001 01010 00100 00000"  forKey: @"d" ];
        [ letterMap setObject : @"1111 1000 1000 1000 0000"       forKey: @"<" ];
        [ letterMap setObject : @"1111 0001 0001 0001 0000"       forKey: @">" ];
    
    }
    
    
    // pixelizes one letter
    // gets its pixel map from letterMap
    // generates x, y positions based on toPosition and pixel map
    
    + ( void )  pixelizeLetter : ( NSString*        ) pLetter
                toPosition     : ( float*           ) pPosition
                toArray        : ( NSMutableArray*  ) pTargetArray
                blockSize      : ( float            ) pBlockSize
    {
    
        // NSLog( @"LabelGenerator pixelizeLetter %@" , pLetter );
    
        // get pixelmap and break it to rows

        NSString* pixelMap   = [ letterMap  objectForKey                : pLetter ];    // retain stays
        NSArray*  pixelRows  = [ pixelMap   componentsSeparatedByString : @" " ];       // autorelease
        
        // looping through pixel rows
        
        for ( int rowIndex = 0 ;
                  rowIndex < [ pixelRows count ] ;
                  rowIndex ++ )
        {
        
            NSString* actualRow = [ pixelRows objectAtIndex : rowIndex ];               // retain stays
            
            // looping through pixels
            
            for ( int pixelIndex = 0 ;
                      pixelIndex < [ actualRow length ] ;
                      pixelIndex ++ )
            {
            
                if ( [ actualRow characterAtIndex : pixelIndex ] == *"1" )
                {
                
                    float x = *pPosition + pixelIndex * pBlockSize;
                    float y = rowIndex * pBlockSize;

                    NSNumber* positionX = [ [ NSNumber alloc ] initWithFloat : x ];
                    NSNumber* positionY = [ [ NSNumber alloc ] initWithFloat : y ];
                    NSArray*  pixel     = [ [ NSArray  alloc ] initWithObjects : positionX , positionY , nil ];
                                                                  
                    [ pTargetArray addObject : pixel ];
                    
                    // release block instances
                    
                    [ positionX release ];
                    [ positionY release ];
                    [ pixel     release ];
                
                }
            
            }
        
        }   
        
        // increase position
        
        *pPosition += [ [ pixelRows objectAtIndex : 0 ] length ] * pBlockSize + kLetterGap;
    
    }
    
    
    // pixelizes multiple words
    // loops through words
    // loops through word letters
    // stores word width and pixeldata
    
    + ( void )  pixelizeWords    : ( NSArray*        ) pStringWords
                blockSize        : ( float           ) pBlockSize
                toPixelWordArray : ( NSMutableArray* ) pPixelWordArray
    {
    
        // NSLog( @"LabelGenerator pixelizeWords %@" , pStringWords );

        // looping through words, generating pixel positions
        
        for ( int wordIndex = 0 ; 
                  wordIndex < [ pStringWords count ];
                  wordIndex++ )
        {
            
            float           position    = 0;
            NSString*       actualWord  = [ pStringWords objectAtIndex : wordIndex ];   // retain stays
            NSMutableArray* pixelWord   = [ [ NSMutableArray alloc ] init ];            // release!!!
            
            // looping through letters

            for ( int letterIndex = 0 ; 
                      letterIndex < [ actualWord length ] ; 
                      letterIndex ++ )
            {

                unichar   actualChar  = [ actualWord characterAtIndex : letterIndex ];
                NSString* charString  = [ NSString   stringWithFormat : @"%C" , actualChar ];   // autorelease

                [ self  pixelizeLetter  : charString 
                        toPosition      : &position
                        toArray         : pixelWord
                        blockSize       : pBlockSize ];
                                                
            }
                           
            [ pPixelWordArray addObject : pixelWord ];
            
            // release block instances
			
			[ pixelWord release ];
            
        }
    
    }
    
    
    // measures words, puts result to metrics array
    
    + ( void )  measureWords    : ( NSArray*        ) pStringWords
                blockSize       : ( float           ) pBlockSize
                toMetricsArray  : ( NSMutableArray* ) pMetricsArray
    {
    
        // NSLog( @"LabelGenerator measureWords %@" , pStringWords );

        for ( int wordIndex = 0 ; 
                  wordIndex < [ pStringWords count ];
                  wordIndex++ )
        {
            
            float           wordWidth   = 0;
            float           wordHeight  = 0;
            NSString*       actualWord  = [ pStringWords objectAtIndex : wordIndex ];   // retain stays
            
            // looping through letters

            for ( int letterIndex = 0 ; 
                      letterIndex < [ actualWord length ] ; 
                      letterIndex ++ )
            {

                unichar   actualChar  = [ actualWord characterAtIndex : letterIndex ];
                NSString* letter      = [ NSString   stringWithFormat : @"%C" , actualChar ];   // autorelease
                NSString* pixelMap    = [ letterMap  objectForKey     : letter ];               // reatin stays
                NSArray*  pixelRows   = [ pixelMap   componentsSeparatedByString : @" " ];      // autorelease

                int columns = [ [ pixelRows objectAtIndex : 0 ] length ];
                int rows    = [ pixelRows count ];

                wordWidth += columns * pBlockSize + kLetterGap;
                wordHeight = rows * pBlockSize;
                                                
            }
            
            NSNumber* width  = [ [ NSNumber alloc ] initWithFloat   : wordWidth - kLetterGap ]; // needs release
            NSNumber* height = [ [ NSNumber alloc ] initWithFloat   : wordHeight ];             // needs release
            NSArray* metrics = [ [ NSArray  alloc ] initWithObjects : width , height , nil ];   // needs release
                           
            [ pMetricsArray addObject : metrics ];
			
            // release block instances
            
			[ width release ];
			[ height release ];
			[ metrics release ];
            
        }

    }
    
    
    // breaks word pixel datas into arrays, stores words per line and line size
    
    + ( void )  breakWords  : ( NSMutableArray* ) pPixelWords
                wordSizes   : ( NSMutableArray* ) pPixelWordSizes
                toLines     : ( NSMutableArray* ) pLines
                andSizes    : ( NSMutableArray* ) pSizes
                inRectangle : ( CGRect          ) pRectangle
    {
    
        // NSLog( @"LabelGenerator breakWords wordWidths %@ toLines andSizes" , pPixelWordSizes );
        
        float           actualWidth  = 0;
        float           actualHeight = 0;
        NSMutableArray* actualLine   = [ [ NSMutableArray alloc ] init ];   // needs release
        
        for ( int wordIndex = 0 ;
                  wordIndex < [ pPixelWords count ] ;
                  wordIndex ++ )
        {
        
            NSArray* wordSize = [ pPixelWordSizes objectAtIndex : wordIndex ];  // retain stays
            
            float pixelWordWidth  = [ [ wordSize objectAtIndex : 0 ] floatValue ];
            float pixelWordHeight = [ [ wordSize objectAtIndex : 1 ] floatValue ];
        
            if ( actualWidth + pixelWordWidth > pRectangle.size.width )
            {
            
                // create new line
                
                NSNumber* width  = [ [ NSNumber alloc ] initWithFloat   : actualWidth - kWordGap ]; // needs release
                NSNumber* height = [ [ NSNumber alloc ] initWithFloat   : pixelWordHeight ];        // needs release
                NSArray*  size   = [ [ NSArray  alloc ] initWithObjects : width , height , nil ];   // needs release
                            
                [ pLines addObject : actualLine ];
                [ pSizes addObject : size ];
                
				[ actualLine release ];
                actualLine  = [ [ NSMutableArray alloc ] init ];    // needs release
                actualWidth = 0;
                
                // release block instances
                
                [ width  release ];
                [ height release ];
                [ size   release ];
            
            }
            
            // add word to actual line
        
            [ actualLine addObject : [ NSNumber numberWithInt : wordIndex ] ];
            
            actualWidth += pixelWordWidth + kWordGap;
            actualHeight = pixelWordHeight;
        
        }
        
        if ( [ actualLine count ] > 0 )
        {

            NSNumber* width  = [ [ NSNumber alloc ] initWithFloat   : actualWidth - kWordGap ];     // needs release
            NSNumber* height = [ [ NSNumber alloc ] initWithFloat   : actualHeight ];               // needs release
            NSArray*  size   = [ [ NSArray  alloc ] initWithObjects : width , height , nil ];       // needs release

            [ pLines addObject : actualLine ];
            [ pSizes addObject : size ];
            
            // release block instances
                    
            [ width  release ];
            [ height release ];
            [ size   release ];

        }

        // release block instances
		
		[ actualLine release ];
        
    }
    
    
    // align word pixel data in lines horizontally and verically
    // generates final pixel array
    
    + ( void )  alignWords  : ( NSMutableArray* ) pPixelWords
                wordSizes   : ( NSMutableArray* ) pPixelWordSizes
                toLines     : ( NSMutableArray* ) pLines
                withSizes   : ( NSMutableArray* ) pSizes
                inRectangle : ( CGRect          ) pRectangle
                toArray     : ( NSMutableArray* ) pTargetArray
    {
    
        // NSLog( @"LabelGenerator alignPixelsInLines toLines %@" , pLines );
    
        // calculate full height
    
        float fullHeight = 0;
        
        for ( int lineIndex = 0 ;
                  lineIndex < [ pSizes count ] ;
                  lineIndex ++ )
        {
        
            NSArray* lineSize = [ pSizes objectAtIndex : lineIndex ];    // retain stays
            fullHeight += [ [ lineSize objectAtIndex : 1 ] floatValue ];
        
        }
        
        // loop through lines, align words
        
        float startingX = 0;
        float startingY = ( pRectangle.size.height - fullHeight ) / 2;
        
        for ( int lineIndex = 0 ; 
                  lineIndex < [ pLines count ] ;
                  lineIndex ++ )
        {
        
            NSArray*        lineSize = [ pSizes objectAtIndex : lineIndex ];        // retain stays
            float           lineWidth       = [ [ lineSize objectAtIndex : 0 ] floatValue ];
            float           lineHeight      = [ [ lineSize objectAtIndex : 1 ] floatValue ];;
            NSMutableArray* lineWordIndexes = [ pLines objectAtIndex : lineIndex ]; // retain stays
            
            startingX = ( pRectangle.size.width - lineWidth ) / 2;
            
            for ( int wordIndex = 0 ;
                      wordIndex < [ lineWordIndexes count ] ;
                      wordIndex ++ )
            {
            
                int             actualIndex  = [ [ lineWordIndexes objectAtIndex : wordIndex ] intValue ];
                NSMutableArray* actualPixels = [ pPixelWords objectAtIndex : actualIndex ]; // retain stays
                
                for ( int pixelIndex = 0 ;
                          pixelIndex < [ actualPixels count ] ;
                          pixelIndex ++ )
                {
                
                    NSArray* actualPixel = [ actualPixels objectAtIndex : pixelIndex ];     // retain stays
                
                    float positionX = [ [ actualPixel objectAtIndex : 0 ] floatValue ];
                    float positionY = [ [ actualPixel objectAtIndex : 1 ] floatValue ];
                    
                    NSNumber* finalX     = [ [ NSNumber alloc ] initWithFloat : floorf( startingX + positionX ) ];  // needs release
                    NSNumber* finalY     = [ [ NSNumber alloc ] initWithFloat : floorf( startingY + positionY ) ];  // needs release
                    NSArray*  finalPixel = [ [ NSArray  alloc ] initWithObjects : finalX , finalY , nil ];       // needs release
                                               
                    [ pTargetArray addObject : finalPixel ];
                    
                    // release block instances
                    
                    [ finalX     release ];
                    [ finalY     release ];
                    [ finalPixel release ];
                    
                }
                
                NSArray* wordSize = [ pPixelWordSizes objectAtIndex : wordIndex ];  // retain stays
                startingX += [ [ wordSize objectAtIndex : 0 ] floatValue ] + kWordGap;
            
            }
            
            startingY += lineHeight + kLineGap;
        
        }        
    
    }
    
    
    // generates pixel font data array
    
    + ( void )  generateText   : ( NSString*        ) pString
                inRectangle    : ( CGRect           ) pRect
                blockSize      : ( float            ) pSize
                toArray        : ( NSMutableArray*  ) pTargetArray
    {
    
        // NSLog( @"LabelGenerator generateText" );
        
        // first measure word dimensions

        NSArray*        stringWords    = [ pString componentsSeparatedByString : @" " ]; // autorelease
        NSMutableArray* pixelWordSizes = [ [ NSMutableArray alloc ] init ];              // needs release
        
        [ self  measureWords    : stringWords 
                blockSize       : pSize 
                toMetricsArray  : pixelWordSizes ];
    
        // second generate pixel arrays per words
    
        NSMutableArray* pixelWords  = [ [ NSMutableArray alloc ] init ]; // needs release
        
        [ self  pixelizeWords     : stringWords 
                blockSize         : pSize 
                toPixelWordArray  : pixelWords ];
                
        // third, break words to lines
        
        NSMutableArray* lines       = [ [ NSMutableArray alloc ] init ]; // needs release
        NSMutableArray* sizes       = [ [ NSMutableArray alloc ] init ]; // needs release
        
        [ self  breakWords  : pixelWords 
                wordSizes   : pixelWordSizes
                toLines     : lines
                andSizes    : sizes 
                inRectangle : pRect ];
                
        // fourth, align word pixel data based on word positions, and generate final positions
        
        [ self  alignWords  : pixelWords
                wordSizes   : pixelWordSizes
                toLines     : lines 
                withSizes   : sizes 
                inRectangle : pRect 
                toArray     : pTargetArray ];
                
        // release block instances
        
        [ lines release ];
        [ sizes release ];
        
        [ pixelWords     release ];
        [ pixelWordSizes release ];        
    
    }


@end
