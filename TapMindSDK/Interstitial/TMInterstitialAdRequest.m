//
//  TMInterstitialAdRequest.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 24/11/25.
//

#import <Foundation/Foundation.h>
#import "TMInterstitialAdRequest.h"
@implementation TMInterstitialAdRequest
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

- (TMInterstitialAdRequest *)withExtraParams:(NSDictionary *)extraParams
{
    self.extraParams = extraParams;
    return self;
}
@end
