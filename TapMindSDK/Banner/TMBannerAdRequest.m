//
//  TMBannerAdRequest.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 24/11/25.
//
#import "TMBannerAdRequest.h"
#import <Foundation/Foundation.h>

@implementation TMBannerAdRequest
#pragma mark - Initializer

- (instancetype)initWithInstanceId:(NSString *)instanceId
                               adm:(NSString *)adm
                     placementName: (NSString *)placement
{
    self = [super init];
    if (self) {
        _adm = [adm copy];
        _instanceId = [instanceId copy];
        _placement = [placement copy];
    }
    return self;
}

#pragma mark - Builder Methods

- (TMBannerAdRequest *)withExtraParams:(NSDictionary *)extraParams
{
    self.extraParams = extraParams;
    return self;
}

- (TMBannerAdRequest *)withViewController:(UIViewController *)viewController
{
    self.viewController = viewController;
    return self;
}
@end
