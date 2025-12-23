//
//  TMRewardedAdRequest.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 02/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMRewardedAdRequest : NSObject
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
 Extra parameters for the ad request.
 */
@property(nonatomic, strong, readwrite, nullable) NSDictionary *extraParams;

/**
 Initializes the builder.

 @param instanceId The identifier for the network instance.
 @param adm The ad markup.
 */
- (instancetype)initWithInstanceId:(NSString *)instanceId adm:(NSString *)adm placementName: (NSString *)placement;

/**
 Sets extra parameters for the ad request.
 Optional.

 @param extraParams The extra parameters dictionary.

 @return The Builder instance.
 */
- (TMRewardedAdRequest *)withExtraParams:(NSDictionary *)extraParams;
@end

NS_ASSUME_NONNULL_END
