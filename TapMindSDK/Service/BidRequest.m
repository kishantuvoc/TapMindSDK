//
//  BidRequest.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 15/12/25.
//

#import "BidRequest.h"
@implementation BidRequest
- (NSDictionary *)toDictionary {
    return @{
        @"appName": self.appName ?: @"",
        @"placementName": self.placementName ?: @"",
        @"version": self.version ?: @"",
        @"platform": self.platform ?: @"",
        @"environment": self.environment ?: @"",
        @"adType": self.adType ?: @"",
        @"country": self.country ?: @""
    };
}
@end
