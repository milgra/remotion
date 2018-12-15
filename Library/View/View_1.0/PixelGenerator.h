//
//  LabelGenerator.h
//  GameControl
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//

    #ifdef BUILD_TARGET_OSX
    #import <Foundation/Foundation.h>
    #else
    #import <UIKit/UIKit.h>
    #endif


    @interface PixelGenerator : NSObject


    + ( void )  generateText   : ( NSString*        ) pString
                inRectangle    : ( CGRect           ) pRect
                blockSize      : ( float            ) pSize
                toArray        : ( NSMutableArray*  ) pArray;

@end
