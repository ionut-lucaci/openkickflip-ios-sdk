//
//  OpenKickflipp.m
//
//  Created by Christopher Ballinger on 1/16/14.
//  Copyright (c) 2014 Christopher Ballinger. All rights reserved.
//

#import "OpenKickflip.h"
#import "KFLog.h"
#import "KFBroadcastViewController.h"
#import "KFS3Stream.h"

@interface OpenKickflip()
@property (nonatomic) NSString *h264Profile;
@property (nonatomic) NSUInteger resolutionWidth;
@property (nonatomic) NSUInteger resolutionHeight;
@property (nonatomic) NSUInteger minBitrate;
@property (nonatomic) NSUInteger maxBitrate;
@property (nonatomic) NSUInteger initialBitrate;
@property (nonatomic) BOOL useAdaptiveBitrate;
@property (nonatomic) BOOL useAudio;
@end

static OpenKickflip *_kickflip = nil;

@implementation OpenKickflip

+ (void) presentBroadcasterFromViewController:(UIViewController *)viewController
                              s3Configuration:(KFS3Stream*)s3Config
                                        ready:(KFBroadcastReadyBlock)readyBlock
                                   completion:(KFBroadcastCompletionBlock)completionBlock {
    
    KFBroadcastViewController *broadcastViewController = [[KFBroadcastViewController alloc] init];
    broadcastViewController.readyBlock = readyBlock;
    broadcastViewController.completionBlock = completionBlock;
    broadcastViewController.recorder.s3Configuration = s3Config;
    [viewController presentViewController:broadcastViewController animated:YES completion:nil];
    
}

+ (OpenKickflip *) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _kickflip = [[OpenKickflip alloc] init];
    });
    return _kickflip;
}

- (id)init {
    if (self = [super init]) {
        _h264Profile = AVVideoProfileLevelH264BaselineAutoLevel;
        _resolutionWidth = 568;
        _resolutionHeight = 320;
        _minBitrate = 456 * 1000; // 400 Kbps
        _maxBitrate = 2056 * 1000; // 2 Mbps
        _initialBitrate = _maxBitrate;
        _useAdaptiveBitrate = YES;
        _useAudio = YES;
    }
    return self;
}

+ (void)setH264Profile:(NSString *)profile {
    [OpenKickflip sharedInstance].h264Profile = profile;
}

+ (NSString *)h264Profile {
    return [OpenKickflip sharedInstance].h264Profile;
}

+ (void)setResolutionWidth:(int)width height:(int)height {
    [OpenKickflip sharedInstance].resolutionWidth = width;
    [OpenKickflip sharedInstance].resolutionHeight = height;
}

+ (double)resolutionWidth {
    return [OpenKickflip sharedInstance].resolutionWidth;
}

+ (double)resolutionHeight {
    return [OpenKickflip sharedInstance].resolutionHeight;
}

+ (void)setMinBitrate:(double)minBitrate {
    [OpenKickflip sharedInstance].minBitrate = minBitrate;
}

+ (double)minBitrate {
    return [OpenKickflip sharedInstance].minBitrate;
}

+ (void)setMaxBitrate:(double)maxBitrate {
    [OpenKickflip sharedInstance].maxBitrate = maxBitrate;
}

+ (double)maxBitrate {
    return [OpenKickflip sharedInstance].maxBitrate;
}

+ (void)setInitialBitrate:(double)initialBitrate {
    if (initialBitrate < [self minBitrate]) {
        initialBitrate = [self minBitrate];
    }
    
    if (initialBitrate > [self maxBitrate]) {
        initialBitrate = [self maxBitrate];
    }
    
    [OpenKickflip sharedInstance].initialBitrate = initialBitrate;
}

+ (double)initialBitrate {
    return [OpenKickflip sharedInstance].initialBitrate;
}

+ (BOOL)useAdaptiveBitrate {
    return [OpenKickflip sharedInstance].useAdaptiveBitrate;
}

+ (void)setUseAdaptiveBitrate:(BOOL)enabled {
    [OpenKickflip sharedInstance].useAdaptiveBitrate = enabled;
}

+ (BOOL)useAudio {
    return [OpenKickflip sharedInstance].useAudio;
}

+ (void)setAudio:(BOOL)enabled {
    [OpenKickflip sharedInstance].useAudio = enabled;
}

@end
