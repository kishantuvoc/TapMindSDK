//
//  TMRewardedAd.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 02/12/25.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <TapMindSDK/TMRewardedDelegate.h>
#import <TapMindSDK/TMRewardedAdRequest.h>
NS_ASSUME_NONNULL_BEGIN

@interface TMRewardedAd : NSObject
+ (instancetype)sharedInstance;
- (void)initWithRequest:(TMRewardedAdRequest *)adRequest
                   delegate:(id<TMRewardedDelegate>)delegate;
- (void)showFromViewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
