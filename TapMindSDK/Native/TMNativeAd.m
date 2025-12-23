//
//  TMNativeAd.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 25/11/25.
//

#import "TMNativeAd.h"


@implementation TMNativeAd
- (void)handleClickOnView:(UIView *)view {
  NSLog(@"A click occurred on a sampleNativeAd!");
  // In a real SDK, some type of click action (such as the opening of the App Store)
  // would likely be initiated here.
}

- (void)recordImpression {
  NSLog(@"An impression was recorded for a sampleNativeAd!");
  // In a real SDK, some work would be done here to record the impression.
}

- (void)playVideo {
//  [_mediaView playMedia];
}
@end
