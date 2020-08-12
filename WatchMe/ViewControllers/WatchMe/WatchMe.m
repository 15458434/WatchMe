//
//  WatchMe.m
//  WatchMe
//
//  Created by Mark Cornelisse on 12/08/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

#import "WatchMe.h"

@implementation WatchMe

#pragma mark - NSView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        self.wantsLayer = YES;
        AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] init];
        CGRect layerFrame = self.layer.bounds;
        previewLayer.frame = layerFrame;
        [self.layer addSublayer:previewLayer];
        previewLayer.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewWidthSizable | NSViewMinYMargin | NSViewMaxYMargin | NSViewHeightSizable;
        _previewLayer = previewLayer;
    }
    return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.wantsLayer = YES;
        AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] init];
        CGRect layerFrame = self.layer.bounds;
        previewLayer.frame = layerFrame;
        [self.layer addSublayer:previewLayer];
        previewLayer.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewWidthSizable | NSViewMinYMargin | NSViewMaxYMargin | NSViewHeightSizable;
        _previewLayer = previewLayer;
    }
    return self;
}

#pragma mark - NSObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.wantsLayer = YES;
        AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] init];
        CGRect layerFrame = self.layer.bounds;
        previewLayer.frame = layerFrame;
        [self.layer addSublayer:previewLayer];
        previewLayer.autoresizingMask = NSViewMinXMargin | NSViewMaxXMargin | NSViewWidthSizable | NSViewMinYMargin | NSViewMaxYMargin | NSViewHeightSizable;
        _previewLayer = previewLayer;
    }
    return self;
}

@end
