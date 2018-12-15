//  ServicesViewController.m
//  Remotion
//
//  Created by Milan Toth on 2/19/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "ServicesViewController.h"


	@implementation ServicesViewController


    // constructor

    - ( id ) initWithDelegate : ( id ) theDelegate
    {
    
        // NSLog( @"ServicesViewController initWithDelegate %@" , pDelegate );

        self = [ super init ];
        
        if ( self )
        {
		
			// init
        
            delegate  = [ theDelegate retain ];				// needs release
            imageList = [ [ NSMutableArray alloc ] init ];  // needs release
        
        }
        
        return self;
        
    }
    
    
    // destructor
    
    - ( void ) dealloc
    {

        // NSLog( @"ServicesViewController dealloc" );
		
		// release
        
        [ delegate	release ];
        [ imageList release ];
    
        [ super		dealloc ];
    
    }
	
	
	// loads view
	
	- ( void ) loadView
	{

        // NSLog( @"ServicesViewController loadView" );
	
		[ super loadView ];
		
		float   colorA[ ] = { .1 , .8 , .1 , 1.0 };
        float   colorB[ ] = { .2 , .6 , .3 , 1.0 };
		
		CGRect	imageRect  = CGRectMake( 0 , 2 , 320 , 76 );
		CGRect	holderRect = CGRectMake( 0 , 0 , 320 , 80 );
			
		UIImage*		image = [ LabelGenerator    generateImage   : @"SELECT HOST"
													withColorA      : colorA 
													withColorB      : colorB 
													inRectangle     : imageRect
													hasBackground   : YES ];					// autorelease
  
		UIView*			headerHolder = [ [ UIView		alloc ] initWithFrame : holderRect ];	// needs release
		UIImageView*	imageView	 = [ [ UIImageView	alloc ] initWithImage : image ];		// needs release
		
		[ headerHolder addSubview : imageView ];
				
		[ [ self tableView ] setRowHeight		: 80 ];
		[ [ self tableView ] setSeparatorColor	: [ UIColor blackColor ] ];
		[ [ self tableView ] setBackgroundColor	: [ UIColor blackColor ] ];
		[ [ self tableView ] setTableHeaderView : headerHolder ];
		
		[ headerHolder	release ];
		[ imageView		release ];
	
	}
    
    
    // number of sections

    - ( NSInteger ) numberOfSectionsInTableView : ( UITableView* ) theView
    {
        
        return 1;
        
    }


    // number of rows

    - ( NSInteger ) tableView               : ( UITableView* ) theView 
                    numberOfRowsInSection   : ( NSInteger    ) theSection
    {
        
        return [ imageList count ];
        
    }


    // cell

    - ( UITableViewCell* )  tableView               : ( UITableView* ) theView
                            cellForRowAtIndexPath   : ( NSIndexPath* ) thePath
    {
        
        // NSLog( @"ServicesViewController tableView cellForRowIndex : %i" , indexPath.row );
        
        UITableViewCell* cell = [ self.tableView dequeueReusableCellWithIdentifier : @"cell" ];
        
        if ( cell == nil )
        {
            
            cell = [ [ [ UITableViewCell alloc ] initWithStyle   : UITableViewCellStyleDefault 
                                                 reuseIdentifier : @"cell" ] autorelease ];
            
            [ cell setFrame : CGRectMake( 0 , 0 , 320 , 80 ) ];
            
        }
        
        if ( thePath.row < [ imageList count ] )
        {
        
            // !!! TODO this seems shitty
            
            UIView* background  = ( UIView* ) [ imageList objectAtIndex : thePath.row ];	// retain stays

//            UIView* selected    = [ [ UIView alloc ] initWithFrame : background.frame  ];	// needs release
//            
//            [ selected setBackgroundColor : [ UIColor   colorWithRed    : .4 
//                                                        green           : .4 
//                                                        blue            : .1 
//                                                        alpha           : .4 ] ];
            
			[ [ cell contentView ] addSubview : background ];
			[ cell setSelectionStyle : UITableViewCellEditingStyleNone ];
            
//            [ selected release ];
            
        }
        
        return cell;
        
    }


    // selection happened

    - ( void )  tableView               : ( UITableView* ) theView 
                didSelectRowAtIndexPath : ( NSIndexPath* ) thePath
    {
        
        // NSLog( @"ServicesViewController tableView didSelectRowAtIndexPath" );
        
        NSNumber* indexNumber = [ [ NSNumber alloc ] initWithInt : thePath.row ];	// needs release
        
        [ delegate  eventArrived    : kServicesViewControllerEventSelect 
                    fromInstance    : self.view 
                    withUserData    : [ dataList objectAtIndex : [ indexNumber unsignedIntValue ] ] ];
                    
        [ indexNumber release ];
        
    }


    // sets data list, creating item images immediately

    - ( void ) setDataList : ( NSArray* ) theDataList
    {

        // NSLog( @"ServicesViewController setDataList %@" , pDataList );
		
		[ dataList release ];
		dataList = [ theDataList retain ];
            
        float   colorA[ ] = { .9 , .6 , .2 , 1.0 };
        float   colorB[ ] = { .8 , .5 , .1 , 1.0 };
        CGRect  frame     = CGRectMake( 0 , 2 , 320 , 76 );

        for ( int index = 0 ; index < [ dataList count ] ; index++ )
        {
		
			NSNetService* service = [ dataList objectAtIndex : index ];				// retain stays
        
            NSString*   label = [ [ service name ] uppercaseString ];					// autorelease
			
            UIImage*    image = [ LabelGenerator    generateImage   : label
													withColorA      : colorA 
                                                    withColorB      : colorB 
                                                    inRectangle     : frame 
                                                    hasBackground   : YES ];			// autorelease
            
            UIImageView* imageView = [ [ UIImageView alloc ] initWithImage : image ];	// needs release
            
            [ imageList addObject : imageView ];
            
            [ imageView release ];
        
        }    
    
    }
    
    
    // autorotate no

    - ( BOOL ) shouldAutorotateToInterfaceOrientation : ( UIInterfaceOrientation ) theOrientation
    {
    
        return ( theOrientation == UIInterfaceOrientationPortrait );
        
    }

    
	@end
