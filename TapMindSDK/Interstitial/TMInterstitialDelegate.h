//
//  TMInterstitialDelegate.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 24/11/25.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@protocol TMInterstitialDelegate <NSObject>
@optional
- (void)didReceivedAd;
- (void)adDidRecordImpression;
- (void)adDidRecordClick;
- (void)adWillPresentFullScreenContent;
- (void)adWillDismissFullScreenContent;
- (void)adDidDismissFullScreenContent;
- (void)didFailToReceiveAdWithError:(NSError *)error;
@end
