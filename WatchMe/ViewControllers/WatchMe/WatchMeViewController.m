//
//  WatchMeViewController.m
//  WatchMe
//
//  Created by Mark Cornelisse on 12/08/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

@import AVFoundation;
#import "WatchMeViewController.h"
#import "WatchMeView.h"
#import "WatchMeModel.h"

@interface WatchMeViewController ()

@property (nonatomic, weak) IBOutlet WatchMeView *previewView;

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDevice *videoDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *videoDeviceInput;

@property (nonatomic, strong) IBOutlet WatchMeModel *model;

@end

@implementation WatchMeViewController

- (void)setupCaptureSession {
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession beginConfiguration];
    
    // Setup video input
    _videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *videoDeviceInputError;
    _videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_videoDevice error:&videoDeviceInputError];
    if (videoDeviceInputError) {
        NSAlert *alert = [NSAlert alertWithError:videoDeviceInputError];
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
            
        }];
    }
    [_captureSession addInput:_videoDeviceInput];
    
    // Setup video output
    _previewView.previewLayer.session = _captureSession;
    
    [_captureSession commitConfiguration];
}

#pragma mark - NSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(macOS 10.14, *)) {
        // Request permission to access the camera and microphone.
        switch ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]) {
            case AVAuthorizationStatusAuthorized:
            {
                // The user has previously granted access to the camera.
                [self setupCaptureSession];
                break;
            }
            case AVAuthorizationStatusNotDetermined:
            {
                // The app hasn't yet asked the user for camera access.
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        [self setupCaptureSession];
                    }
                }];
                break;
            }
            case AVAuthorizationStatusDenied:
            {
                // The user has previously denied access.
                return;
            }
            case AVAuthorizationStatusRestricted:
            {
                // The user can't grant access due to restrictions.
                return;
            }
        }
    } else {
        [self setupCaptureSession];
    }
}

- (void)viewWillAppear {
    [super viewWillAppear];
    
    [_captureSession startRunning];
}

- (void)viewWillDisappear {
    [super viewWillDisappear];
    
    [_captureSession stopRunning];
}

@end
