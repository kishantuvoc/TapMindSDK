//
//  TMBannerAdRequest.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 21/11/25.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//#import "TMNetworkType.h"
NS_ASSUME_NONNULL_BEGIN

@interface TMBannerAdRequest : NSObject
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

/**
 The identifier for the network instance.
 */
@property(nonatomic, strong, readwrite) NSString *instanceId;

/**
 The ad markup.
 */
@property(nonatomic, strong, readwrite) NSString *adm;

@property(nonatomic, strong, readwrite) NSString *placement;

/**
 The view controller to show the ad on, if available.
 */
@property(nonatomic, weak, readwrite, nullable) UIViewController *viewController;

/**
 Extra parameters for the ad request.
 */
@property(nonatomic, strong, readwrite, nullable) NSDictionary *extraParams;

/**
 Initializes the builder.

 @param instanceId The identifier for the network instance.
 @param adm The ad markup.
 @param size The ad size.
 */
- (instancetype)initWithInstanceId:(NSString *)instanceId
                               adm:(NSString *)adm
                               placementName: (NSString *)placement;

/**
 Sets extra parameters for the ad request.
 Optional.

 @param extraParams The extra parameters dictionary.

 @return The Builder instance.
 */
- (TMBannerAdRequest *)withExtraParams:(NSDictionary *)extraParams;

/**
 Sets the view controller that will show the ad, if available.

 @param viewController The view controller that will show the ad, if available.

 @return The Builder instance.
 */
- (TMBannerAdRequest *)withViewController:(UIViewController *)viewController;



@end

NS_ASSUME_NONNULL_END
