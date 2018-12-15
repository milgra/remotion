//  AdressUtilities.m
//  Remotion
//
//  Created by Milan Toth on 2/25/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


	#import "AddressUtilities.h"


	@implementation AddressUtilities


    // converts address conversion

    + ( void )  convertAddress  : ( struct sockaddr_storage* ) theAddressFrom 
                toAddress       : ( struct sockaddr_storage* ) theAddressTo
                toFamily        : ( uint                     ) theFamily
    {

        // NSLog( @"UdpSocket convertAddress toAddress toFamily" );
    
        if ( theFamily == AF_INET6 )
        {
        
            if ( theAddressFrom->ss_family == AF_INET )
            {
            
                struct sockaddr_in*  sockaddr4       = ( struct sockaddr_in*  ) theAddressFrom;
                struct sockaddr_in6* sockaddr6		 = ( struct sockaddr_in6* ) theAddressTo;
                NSMutableString*     addressString   = [ NSMutableString stringWithString : @"::ffff:" ];
                char*                addressCString  = inet_ntoa( sockaddr4->sin_addr );
                
                sockaddr6->sin6_family = AF_INET6;
                sockaddr6->sin6_port   = sockaddr4->sin_port;
                sockaddr6->sin6_len    = sizeof( struct sockaddr_in6 );
                
                [ addressString appendString : [ NSString stringWithCString   : addressCString 
                                                          encoding            : NSASCIIStringEncoding ] ];
                
                addressCString = ( char * ) [ addressString cStringUsingEncoding : NSASCIIStringEncoding ];
                
                inet_pton( AF_INET6 , addressCString , &(sockaddr6->sin6_addr) );

            
            }
            else *theAddressTo = *theAddressFrom;
        
        }
        else
        {
        
            if ( theAddressFrom->ss_family == AF_INET6 )
            {
            
                NSLog( @"Cannot convert v6 address to v4!!!" );
            
            }
            else
			{
			
				// !!! TEST IT
				// *pAddressTo = *pAddressFrom;
				
				memcpy( theAddressTo , theAddressFrom , sizeof( struct sockaddr_storage ) );
			
			}

        }
    
//        NSLog( @"AddressUtilities convert : %@ to : %@" , 
//               [ self describeAddress : *pAddressFrom ] , 
//               [ self describeAddress : *pAddressTo   ] );

    }


    // shows address info

    + ( NSString* ) describeAddress : ( struct sockaddr_storage ) theAddress
    {
    
        // NSLog( @"UdpSocket describeAddress" );
        
        if ( theAddress.ss_family == AF_INET )
        {
        
            struct sockaddr_in* sockaddr = ( struct sockaddr_in* ) &theAddress;
            char *literal = inet_ntoa( sockaddr->sin_addr);
            
            return [ NSString stringWithFormat : @"type : ipv4 address %s port : %u" , literal , ntohs( sockaddr->sin_port ) ];
            
        }
        else
        {
        
            struct sockaddr_in6* sockaddr = ( struct sockaddr_in6* ) &theAddress;

            char literal[ INET6_ADDRSTRLEN ];
            inet_ntop( AF_INET6 , &( sockaddr->sin6_addr ) , literal , sizeof( literal ) );

            return [ NSString stringWithFormat : @"type : ipv6 address %s port : %u" , literal , ntohs( sockaddr->sin6_port ) ];
        
        }
    
    }
    
    
@end
