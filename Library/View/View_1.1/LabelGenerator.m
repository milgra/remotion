//  LabelGenerator.m
//  Remotion
//
//  Created by Milan Toth on 2/18/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "LabelGenerator.h"


    @implementation LabelGenerator


    #ifdef BUILD_TARGET_OSX
    + ( NSImage* )  generateImage : ( NSString*  ) theLabel
    #else
    + ( UIImage* )  generateImage : ( NSString*  ) theLabel
    #endif
					withColorA	  : ( float*	 ) theColorA
					withColorB	  : ( float*	 ) theColorB
                    inRectangle   : ( CGRect     ) theRect
                    hasBackground : ( BOOL       ) theFlag;
	{
	
		// NSLog( @"LabelGenerator generateImage" );
        
        // create image

        #ifdef BUILD_TARGET_OSX
		NSRect rectangle = NSRectFromCGRect( theRect );
		NSImage* image = [ [ [ NSImage alloc ] initWithSize : rectangle.size ] autorelease ];   // auto release
        #else
        UIImage* image;
        #endif
        
        // start drawing

        #ifdef BUILD_TARGET_OSX
		[ image lockFocus ];
        #else
        UIGraphicsBeginImageContext( theRect.size );
        #endif
		{
        
            // get context
		
            #ifdef BUILD_TARGET_OSX
			CGContextRef        context      = [ [ NSGraphicsContext currentContext ] graphicsPort ];
            CGAffineTransform   flipVertical = CGAffineTransformMake( 1 , 0 , 0 , -1 , 1 , theRect.size.height );
            CGContextConcatCTM(context, flipVertical);              
            #else
            CGContextRef		context = UIGraphicsGetCurrentContext();
            UIGraphicsPushContext( context );
            #endif
            
            // prepare colors and locations

			CGPoint 		pointA;
			CGPoint 		pointB;

			CGFloat 		locations [2] 	= { 1.0 , 0.0 };
			CGFloat 		components[8] 	= { theColorA[ 0 ] , 
												theColorA[ 1 ] , 
												theColorA[ 2 ] , 
												theColorA[ 3 ] , 
												theColorB[ 0 ] , 
												theColorB[ 1 ] , 
												theColorB[ 2 ] ,
												theColorB[ 3 ] };
                                                
			CGColorSpaceRef colorspace 		= CGColorSpaceCreateDeviceRGB( );
			CGGradientRef 	myGradient 		= CGGradientCreateWithColorComponents( 	colorspace , 
																					components , 
																					locations  , 
																					( size_t ) 2 );

			pointA.x = 0.0;
			pointA.y = 0.0;
			pointB.x = theRect.size.width;
			pointB.y = theRect.size.height;
            
            // draw background if needed
            
            if ( theFlag )
            {

                CGContextDrawLinearGradient( context 	,
                                             myGradient	,
                                             pointA 	,
                                             pointB 	,
                                             0			); 
                                         
            }
            
            // generate blocks for label
            
            NSArray* letters;
			Rectangle* rectangle = [ [ Rectangle alloc ] init ];
			
			rectangle.x = 20;
			rectangle.y = 20;
			rectangle.width = theRect.size.width - 40;
			rectangle.height = theRect.size.height - 40;

			letters = [ PixelTextGenerator createLetters : theLabel
										   inFrame		 : rectangle
										   gridSize		 : 5
										   pixelSize	 : 6
										   letterGap	 : 3
										   lineGap		 : 6
										   horizontal	 : kTextGeneratorHorizontalAlignmentCenter
										   vertical		 : kTextGeneratorVerticalAlignmentCenter ];	// needs release

			[ rectangle release ];

            #ifdef BUILD_TARGET_OSX
            [ [ NSColor whiteColor ] set ];
            #else
            [ [ UIColor whiteColor ] set ];
            #endif

            CGFloat		colorValues[ ]	= { 0.0f , 0.0f , 0.0f , 1.5f };
            CGColorRef  glowColor       = CGColorCreate( colorspace , colorValues );
            
            CGContextSetShadowWithColor( context , CGSizeMake( 1.0, 1.0 ) , 5.0 , glowColor );
			CGContextBeginPath(context);

            // draw blocks

            for ( PixelFont* letter in letters )
            {
			
				for ( Rectangle* rectangle in [ letter pixels ] )
				{
            
					CGRect rect = CGRectMake(	letter.rectangle.x + rectangle.x , 
												letter.rectangle.y + rectangle.y , 
												6 , 
												6 );
					CGContextAddRect( context , rect );
					
				}

            }
			
			CGContextFillPath( context );
			
            #ifdef BUILD_TARGET_IOS
            UIGraphicsPopContext();
            image = UIGraphicsGetImageFromCurrentImageContext( );   // auto release
            #endif
			
			// release block instances
			
			[ letters release ];
			CGColorRelease( glowColor );
			CGGradientRelease( myGradient );
			CGColorSpaceRelease( colorspace );
			
		}
        #ifdef BUILD_TARGET_OSX
		[ image unlockFocus ];
        #else
        UIGraphicsEndImageContext();        
        #endif
		
		return image;
        
	}
    

	@end