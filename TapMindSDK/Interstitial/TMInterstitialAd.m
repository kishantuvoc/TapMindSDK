//
//  TMInterstitialAd.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 25/11/25.
//

#import "TMInterstitialAd.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "AdUnit.h"
#import "BidAPIManager.h"
#import "BidRequest.h"
#import "BidResponse.h"
#import "TapMind.h"

@interface TMInterstitialAd ()<GADFullScreenContentDelegate>
@property(nonatomic, strong) GADInterstitialAd *admobInterstitial;
@property(nonatomic, strong) GAMInterstitialAd *gamInterstitial;
@property (nonatomic, weak) id<TMInterstitialDelegate> interstitialDelegate;
@end

static TMInterstitialAd *sharedInstance = nil;
static dispatch_once_t onceToken;

@implementation TMInterstitialAd {
    NSError *adError;
    TMInterstitialAdRequest *request;
    NSMutableArray<AdUnit *> *adUnitData;
    AdUnit *adUnit;
}

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)initWithRequest:(TMInterstitialAdRequest *)adRequest
                               delegate:(id<TMInterstitialDelegate>)delegate {
    request = adRequest;
    self.interstitialDelegate = delegate;
    
    BidRequest *request = [BidRequest new];
    request.appName = [TapMind appName];
    request.placementName = adRequest.placement;
    request.version = [TapMind sdkVersion];
    request.platform = @"IOS";
    request.environment = @"dev";
    request.adType = @"Interstitial";
    request.country = [TapMind countryCode];
    
    NSLog(@"[TapMindSDK] Request for api ==== App Name : %@, placementName : %@", [TapMind appName], adRequest.placement);
    
    [adUnitData removeAllObjects];
    [BidAPIManager fetchBidWithRequest:request completion:^(BidResponse *response, NSError *error) {
        if (error) {
            NSLog(@"[TapMindSDK] Received response with error from api end === %@", error);
            [self.interstitialDelegate didFailToReceiveAdWithError:error];
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

- (void)loadInterstitialAd {
    if ([[adUnit partner] isEqualToString:@"GAM"]) {
        [GAMInterstitialAd loadWithAdManagerAdUnitID:[adUnit adUnitId] request:[GAMRequest request] completionHandler:^(GAMInterstitialAd *interstitialAd, NSError *error) {
            if (error) {
                NSLog(@"Failed to load interstitial ad with error: %@", [error localizedDescription]);
                self->adError = error;
                [self loadNextBestAds];
                return;
            }
            self.gamInterstitial = interstitialAd;
            self.gamInterstitial.fullScreenContentDelegate = self;
            [self.interstitialDelegate didReceivedAd];
        }];
    }else{
        [GADInterstitialAd loadWithAdUnitID: [adUnit adUnitId] request: [GADRequest request] completionHandler:^(GADInterstitialAd *ad, NSError *error) {
            if (error) {
                NSLog(@"Failed to load interstitial ad with error: %@", [error localizedDescription]);
                self->adError = error;
                [self loadNextBestAds];
                return;
            }
            self.admobInterstitial = ad;
            self.admobInterstitial.fullScreenContentDelegate = self;
            [self.interstitialDelegate didReceivedAd];
        }];
    }
    
}

- (void)showFromViewController:(UIViewController *)viewController {
    if ([[adUnit partner] isEqualToString:@"GAM"]) {
        [self.gamInterstitial presentFromRootViewController: viewController];
    }else{
        [self.admobInterstitial presentFromRootViewController: viewController];
    }
}

- (void)adDidRecordImpression:(id<GADFullScreenPresentingAd>)ad {
//    NSLog(@"%s called", __PRETTY_FUNCTION__);
    [self.interstitialDelegate adDidRecordImpression];
}

- (void)adDidRecordClick:(id<GADFullScreenPresentingAd>)ad {
//    NSLog(@"%s called", __PRETTY_FUNCTION__);
    [self.interstitialDelegate adDidRecordClick];
}

- (void)ad:(id<GADFullScreenPresentingAd>)ad didFailToPresentFullScreenContentWithError:(NSError *)error {
//    NSLog(@"%s called with error: %@", __PRETTY_FUNCTION__, error.localizedDescription);
    [self.interstitialDelegate didFailToReceiveAdWithError:error];
}

- (void)adWillPresentFullScreenContent:(id<GADFullScreenPresentingAd>)ad {
//    NSLog(@"%s called", __PRETTY_FUNCTION__);
    [self.interstitialDelegate adWillPresentFullScreenContent];
}

- (void)adWillDismissFullScreenContent:(id<GADFullScreenPresentingAd>)ad {
//    NSLog(@"%s called", __PRETTY_FUNCTION__);
    [self.interstitialDelegate adWillDismissFullScreenContent];
}

- (void)adDidDismissFullScreenContent:(id<GADFullScreenPresentingAd>)ad {
//    NSLog(@"%s called", __PRETTY_FUNCTION__);
    [self.interstitialDelegate adDidDismissFullScreenContent];
}

- (void)loadNextBestAds {
    if (adUnitData.count > 0) {
        adUnit = [adUnitData objectAtIndex:0];
        [adUnitData removeObjectAtIndex:0];
        NSLog(@"[TapMindSDK] Receive Ad Unit ID from api ==== %@", [adUnit adUnitId]);
        NSLog(@"[TapMindSDK] Receive Partner from api ==== %@", [adUnit partner]);
        [self loadInterstitialAd];
    }else{
        [self.interstitialDelegate didFailToReceiveAdWithError: adError];
    }
}
@end
