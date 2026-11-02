//
//  TMAppOpenAd.h
//  TapMindSDK
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <TapMindSDK/TMAppOpenDelegate.h>
#import <TapMindSDK/TMAppOpenAdRequest.h>
NS_ASSUME_NONNULL_BEGIN

@interface TMAppOpenAd : NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;

/// Starts loading an App Open ad.
/// @param adRequest Placement, partner and adapter details for this load.
/// @param delegate Receives the load result and show events (held weakly).
- (void)initWithRequest:(TMAppOpenAdRequest *)adRequest
               delegate:(id<TMAppOpenDelegate>)delegate;

/// Shows the loaded ad on the main thread.
/// @param viewController The view controller to present from.
- (void)showFromViewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
