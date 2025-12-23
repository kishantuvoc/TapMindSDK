//
//  BidAPIManager.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 15/12/25.
//

#import "BidAPIManager.h"
#import "BidRequest.h"
#import "BidResponse.h"

@implementation BidAPIManager
+ (void)fetchBidWithRequest:(BidRequest *)request
                 completion:(void (^)(BidResponse *response, NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:@"https://srv-core-dev.tapmind.io/bid-request-v2"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    urlRequest.HTTPMethod = @"POST";
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *bodyData =
    [NSJSONSerialization dataWithJSONObject:[request toDictionary]
                                    options:0
                                      error:nil];
    urlRequest.HTTPBody = bodyData;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSInteger statusCode = httpResponse.statusCode;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (statusCode == 200) {
            BidResponse *bidResponse = [[BidResponse alloc] initWithDictionary:json];
            if ([bidResponse success]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(bidResponse, nil);
                });
            }else{
                if ([json valueForKey:@"message"] != [NSNull null]) {
                    NSError *error = [NSError errorWithDomain:@"com.tapmind.error" code:1001 userInfo:@{ NSLocalizedDescriptionKey: [json valueForKey:@"message"] }];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(nil, error);
                    });
                }else{
                    NSError *error = [NSError errorWithDomain:@"com.tapmind.error" code:1002 userInfo:@{ NSLocalizedDescriptionKey: @"Something went wrong please try again later" }];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(nil, error);
                    });
                }
            }
        }else if ([json valueForKey:@"message"] != [NSNull null]) {
            NSError *error = [NSError errorWithDomain:@"com.tapmind.error" code:1001 userInfo:@{ NSLocalizedDescriptionKey: [json valueForKey:@"message"] }];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
        }else{
            NSError *error = [NSError errorWithDomain:@"com.tapmind.error" code:1002 userInfo:@{ NSLocalizedDescriptionKey: @"Something went wrong please try again later" }];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
        }
    }];
    
    [task resume];
}
@end
