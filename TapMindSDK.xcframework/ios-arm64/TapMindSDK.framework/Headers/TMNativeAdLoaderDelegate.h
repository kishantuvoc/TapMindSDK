//
//  TMNativeAdLoaderDelegate.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 25/11/25.
//

#import <Foundation/Foundation.h>
@class TMNativeAd;
@protocol TMNativeAdLoaderDelegate<NSObject>
- (void)didFailToReceiveAdWithError:(NSError *)error;
- (void)didLoadAdView:(TMNativeAd *)view;
- (void)adLoaderDidFinishLoading;
- (void)nativeAdDidRecordImpression;
- (void)nativeAdDidRecordClick;
- (void)nativeAdWillPresentScreen;
- (void)nativeAdWillDismissScreen;
- (void)nativeAdDidDismissScreen;
- (void)nativeAdWillLeaveApplication;
@end
