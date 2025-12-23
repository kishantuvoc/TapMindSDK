//
//  AdUnit.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 20/12/25.
//

#import "AdUnit.h"

@implementation AdUnit
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _adUnitId = [dict[@"ad_unit_id"] copy];
        _partner  = [dict[@"partner"] copy];
        _priority = [dict[@"priority"] integerValue];
    }
    return self;
}
@end
