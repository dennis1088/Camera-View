//
//  CameraViewAppDelegate.h
//  CameraView
//
//  Created by Dennis on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QTKit/QTKit.h>

@interface CameraViewAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	BOOL running;
	
	IBOutlet NSArrayController *arrayController;
	IBOutlet QTCaptureView *mCaptureView;
	
	QTCaptureSession					*mCaptureSession;
    QTCaptureDeviceInput				*mCaptureVideoDeviceInput;
	QTCaptureDecompressedVideoOutput	*mCaptureDecompressedVideoOutput;
	
	CVImageBufferRef					mCurrentImageBuffer;
	
	NSString							*mServiceName;
	
	NSNetService						*mNetService;
	
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, assign, readonly,  getter=isRunning) BOOL running;

- (IBAction) deviceChanged:(id)sender;
- (IBAction) startStopAction:(id)sender;

- (NSString *)startStopButtonTitle;

@end
