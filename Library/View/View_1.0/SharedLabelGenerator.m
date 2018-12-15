//
//  SharedLabelGenerator.m
//  GameControl
//
//  Created by Milan Toth on 2/18/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//

#import "SharedLabelGenerator.h"


    @implementation SharedLabelGenerator


    #ifdef BUILD_TARGET_OSX
    + ( NSImage* )  generateImage : ( NSString*  ) pLabel
    #else
    + ( UIImage* )  generateImage : ( NSString*  ) pLabel
    #endif
					withColorA	  : ( float*	 ) pColorA
					withColorB	  : ( float*	 ) pColorB
                    inRectangle   : ( CGRect     ) pRect
                    hasBackground : ( BOOL       ) pFlag;
	{
	
		// NSLog( @"LabelGenerator generateImage" );
        
        // create image

        #ifdef BUILD_TARGET_OSX
		NSImage* image = [ [ [ NSImage alloc ] initWithSize : pRect.size ] autorelease ];   // auto release
        #else
        UIImage* image;
        #endif
        
        // start drawing

        #ifdef BUILD_TARGET_OSX
		[ image lockFocus ];
        #else
        UIGraphicsBeginImageContext( pRect.size );
        #endif
		{
        
            // get context
		
            #ifdef BUILD_TARGET_OSX
			CGContextRef        context      = [ [ NSGraphicsContext currentContext ] graphicsPort ];
            CGAffineTransform   flipVertical = CGAffineTransformMake( 1 , 0 , 0 , -1 , 1 , pRect.size.height );
            CGContextConcatCTM(context, flipVertical);              
            #else
            CGContextRef		context = UIGraphicsGetCurrentContext();
            UIGraphicsPushContext( context );
            #endif
            
            // prepare colors and locations

			CGPoint 		pointA;
			CGPoint 		pointB;

			CGFloat 		locations [2] 	= { 1.0 , 0.0 };
			CGFloat 		components[8] 	= { pColorA[ 0 ] , 
												pColorA[ 1 ] , 
												pColorA[ 2 ] , 
												pColorA[ 3 ] , 
												pColorB[ 0 ] , 
												pColorB[ 1 ] , 
												pColorB[ 2 ] ,
												pColorB[ 3 ] };
                                                
			CGColorSpaceRef colorspace 		= CGColorSpaceCreateDeviceRGB( );
			CGGradientRef 	myGradient 		= CGGradientCreateWithColorComponents( 	colorspace , 
																					components , 
																					locations  , 
																					( size_t ) 2 );

			pointA.x = 0.0;
			pointA.y = 0.0;
			pointB.x = pRect.size.width;
			pointB.y = pRect.size.height;
            
            // draw background if needed
            
            if ( pFlag )
            {

                CGContextDrawLinearGradient( context 	, 
                                             myGradient	, 
                                             pointA 	, 
                                             pointB 	, 
                                             0			); 
                                         
            }
            
            // generate blocks for label
            
            NSMutableArray* pixels = [ [ NSMutableArray alloc ] init ];	// needs release

            [ PixelGenerator generateText : pLabel 
                             inRectangle  : pRect 
                             blockSize    : 3 
                             toArray      : pixels ];

            #ifdef BUILD_TARGET_OSX
            [ [ NSColor whiteColor ] set ];
            #else
            [ [ UIColor whiteColor ] set ];
            #endif

            CGFloat		colorValues[ ]	= { 1.0f , 1.0f , 1.0f , 2.0f };
            CGColorRef  glowColor       = CGColorCreate( colorspace , colorValues );
            
            CGContextSetShadowWithColor( context , CGSizeMake( 0.0, 0.0 ) , 5.0 , glowColor );

            // draw blocks

            for ( NSArray* pixel in pixels )
            {
            
                float x = [ [ pixel objectAtIndex : 0 ] floatValue ];
                float y = [ [ pixel objectAtIndex : 1 ] floatValue ];

                CGRect rect = CGRectMake( x , y , 3 , 3 );
                CGContextFillRect( context , rect );

            }

            #ifdef BUILD_TARGET_IOS
            UIGraphicsPopContext();
            image = UIGraphicsGetImageFromCurrentImageContext( );   // auto release
            #endif
			
			// release block instances
			
			[ pixels release ];
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