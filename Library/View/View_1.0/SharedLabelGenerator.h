//
//  SharedLabelGenerator.h
//  GameControl
//
//  Created by Milan Toth on 2/18/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//


    #import "PixelGenerator.h"

    #ifdef BUILD_TARGET_OSX
    #import <Foundation/Foundation.h>
    #import <AppKit/AppKit.h>
    #else
    #import <UIKit/UIKit.h>
    #endif


    @interface SharedLabelGenerator : NSObject


    #ifdef BUILD_TARGET_OSX
    + ( NSImage* )  generateImage : ( NSString*  ) pLabel
    #else
    + ( UIImage* )  generateImage : ( NSString*  ) pLabel
    #endif
					withColorA	  : ( float*	 ) pColorA
					withColorB	  : ( float*	 ) pColorB
                    inRectangle   : ( CGRect     ) pRect
                    hasBackground : ( BOOL       ) pFlag;

    @end
