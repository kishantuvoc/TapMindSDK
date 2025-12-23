//
//  TapMind.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 20/11/25.
//

#import "TapMind.h"
#import "BidAPIManager.h"
#import "BidRequest.h"
#import "BidResponse.h"
#import "AdUnit.h"

@implementation TapMind

+ (nonnull NSString *)sdkVersion {
    return @"1.0.0";
}

+ (nonnull NSString *)appName {
    NSBundle *bunlde = [NSBundle mainBundle];
    NSString *appName =
    [bunlde localizedInfoDictionary][@"CFBundleDisplayName"]
    ?: [bunlde infoDictionary][@"CFBundleDisplayName"]
    ?: [bunlde infoDictionary][@"CFBundleName"];
    return appName;
}

+ (nonnull NSString *)countryCode {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    return countryCode;
}

@end
