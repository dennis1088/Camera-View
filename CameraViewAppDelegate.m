//
//  CameraViewAppDelegate.m
//  CameraView
//
//  Created by Dennis on 8/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CameraViewAppDelegate.h"

@implementation CameraViewAppDelegate

@synthesize window;
@synthesize running;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
	[window setTitle:@"Camera View"];
	
	//Get list of video devices on the computer
	NSArray *devices = [QTCaptureDevice	inputDevicesWithMediaType:QTMediaTypeVideo];
	
	//Log all the devices found
	for(QTCaptureDevice *device in devices) 
		
		NSLog(@"Found a device called: %@",device);
		
	//Add the list of devices to the controller to be display and binded to pop up
	[arrayController addObjects:devices];
	
	//Set the default selection to the first device in the list
	[arrayController setSelectionIndex:0];
	
	//Create a capture session
	mCaptureSession = [[QTCaptureSession alloc] init];
	
	//Local variables to track success and errors of operations for logging
	BOOL success = NO;
	NSError *error;
	
	//Get the selected device from the pop up menu and open the device
	QTCaptureDevice *videoDevice = [[arrayController selectedObjects] lastObject];
	success = [videoDevice open:&error];
	
	if (!success) {
		//Handle error
		NSLog(@"Error opening device: %@",videoDevice);
		videoDevice = nil;
	}
	
	//only if video device has been opened succesfully
	if (videoDevice) {
		
		//Add device to session as device input
		mCaptureVideoDeviceInput = [[QTCaptureDeviceInput alloc] initWithDevice:videoDevice];
		success = [mCaptureSession addInput:mCaptureVideoDeviceInput error:&error];
		
		if (!success) {
			//Handle error
			NSLog(@"Error adding device to session: %@",videoDevice);
		}
		
		//Creating out for reciving the decompressed frames and setting this class as its delegate
		mCaptureDecompressedVideoOutput = [[QTCaptureDecompressedVideoOutput alloc] init];
		//[mCaptureDecompressedVideoOutput setAutomaticallyDropsLateVideoFrames:YES];
		[mCaptureDecompressedVideoOutput setDelegate:self];
		
		//Adding the output to the session
		success = [mCaptureSession addOutput:mCaptureDecompressedVideoOutput error:&error];
		
		if (!success) {
			//Handle Error
			NSLog(@"Error adding output to the session.");
		}
		
		//Add the session to the view and start the session
		[mCaptureView setCaptureSession:mCaptureSession];
		[mCaptureSession startRunning];
		
	}

}

- (IBAction) deviceChanged:(id)sender {
	
	//notify the array controller which object should be selected 
	[arrayController setSelectionIndex:[sender indexOfSelectedItem]];
	
	//Create local instances of the selected and current device 
	QTCaptureDevice *selectedVideoDevice = [[arrayController selectedObjects] lastObject];
	QTCaptureDevice *currentVideoDevice = [mCaptureVideoDeviceInput device]; 
	 
	//Only if the current device and the device selected are different
	if (selectedVideoDevice != currentVideoDevice) {
		
		//stop the capturing, remove the input, and release the input object, close the previous device
		[mCaptureSession stopRunning];
		[mCaptureSession removeInput:mCaptureVideoDeviceInput];
		[mCaptureVideoDeviceInput release];
		[currentVideoDevice close];
		
		//Local variables to track success and errors of operations for logging
		BOOL success = NO;
		NSError	*error;
		
		//open the new device
		success = [selectedVideoDevice open:&error];
		
		if (!success) {
			//Handle error
			NSLog(@"Error opening device: %@",selectedVideoDevice);
			selectedVideoDevice = nil;
		}
		
		//only if the device was opened properly
		if (selectedVideoDevice) {

			mCaptureVideoDeviceInput = [[QTCaptureDeviceInput alloc] initWithDevice:selectedVideoDevice];
			success = [mCaptureSession addInput:mCaptureVideoDeviceInput error:&error];
	
			if (!success) {
				//Handle error
				NSLog(@"Error adding device to session: %@",selectedVideoDevice);
			}
			
			[mCaptureView setCaptureSession:mCaptureSession];
			
			NSLog(@"Changed device to: %@", selectedVideoDevice);
			
			[mCaptureSession startRunning];

		}
		
	} else {
		NSLog(@"They are both the same devices");
	}
	
}

- (NSString *)startStopButtonTitle
{
    NSString *  result;
    if (self.isRunning) {
        result = @"Stop Stream";
    } else {
        result = @"Start Stream";
    }
    return result;
}

- (IBAction)startStopAction:(id)sender
// Called when user clicks the Start/Stop button.  This either starts or 
// stops the picture sharing service.
{
	#pragma unused(sender)
    if (self.isRunning) {
	
    } else {
        [self start];
    }
	
}

- (void)start {
	
	

}

- (void)captureOutput:(QTCaptureOutput *)captureOutput didOutputVideoFrame:(CVImageBufferRef)videoFrame withSampleBuffer:(QTSampleBuffer *)sampleBuffer fromConnection:(QTCaptureConnection *)connection {
	
	
	
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication {
	//If you would like to close the program when the window is closed
	return YES;
	
}

@end
