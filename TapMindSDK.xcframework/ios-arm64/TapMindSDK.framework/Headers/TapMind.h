//
//  TapMind.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 20/11/25.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface TapMind : NSObject

+ (instancetype)sharedInstance;

+ (NSString *)sdkVersion;

+ (NSString *)appName;

+ (NSString *)appBundle;

+ (NSString *)appVersion;

+ (NSString *)countryCode;

+ (void)initializeSDK;

- (void)initializeSDK:(NSString *)partner;

- (void)initialisation:(NSString *)partner;

+ (void)setConsentReady:(BOOL)consentReady;

+ (BOOL)isConsentReady;

+ (nullable NSError *)consentGateError;

+ (void)applyConsentSignalsToGoogleRequest:(GADRequest *)request;

@property (nonatomic, copy) NSString *adPartner;

@end

NS_ASSUME_NONNULL_END
