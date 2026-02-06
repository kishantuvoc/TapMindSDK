//
//  TMInterstitialAd.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 25/11/25.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <TapMindSDK/TMInterstitialDelegate.h>
#import <TapMindSDK/TMInterstitialAdRequest.h>
NS_ASSUME_NONNULL_BEGIN

@interface TMInterstitialAd : NSObject
+ (instancetype)sharedInstance;
- (void)initWithRequest:(TMInterstitialAdRequest *)adRequest
                   delegate:(id<TMInterstitialDelegate>)delegate;
- (void)showFromViewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
