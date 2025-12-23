//
//  BidResponse.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 15/12/25.
//

#import "BidResponse.h"
#import "AdUnit.h"
//#import "PartnerResponse.h"

@implementation BidResponse
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _success = [dict[@"success"] boolValue];
        _message = [dict[@"message"] copy];
        if (dict[@"data"] != [NSNull null]) {
            NSMutableArray *units = [NSMutableArray array];
            for (NSDictionary *item in dict[@"data"]) {
                AdUnit *unit = [[AdUnit alloc] initWithDictionary:item];
                [units addObject:unit];
            }
            _data = [units copy];
        }
    }
    return self;
}
@end
