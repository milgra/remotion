//  LabelGenerator.h
//  Remotion
//
//  Created by Milan Toth on 2/18/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


    #import "PixelTextGenerator.h"
	#import "PixelFont.h"

	#ifdef BUILD_TARGET_OSX
	
    #import <Foundation/Foundation.h>
    #import <AppKit/AppKit.h>
	
	#else
	
    #import <UIKit/UIKit.h>
	
    #endif


    @interface LabelGenerator : NSObject


    #ifdef BUILD_TARGET_OSX
    + ( NSImage* )  generateImage : ( NSString*  ) theLabel
    #else
    + ( UIImage* )  generateImage : ( NSString*  ) theLabel
    #endif
					withColorA	  : ( float*	 ) theColorA
					withColorB	  : ( float*	 ) theColorB
                    inRectangle   : ( CGRect     ) theRect
                    hasBackground : ( BOOL       ) theFlag;


    @end
