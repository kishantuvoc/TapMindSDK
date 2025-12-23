//
//  TMRewardedAd.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 02/12/25.
//

#import "TMRewardedAd.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "AdUnit.h"
#import "BidAPIManager.h"
#import "BidRequest.h"
#import "BidResponse.h"
#import "TapMind.h"

@interface TMRewardedAd ()<GADFullScreenContentDelegate>
@property(nonatomic, strong) GADRewardedAd *googleRewardedAd;
@property (nonatomic, weak) id<TMRewardedDelegate> rewardedDelegate;
@end

static TMRewardedAd *sharedInstance = nil;
static dispatch_once_t onceToken;

@implementation TMRewardedAd {
    NSError *adError;
    TMRewardedAdRequest *request;
    NSMutableArray<AdUnit *> *adUnitData;
    AdUnit *adUnit;
}

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)initWithRequest:(TMRewardedAdRequest *)adRequest
                           delegate:(id<TMRewardedDelegate>)delegate {
    request = adRequest;
    self.rewardedDelegate = delegate;
    
    BidRequest *request = [BidRequest new];
    request.appName = [TapMind appName];
    request.placementName = adRequest.placement;
    request.version = [TapMind sdkVersion];
    request.platform = @"IOS";
    request.environment = @"dev";
    request.adType = @"Rewarded";
    request.country = [TapMind countryCode];
    
    NSLog(@"[TapMindSDK] Request for api ==== App Name : %@, placementName : %@", [TapMind appName], adRequest.placement);
    
    [adUnitData removeAllObjects];
    [BidAPIManager fetchBidWithRequest:request completion:^(BidResponse *response, NSError *error) {
        if (error) {
            NSLog(@"[TapMindSDK] Received response with error from api end === %@", error);
            [self.rewardedDelegate didFailToReceiveAdWithError:error];
        }else{
            NSArray<AdUnit *> *sortedArray =
                [[response data] sortedArrayUsingDescriptors:@[
                    [NSSortDescriptor sortDescriptorWithKey:@"priority" ascending:YES]
                ]];
            self->adUnitData = [sortedArray mutableCopy];
            [self loadNextBestAds];
        }
    }];
}

- (void)loadRewardedAd {
    if ([[adUnit partner] isEqualToString:@"GAM"]) {
        [GADRewardedAd loadWithAdUnitID: [adUnit adUnitId]
                                request:[GAMRequest request]
                      completionHandler:^(GADRewardedAd *ad, NSError *error) {
            if (error) {
                self->adError = error;
                [self loadNextBestAds];
                NSLog(@"Rewarded ad failed to load with error: %@", [error localizedDescription]);
                return;
            }
            self.googleRewardedAd = ad;
            self.googleRewardedAd.fullScreenContentDelegate = self;
            [self.rewardedDelegate didReceivedAd];
        }];
    }else{
        [GADRewardedAd loadWithAdUnitID: [adUnit adUnitId]
                                request:[GADRequest request]
                      completionHandler:^(GADRewardedAd *ad, NSError *error) {
            if (error) {
                self->adError = error;
                [self loadNextBestAds];
                NSLog(@"Rewarded ad failed to load with error: %@", [error localizedDescription]);
                return;
            }
            self.googleRewardedAd = ad;
            self.googleRewardedAd.fullScreenContentDelegate = self;
            [self.rewardedDelegate didReceivedAd];
        }];
    }
    
}

- (void)showFromViewController:(UIViewController *)viewController {
    [self.googleRewardedAd presentFromRootViewController: viewController
                                userDidEarnRewardHandler:^{
        GADAdReward *reward = self.googleRewardedAd.adReward;
        NSString *rewardMessage = [NSString
                                   stringWithFormat:@"Reward received with currency %@ , amount %lf",
                                   reward.type, [reward.amount doubleValue]];
        NSLog(@"%@", rewardMessage);
        [self.rewardedDelegate rewardedAdDidUserEarnReward];
        // TODO: Reward the user.
    }];
}

- (void)adDidRecordImpression:(id<GADFullScreenPresentingAd>)ad {
    NSLog(@"%s called", __PRETTY_FUNCTION__);
    [self.rewardedDelegate adDidRecordImpression];
}

- (void)adDidRecordClick:(id<GADFullScreenPresentingAd>)ad {
    NSLog(@"%s called", __PRETTY_FUNCTION__);
    [self.rewardedDelegate adDidRecordClick];
}

- (void)adWillPresentFullScreenContent:(id<GADFullScreenPresentingAd>)ad {
    NSLog(@"%s called", __PRETTY_FUNCTION__);
    [self.rewardedDelegate adWillPresentFullScreenContent];
}

- (void)adWillDismissFullScreenContent:(id<GADFullScreenPresentingAd>)ad {
    NSLog(@"%s called", __PRETTY_FUNCTION__);
    [self.rewardedDelegate adWillDismissFullScreenContent];
}

- (void)adDidDismissFullScreenContent:(id<GADFullScreenPresentingAd>)ad {
    NSLog(@"%s called", __PRETTY_FUNCTION__);
    // Clear the rewarded ad.
    //  self.rewardedAd = nil;
    [self.rewardedDelegate adDidDismissFullScreenContent];
}

- (void)ad:(id)ad didFailToPresentFullScreenContentWithError:(NSError *)error {
    NSLog(@"%s called with error: %@", __PRETTY_FUNCTION__, error.localizedDescription);
    [self loadNextBestAds];
}

- (void)loadNextBestAds {
    if (adUnitData.count > 0) {
        adUnit = [adUnitData objectAtIndex:0];
        [adUnitData removeObjectAtIndex:0];
        NSLog(@"[TapMindSDK] Receive Ad Unit ID from api ==== %@", [adUnit adUnitId]);
        NSLog(@"[TapMindSDK] Receive Partner from api ==== %@", [adUnit partner]);
        [self loadRewardedAd];
    }else{
        [self.rewardedDelegate didFailToReceiveAdWithError: adError];
    }
}
@end
