//
//  TMNativeAdLoader.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 25/11/25.
//

#import <Foundation/Foundation.h>
#import <TapMindSDK/TMNativeAdRequest.h>
#import <TapMindSDK/TMNativeAdLoaderDelegate.h>
NS_ASSUME_NONNULL_BEGIN

@interface TMNativeAdLoader : NSObject
+ (instancetype)sharedInstance;
- (void)initWithRequest:(TMNativeAdRequest *)adRequest
                   delegate:(id<TMNativeAdLoaderDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
