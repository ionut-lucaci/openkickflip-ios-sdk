//
//  OpenKickflip.h
//
//  Created by Gaston Morixe on 10/27/15.
//  Copyright (c) 2015 Gaston Morixe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KFS3Stream.h"


/**
 *  Block executed when stream is ready.
 *
 *  @param streamURL URL to the streamable m3u8
 *  @see presentBroadcasterFromViewController:ready:completion:
 */
typedef void (^KFBroadcastReadyBlock)(KFStream *stream);

/**
 *  Block executed when completed live broadcast
 *
 *  @param success Whether or not broadcast was successful
 *  @param error   Any error that occurred
 *  @see presentBroadcasterFromViewController:ready:completion:
 */
typedef void (^KFBroadcastCompletionBlock)(BOOL success, NSError* error);

/**
 *  Kickflip is the easiest way to broadcast live video. Sign up today at https://kickflip.io
 */
@interface OpenKickflip : NSObject

///-------------------------------
/// @name Broadcast
///-------------------------------

/**
 *  Presents KFBroadcastViewController from your view controller.
 *
 *  @param viewController  Presenting controller
 *  @param s3Configuration  S3 Configuration
 *  @param readyBlock      Called when streamURL is ready
 *  @param completionBlock Called when broadcaster is dismissed
 */
+ (void) presentBroadcasterFromViewController:(UIViewController *)viewController
                              s3Configuration:(KFS3Stream*)s3Config
                                        ready:(KFBroadcastReadyBlock)readyBlock
                                   completion:(KFBroadcastCompletionBlock)completionBlock;

///-------------------------------
/// @name Configuration
///-------------------------------

+ (NSString *)h264Profile;
+ (void)setH264Profile:(NSString *)profile;

+ (double)resolutionWidth;
+ (double)resolutionHeight;
+ (void)setResolutionWidth:(int)width height:(int)height;

//+ (NSString)profile;
//+ (void)setProfile:(AVVideoComposition)

/**
 *  Minimum bitrate (combined video + audio)
 */
+ (double)minBitrate;
+ (void)setMinBitrate:(double)minBitrate;

/**
 *  Maximum bitrate (combined video + audio)
 *
 *  @return Defaults to 2 Mbps
 */
+ (double)maxBitrate;
+ (void)setMaxBitrate:(double)maxBitrate;

/**
 *  Initial bitrate (combined video + audio)
 */
+ (double)initialBitrate;
+ (void)setInitialBitrate:(double)initialBitrate;

/**
 *  Whether or not to actively adjust the bitrate to network conditions.
 *
 *  @return Defaults to YES
 */
+ (BOOL)useAdaptiveBitrate;
+ (void)setUseAdaptiveBitrate:(BOOL)enabled;

/**
 *  Whether or not to record audio.
 *
 *  @return Defaults to YES
 */
+ (BOOL)useAudio;
+ (void)setuseAudio:(BOOL)enabled;

@end
