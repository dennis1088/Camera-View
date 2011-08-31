//
//  CameraViewController.h
//  CameraView
//
//  Created by Dennis on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import	<QTKit/QTKit.h>


@interface CameraViewController : NSWindowController {

	IBOutlet NSArrayController *arrayController;
	
	IBOutlet QTCaptureView *mCaptureView;
    
    QTCaptureSession            *mCaptureSession;
    QTCaptureMovieFileOutput    *mCaptureMovieFileOutput;
    QTCaptureDeviceInput        *mCaptureVideoDeviceInput;
    QTCaptureDeviceInput        *mCaptureAudioDeviceInput;
	
}

@end
