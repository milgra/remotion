//
//  main.m
//  Remotion
//
//  Created by Milan Toth on 3/9/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.
//

#import <UIKit/UIKit.h>


    int main (  int     theCount , 
                char*   theWords [ ] )
    {
        
        NSAutoreleasePool *pool = [ [ NSAutoreleasePool alloc ] init ];
        
        int result = UIApplicationMain( theCount , 
                                        theWords , 
                                        nil      , 
                                        @"Delegate" );
        
        [ pool release ];
        
        return result;
        
    }
