//  ButtonInjector.h
//  Remotion
//
//  Created by Milan Toth on 3/1/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import <Foundation/Foundation.h>
	#import "EventDelegate.h"
	#import "Protocol.h"


	#define kButtonInjectorEventLeftMouseDown 0
	#define kButtonInjectorEventLeftMouseUp	  1


	@interface ButtonInjector : NSObject
	{
	
		id < EventDelegate > delegate;
	
	}


	- ( id	 ) initWithDelegate : ( id	  ) theDelegate;
	- ( void ) updateButton		: ( void* ) theData;


	@end