//
//  TMAppOpenDelegate.h
//  TapMindSDK
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@protocol TMAppOpenDelegate <NSObject>
@optional

#pragma mark - Load

/// An ad loaded and is ready to show. Called once per load.
- (void)didReceivedAd;

/// The load failed (no fill on every tag, timeout, consent block or API error). Called once per load.
- (void)didFailToReceiveAdWithError:(NSError *)error;

#pragma mark - Show

/// The ad will appear on screen.
- (void)adWillPresentFullScreenContent;

/// A loaded ad could not be shown: not ready, expired (older than 4 hours),
/// or Google refused to present it. The SDK does not reload automatically.
- (void)didFailToPresentWithError:(NSError *)error;

/// Google counted an impression.
- (void)adDidRecordImpression;

/// The user tapped the ad.
- (void)adDidRecordClick;

/// The ad is about to close.
- (void)adWillDismissFullScreenContent;

/// The ad closed. The ad is released afterwards; load a new one to show again.
- (void)adDidDismissFullScreenContent;
@end
