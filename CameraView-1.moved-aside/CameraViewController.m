//
//  CameraViewController.m
//  CameraView
//
//  Created by Dennis on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CameraViewController.h"


@implementation CameraViewController

- (void)awakeFromNib {

	[arrayController addObjects:[QTCaptureDevice inputDevicesWithMediaType:QTMediaTypeVideo]]; 
	[arrayController setSelectionIndex:0];

}

@end
