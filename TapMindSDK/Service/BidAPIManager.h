//
//  BidAPIManager.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 15/12/25.
//

#import <Foundation/Foundation.h>
@class BidRequest;
@class BidResponse;

NS_ASSUME_NONNULL_BEGIN

@interface BidAPIManager : NSObject
+ (void)fetchBidWithRequest:(BidRequest *)request
                 completion:(void (^)(BidResponse *response, NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
