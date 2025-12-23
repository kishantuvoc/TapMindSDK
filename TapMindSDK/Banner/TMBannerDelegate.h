//
//  TMBannerDelegate.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 20/11/25.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@protocol TMBannerDelegate <NSObject>
@optional
- (void)bannerViewDidReceiveAd:(UIView *)bannerView;
- (void)didFailToReceiveAdWithError:(NSError *)error;
- (void)bannerViewDidRecordClick;
- (void)bannerViewDidRecordImpression;
- (void)bannerViewWillPresentScreen;
- (void)bannerViewWillDismissScreen;
- (void)bannerViewDidDismissScreen;
@end
