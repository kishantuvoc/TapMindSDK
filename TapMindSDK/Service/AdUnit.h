//
//  AdUnit.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 20/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdUnit : NSObject
@property (nonatomic, copy) NSString *adUnitId;
@property (nonatomic, copy) NSString *partner;
@property (nonatomic, assign) NSInteger priority;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
