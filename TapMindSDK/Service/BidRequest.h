//
//  BidRequest.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 15/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidRequest : NSObject
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *placementName;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, copy) NSString *environment;
@property (nonatomic, copy) NSString *adType;
@property (nonatomic, copy) NSString *country;

- (NSDictionary *)toDictionary;
@end

NS_ASSUME_NONNULL_END
