//  Protocol.h
//  Remotion
//
//  Created by Milan Toth on 3/1/12.
//  Copyright (c) 2012 The MilGra Experience. All rights reserved.


    // packet format 1 ( type ) + ( 24 ) empty
    // or            1 ( type ) + ( 3 * 8 ) rotation / motion
    // or            1 ( tyoe ) + ( 1 ) button id + ( 1 ) button state + ( 22 ) empty

    #define kProtocolPacketSize         25
	#define kProtocolPingDelay			.5
    #define kProtocolTimeOut            2

	#define kProtocolTypePing           0x00
	#define kProtocolTypePong           0x01
	#define kProtocolTypeButton			0x02
	#define kProtocolTypeRotation		0x03
	#define kProtocolTypeDisconnect		0x04

	#define kProtocolButtonA	 		0x00
	#define kProtocolButtonB	 		0x01
	#define kProtocolButtonC	 		0x02
	#define kProtocolButtonD	 		0x03
	#define kProtocolButtonE	 		0x04
	#define kProtocolButtonF	 		0x05
	#define kProtocolButtonG	 		0x06
	#define kProtocolButtonH	 		0x07
	#define kProtocolButtonI	 		0x08
	#define kProtocolButtonJ	 		0x09
	#define kProtocolButtonK	 		0x10
	#define kProtocolButtonL	 		0x11
	#define kProtocolButtonM	 		0x12
	#define kProtocolButtonN	 		0x13
	#define kProtocolButtonO	 		0x14
	#define kProtocolButtonP	 		0x15
	
	#define kProtocolButtonStateDown	0x01
	#define kProtocolButtonStateUp		0x00