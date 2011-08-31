//
//  CameraViewController.m
//  PopupBindings
//
//  Created by Dennis on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CameraViewController.h"


@implementation CameraViewController

- (void)awakeFromNib {

	//[arrayController addObjects:[QTCaptureDevice inputDevices]];
	
	NSArray *devices = [QTCaptureDevice	inputDevices];
	
	for(QTCaptureDevice device in devices) {
		
		NSLog(@"Found a device called: %@", [device localizedDisplayName]);
	
	}
	
}

@end
