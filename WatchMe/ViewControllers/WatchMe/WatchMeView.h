//
//  WatchMeView.h
//  WatchMe
//
//  Created by Mark Cornelisse on 12/08/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

@import Cocoa;
@import AVFoundation;

NS_ASSUME_NONNULL_BEGIN

@interface WatchMeView : NSView

@property (nonatomic, weak) AVCaptureVideoPreviewLayer *previewLayer;

@end

NS_ASSUME_NONNULL_END
