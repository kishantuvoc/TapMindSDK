//
//  TMNativeAdRequest.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 25/11/25.
//

#import "TMNativeAdRequest.h"

@implementation TMNativeAdRequest
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

- (TMNativeAdRequest *)withExtraParams:(NSDictionary *)extraParams
{
    self.extraParams = extraParams;
    return self;
}

- (TMNativeAdRequest *)withViewController:(UIViewController *)viewController
{
    self.viewController = viewController;
    return self;
}
@end
