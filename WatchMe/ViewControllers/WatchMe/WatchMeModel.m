//
//  WatchMeModel.m
//  WatchMe
//
//  Created by Mark Cornelisse on 12/08/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

#import "WatchMeModel.h"

@interface WatchMeModel ()

@property (nonatomic) BOOL isActive;

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureDevice *videoDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *videoDeviceInput;

@end

@implementation WatchMeModel

- (void)setupCaptureSession {
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession beginConfiguration];
    
    // Setup video input
    _videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *videoDeviceInputError;
    _videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_videoDevice error:&videoDeviceInputError];
    if (videoDeviceInputError) {
        NSAlert *alert = [NSAlert alertWithError:videoDeviceInputError];
        NSWindow *window = [self.delegate requestWindowForWatchMeModel:self];
        [alert beginSheetModalForWindow:window completionHandler:^(NSModalResponse returnCode) {
            
        }];
    }
    [_captureSession addInput:_videoDeviceInput];
    
    // Setup video output
    AVCaptureVideoPreviewLayer *previewLayer = [self.delegate previewLayerForWatchMeModel:self];
    previewLayer.session = _captureSession;
    
    [_captureSession commitConfiguration];
}

- (void)prepareForUse {
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
                __weak typeof(self) weakSelf = self;
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (granted) {
                            [weakSelf setupCaptureSession];
                            [weakSelf startSession];
                        }
                    });
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

- (void)startSession {
    if (self.isActive) {
        [_captureSession startRunning];
    }
}

- (void)start {
    self.isActive = YES;
    [self startSession];
}

- (void)stop {
    [_captureSession stopRunning];
}

#pragma mark - NSObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isActive = NO;
    }
    return self;
}

@end
