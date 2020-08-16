//
//  WatchMeModel.h
//  WatchMe
//
//  Created by Mark Cornelisse on 12/08/2020.
//  Copyright © 2020 Mark Cornelisse. All rights reserved.
//

@import Cocoa;
@import AVFoundation;

@class WatchMeModel;

NS_ASSUME_NONNULL_BEGIN

@protocol WatchMeModelDelegate <NSObject>

- (NSWindow *)requestWindowForWatchMeModel:(WatchMeModel *)model;
- (AVCaptureVideoPreviewLayer *)previewLayerForWatchMeModel:(WatchMeModel *)model;

@end

@interface WatchMeModel : NSObject

@property (nonatomic, weak) id<WatchMeModelDelegate> delegate;

@property (nonatomic, readonly) BOOL isActive;

- (void)prepareForUse;
- (void)start;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
