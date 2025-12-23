//
//  TMRewardedAdRequest.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 02/12/25.
//

#import "TMRewardedAdRequest.h"
#import <Foundation/Foundation.h>

@implementation TMRewardedAdRequest
#pragma mark - Initializer

- (instancetype)initWithInstanceId:(NSString *)instanceId
                               adm:(NSString *)adm
                     placementName: (NSString *)placement
{
    self = [super init];
    if (self) {
        _instanceId = [instanceId copy];
        _adm = [adm copy];
        _placement = [placement copy];
    }
    return self;
}

#pragma mark - Builder Methods

- (TMRewardedAdRequest *)withExtraParams:(NSDictionary *)extraParams
{
    self.extraParams = extraParams;
    return self;
}
@end
