//
//  TMBannerView.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 25/11/25.
//

#import <UIKit/UIKit.h>
#import "TMBannerDelegate.h"
#import "TMBannerAdRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMBannerView : NSObject
+ (instancetype)sharedInstance;
- (void)initWithRequest:(TMBannerAdRequest *)adRequest
                   delegate:(id<TMBannerDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
