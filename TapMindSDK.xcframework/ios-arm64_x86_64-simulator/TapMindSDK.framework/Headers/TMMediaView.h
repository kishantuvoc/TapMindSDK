//
//  TMMediaView.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 25/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMMediaView : UIView
//- (instancetype)initWithFrame:(CGRect)frame;

//- (void)createMediaContent;

//- (void)playMedia;
/// Indicates whether the media content has video content.
//@property(nonatomic, readwrite) BOOL hasVideoContent;

/// Media content aspect ratio (width/height). The value is 0 when there's no media content or the
/// media content aspect ratio is unknown.
//@property(nonatomic, readwrite) CGFloat aspectRatio;

/// The video's duration in seconds or 0 if there's no video or the duration is unknown.
//@property(nonatomic, readwrite) NSTimeInterval duration;

/// The video's current playback time in seconds or 0 if there's no video or the current playback
/// time is unknown.
//@property(nonatomic, readwrite) NSTimeInterval currentTime;

/// The main image to be displayed when the media content doesn't contain video. Only available to
/// native ads.
//@property(nonatomic, nullable) UIImage *mainImage;
@end

NS_ASSUME_NONNULL_END
