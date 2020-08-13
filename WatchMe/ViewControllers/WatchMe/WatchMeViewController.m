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

@interface WatchMeViewController () <WatchMeModelDelegate>

@property (nonatomic, weak) IBOutlet WatchMeView *previewView;

@property (nonatomic, strong) IBOutlet WatchMeModel *model;

@end

@implementation WatchMeViewController

#pragma mark - WatchMeModelDelegate

- (AVCaptureVideoPreviewLayer *)previewLayerForWatchMeModel:(WatchMeModel *)model {
    return _previewView.previewLayer;
}

- (NSWindow *)requestWindowForWatchMeModel:(WatchMeModel *)model {
    return self.view.window;
}

#pragma mark - NSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _model.delegate = self;
    [_model prepareForUse];
}

- (void)viewWillAppear {
    [super viewWillAppear];
    
    [_model start];
}

- (void)viewWillDisappear {
    [super viewWillDisappear];
    
    [_model stop];
}

@end
