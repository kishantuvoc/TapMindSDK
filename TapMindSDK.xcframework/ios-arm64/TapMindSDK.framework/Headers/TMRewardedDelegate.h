//
//  TMRewardedDelegate.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 02/12/25.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@protocol TMRewardedDelegate <NSObject>
@optional
- (void)didReceivedAd;
- (void)adDidRecordImpression;
- (void)adDidRecordClick;
- (void)adWillPresentFullScreenContent;
- (void)adWillDismissFullScreenContent;
- (void)adDidDismissFullScreenContent;
- (void)didFailToReceiveAdWithError:(NSError *)error;
- (void)rewardedAdDidUserEarnReward;
@end
