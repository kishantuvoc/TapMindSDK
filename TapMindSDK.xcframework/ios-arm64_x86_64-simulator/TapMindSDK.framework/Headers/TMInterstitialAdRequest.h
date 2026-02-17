//
//  TMInterstitialAdRequest.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 24/11/25.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMInterstitialAdRequest : NSObject
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

@property(nonatomic, strong, readwrite) NSString *adapterName;
/**
 Extra parameters for the ad request.
 */
@property(nonatomic, strong, readwrite, nullable) NSDictionary *extraParams;

/**
 Initializes the builder.

 @param instanceId The identifier for the network instance.
 @param adm The ad markup.
 */
- (instancetype)initWithInstanceId:(NSString *)instanceId adm:(NSString *)adm placementName: (NSString *)placement;

- (instancetype)initWithPlacement:(NSString *)placementName
                          adapter:(NSString *)adapterName;
/**
 Sets extra parameters for the ad request.
 Optional.

 @param extraParams The extra parameters dictionary.

 @return The Builder instance.
 */
- (TMInterstitialAdRequest *)withExtraParams:(NSDictionary *)extraParams;
@end

NS_ASSUME_NONNULL_END
