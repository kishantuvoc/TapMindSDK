//
//  TMBannerViewReplacement.h
//  TapMindSDK
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMBannerViewReplacement : NSObject

+ (void)replaceView:(UIView *)oldView withView:(UIView *)newView;

+ (void)addView:(UIView *)newView
    toContainer:(UIView *)container
   matchingView:(nullable UIView *)referenceView;

/// Swaps a refreshed banner into the mediation container. Returns the container view to retain.
+ (nullable UIView *)applyRefreshReplacingView:(nullable UIView *)previousView
                                    withView:(UIView *)newView
                          knownContainerView:(nullable UIView *)knownContainerView;

+ (void)captureContainerForBannerView:(UIView *)bannerView
                           completion:(void (^)(UIView *_Nullable container))completion;

/// Detaches GAD delegates and removes a banner from its superview.
+ (void)removeDisplayedBannerView:(nullable UIView *)bannerView;

@end

NS_ASSUME_NONNULL_END
