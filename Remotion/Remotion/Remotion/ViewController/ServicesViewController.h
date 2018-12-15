//  ServicesViewController.h
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <UIKit/UIKit.h>
	#import "EventDelegate.h"
	#import "LabelGenerator.h"


    #define kServicesViewControllerEventSelect 0


    @interface ServicesViewController : UITableViewController
    {
    
        id < EventDelegate >    delegate;
        NSMutableArray*         imageList;
		NSArray*				dataList;
        
    }


    - ( id      ) initWithDelegate  : ( id       ) theDelegate;
    - ( void    ) setDataList       : ( NSArray* ) theDataList;


	@end
