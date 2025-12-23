//
//  BidResponse.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 15/12/25.
//

#import <Foundation/Foundation.h>
@class AdUnit;
//@class PartnerResponse;

NS_ASSUME_NONNULL_BEGIN

@interface BidResponse : NSObject
@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSArray<AdUnit *> *data;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
