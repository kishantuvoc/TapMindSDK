//
//  TMBannerView.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 25/11/25.
//

#import "TMBannerView.h"
#import "BidAPIManager.h"
#import "BidRequest.h"
#import "BidResponse.h"
#import "AdUnit.h"
#import "TapMind.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
//#import <FBAudienceNetwork/FBAudienceNetwork.h>
//FBAdViewDelegate
@interface TMBannerView ()<GADBannerViewDelegate>
@property(nonatomic, strong) GADBannerView *admobBannerView;
@property(nonatomic, strong) GAMBannerView *gamBannerView;
//@property(nonatomic, strong) FBAdView *fbBannerView;
@property (nonatomic, weak) id<TMBannerDelegate> bannerDelegate;
@end

static TMBannerView *sharedInstance = nil;
static dispatch_once_t onceToken;
@implementation TMBannerView {
    NSError *adError;
    TMBannerAdRequest *request;
    NSMutableArray<AdUnit *> *adUnitData;
    AdUnit *adUnit;
}

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (void)initWithRequest:(TMBannerAdRequest *)adRequest
                         delegate:(id<TMBannerDelegate>)delegate {
    request = adRequest;
    self.bannerDelegate = delegate;
    
    BidRequest *request = [BidRequest new];
    request.appName = [TapMind appName];
    request.placementName = adRequest.placement;
    request.version = [TapMind sdkVersion];
    request.platform = @"IOS";
    request.environment = @"dev";
    request.adType = @"Banner";
    request.country = [TapMind countryCode];
    
    NSLog(@"[TapMindSDK] Request for api ==== App Name : %@, placementName : %@", [TapMind appName], adRequest.placement);
    //    NSLog(@"Type ==== %@", countryCode);
    
    NSDate *currentDate = [NSDate date];

    // Get time interval since 1970 in seconds (NSTimeInterval is in seconds)
    NSTimeInterval seconds = [currentDate timeIntervalSince1970];

    // Convert seconds to milliseconds
    long long milliseconds = (long long)(seconds * 1000);

//    NSLog(@"Current date in milliseconds1: %lld", milliseconds);
    [adUnitData removeAllObjects];
    [BidAPIManager fetchBidWithRequest:request completion:^(BidResponse *response, NSError *error) {
        //        NSLog(@"Api response === %@", response);
        if (error) {
            NSLog(@"[TapMindSDK] Received response with error from api end === %@", error);
            [self.bannerDelegate didFailToReceiveAdWithError:error];
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

- (void)loadBannerAd {
//    [FBAdSettings addTestDevice: [FBAdSettings testDeviceHash]];
//    self.fbBannerView = [[FBAdView alloc] initWithPlacementID: [adUnit adUnitId] adSize:kFBAdSizeHeight50Banner rootViewController:request.viewController];
//    self.fbBannerView.delegate = self;
//    [self.fbBannerView loadAd];
    
    if ([[adUnit partner] isEqualToString:@"GAM"]) {
        GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ @"b66fb84e7495bb8647ef38c8ef7b3838" ];
        self.gamBannerView = [[GAMBannerView alloc] initWithAdSize: GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(375)];
        self.gamBannerView.adUnitID = [adUnit adUnitId];
        self.gamBannerView.rootViewController = [request viewController];
        self.gamBannerView.delegate = self;
        [self.gamBannerView loadRequest: [GAMRequest request]];
    }else{
        GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ @"b66fb84e7495bb8647ef38c8ef7b3838" ];
        self.admobBannerView = [[GAMBannerView alloc] initWithAdSize: GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(375)];
        self.admobBannerView.adUnitID = [adUnit adUnitId];
        self.gamBannerView.rootViewController = [request viewController];
        self.gamBannerView.delegate = self;
        [self.gamBannerView loadRequest: [GAMRequest request]];
    }
}

#pragma mark - GADBannerViewDelegate

- (void)bannerViewDidReceiveAd:(GADBannerView *)bannerView {
//    NSLog(@"bannerViewDidReceiveAd");
    [self.bannerDelegate bannerViewDidReceiveAd:bannerView];
}

- (void)bannerView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"bannerView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
//    [self.bannerDelegate didFailToReceiveAdWithError:error];
    [self loadNextBestAds];
}

-(void)bannerViewDidRecordClick:(GADBannerView *)bannerView {
    [self.bannerDelegate bannerViewDidRecordClick];
}

- (void)bannerViewDidRecordImpression:(GADBannerView *)bannerView {
//    NSLog(@"bannerViewDidRecordImpression");
    [self.bannerDelegate bannerViewDidRecordImpression];
}

- (void)bannerViewWillPresentScreen:(GADBannerView *)bannerView {
//    NSLog(@"bannerViewWillPresentScreen");
    [self.bannerDelegate bannerViewWillPresentScreen];
}

- (void)bannerViewWillDismissScreen:(GADBannerView *)bannerView {
//    NSLog(@"bannerViewWillDismissScreen");
    [self.bannerDelegate bannerViewDidDismissScreen];
}

- (void)bannerViewDidDismissScreen:(GADBannerView *)bannerView {
//    NSLog(@"bannerViewDidDismissScreen");
    [self.bannerDelegate bannerViewDidDismissScreen];
}

#pragma mark - FBAdViewDelegate

//- (void)adViewDidLoad:(FBAdView *)adView {
////    NSLog(@"FAN Banner loaded successfully.");
//    [self.bannerDelegate bannerViewDidReceiveAd: adView];
//}
//
//- (void)adViewDidFinishHandlingClick:(FBAdView *)adView {
////    NSLog(@"Ad did finish click handling.");
//}
//
//- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error {
////    NSLog(@"FAN Banner failed to load: %@", error.localizedDescription);
//}
//
//- (void)adViewWillLogImpression:(FBAdView *)adView {
////    NSLog(@"FAN Banner impression logged.");
//}
//
//- (void)adViewDidClick:(FBAdView *)adView {
////    NSLog(@"FAN Banner clicked.");
//}


- (void)loadNextBestAds {
    if (adUnitData.count > 0) {
        adUnit = [adUnitData objectAtIndex:0];
        [adUnitData removeObjectAtIndex:0];
        NSLog(@"[TapMindSDK] Receive Ad Unit ID from api ==== %@", [adUnit adUnitId]);
        NSLog(@"[TapMindSDK] Receive Partner from api ==== %@", [adUnit partner]);
        [self loadBannerAd];
    }else{
        [self.bannerDelegate didFailToReceiveAdWithError: adError];
    }
}
@end
