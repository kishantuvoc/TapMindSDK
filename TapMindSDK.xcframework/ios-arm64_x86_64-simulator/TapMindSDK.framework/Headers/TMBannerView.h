//
//  TMBannerView.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 25/11/25.
//

#import <UIKit/UIKit.h>
#import <TapMindSDK/TMBannerDelegate.h>
#import <TapMindSDK/TMBannerAdRequest.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMBannerView : NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;

- (void)initWithRequest:(TMBannerAdRequest *)adRequest
               delegate:(id<TMBannerDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
