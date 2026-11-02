//
//  TMAppOpenAdRequest.h
//  TapMindSDK
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Describes one App Open ad request: which placement, which mediator and which adapter build.
@interface TMAppOpenAdRequest : NSObject
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// TapMind placement name, read from the mediation parameter `placementname`. Empty when not set.
@property(nonatomic, strong, readwrite) NSString *placement;

/// Mediation partner that called the adapter: @"Admob" or @"GAM".
@property(nonatomic, strong, readwrite) NSString *adapterName;

/// Version of the adapter making the request (sent to the backend for reporting).
@property(nonatomic, strong, readwrite) NSString *adapterVersion;

/// Placement priority sent to the backend: @"1" when a placement name is given, @"4" otherwise.
@property(nonatomic, strong, readwrite) NSString *placementPriority;

/// YES when the mediation request is a test request.
@property(nonatomic, assign) BOOL isTesting;

/// Optional extra parameters from the mediation request (for example the watermark).
@property(nonatomic, strong, readwrite, nullable) NSDictionary *extraParams;

/// Creates a request.
/// @param placementName TapMind placement name.
/// @param adapterName Mediation partner (@"Admob" or @"GAM").
/// @param adapterVersion Adapter version string.
/// @param placementPriority Priority string sent to the backend.
/// @param isTest Whether this is a test request.
- (instancetype)initWithPlacement:(NSString *)placementName adapter:(NSString *)adapterName version:(NSString *)adapterVersion priority:(NSString *)placementPriority test:(BOOL)isTest;

/// Sets optional extra parameters.
/// @param extraParams The extra parameters dictionary.
/// @return The same request, so calls can be chained.
- (TMAppOpenAdRequest *)withExtraParams:(NSDictionary *)extraParams;
@end

NS_ASSUME_NONNULL_END
