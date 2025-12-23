//
//  TMNativeAdLoader.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 25/11/25.
//

#import "TMNativeAdLoader.h"
#import "TMNativeAd.h"
#import "TMAdInfoView.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
//#import <FBAudienceNetwork/FBAudienceNetwork.h>
#import "BidAPIManager.h"
#import "BidRequest.h"
#import "BidResponse.h"
#import "AdUnit.h"
#import "TapMind.h"
//FBNativeAdDelegate, FBMediaViewDelegate
@interface TMNativeAdLoader ()<GADNativeAdLoaderDelegate, GADVideoControllerDelegate, GADNativeAdDelegate>
@property (nonatomic, weak) id<TMNativeAdLoaderDelegate> nativeDelegate;
@property(nonatomic, strong) GADAdLoader *adLoader;
//@property (strong, nonatomic) FBNativeAd *nativeAd;
//@property(nonatomic, strong) FBMediaView *mediaView;
@property(nonatomic, strong) TMNativeAd *sdkNewAd;
@end

static TMNativeAdLoader *sharedInstance = nil;
static dispatch_once_t onceToken;

@implementation TMNativeAdLoader {
    NSError *adError;
    TMNativeAdRequest *request;
    NSMutableArray<AdUnit *> *adUnitData;
    AdUnit *adUnit;
}

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)initWithRequest:(TMNativeAdRequest *)adRequest
                         delegate:(id<TMNativeAdLoaderDelegate>)delegate {
    NSLog(@"[SDK] +Native loadNativeAdWithAdRequest");
    request = adRequest;
    self.nativeDelegate = delegate;
    
    BidRequest *request = [BidRequest new];
    request.appName = [TapMind appName];
    request.placementName = adRequest.placement;
    request.version = [TapMind sdkVersion];
    request.platform = @"IOS";
    request.environment = @"dev";
    request.adType = @"Native";
    request.country = [TapMind countryCode];
    
    NSLog(@"[TapMindSDK] Request for api ==== App Name : %@, placementName : %@", [TapMind appName], adRequest.placement);
    
    [adUnitData removeAllObjects];
    [BidAPIManager fetchBidWithRequest:request completion:^(BidResponse *response, NSError *error) {
        if (error) {
            NSLog(@"[TapMindSDK] Received response with error from api end === %@", error);
            [self.nativeDelegate didFailToReceiveAdWithError:error];
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

- (void)loadNativeAd {
    GADVideoOptions *videoOptions = [[GADVideoOptions alloc] init];
    videoOptions.startMuted = NO;
    // ca-app-pub-3940256099942544/3986624511
    self.adLoader = [[GADAdLoader alloc] initWithAdUnitID:[adUnit adUnitId]
                                       rootViewController:[request viewController]
                                                  adTypes:@[ GADAdLoaderAdTypeNative ]
                                                  options:@[ videoOptions ]];
    self.adLoader.delegate = self;
    [self.adLoader loadRequest:[GADRequest request]];
    //    [FBAdSettings addTestDevice: [FBAdSettings testDeviceHash]];
    //
    //    self.nativeAd = [[FBNativeAd alloc] initWithPlacementID:@"3361065750713338_3367165583436688"];
    //    self.nativeAd.delegate = self;
    //    [self.nativeAd loadAd];
}

- (void)adLoader:(GADAdLoader *)adLoader didReceiveNativeAd:(GADNativeAd *)nativeAd {
//    GADMediaView *test;
//    test.mediaContent
//    if (nativeAd.mediaContent.hasVideoContent) {
//        NSLog(@"[SDK] +Native hasVideo");
//    } else {
//        NSLog(@"[SDK] +Native noVideo");
//    }
    
    nativeAd.delegate = self;
    
    self.sdkNewAd = [[TMNativeAd alloc] init];
    self.sdkNewAd.headline = nativeAd.headline;
    self.sdkNewAd.body = nativeAd.body;
    self.sdkNewAd.callToAction = nativeAd.callToAction;
    self.sdkNewAd.starRating = nativeAd.starRating;
    self.sdkNewAd.store = nativeAd.store;
    self.sdkNewAd.price = nativeAd.price;
    self.sdkNewAd.advertiser = nativeAd.advertiser;
    self.sdkNewAd.icon = nativeAd.icon.image;
    self.sdkNewAd.iconURL = nativeAd.icon.imageURL;
    self.sdkNewAd.iconScale = nativeAd.icon.scale;
    self.sdkNewAd.image = nativeAd.images.firstObject.image;
    self.sdkNewAd.imageURL = nativeAd.images.firstObject.imageURL;
    self.sdkNewAd.imageScale = nativeAd.images.firstObject.scale;
    
    GADMediaView *mediaView = [[GADMediaView alloc] init];
    mediaView.mediaContent = nativeAd.mediaContent;
    self.sdkNewAd.mediaView = mediaView;
    
    self.sdkNewAd.mediaContentAspectRatio = nativeAd.mediaContent.aspectRatio;
    self.sdkNewAd.hasVideoContent = nativeAd.mediaContent.hasVideoContent;
    self.sdkNewAd.duration = nativeAd.mediaContent.duration;
    self.sdkNewAd.currentTime = nativeAd.mediaContent.currentTime;
    
//    GADAdChoicesView *adChoice = [[GADAdChoicesView alloc] init];
//    adChoice.
    self.sdkNewAd.adChoiceView = [[TMAdInfoView alloc] init];
    
    [self.nativeDelegate didLoadAdView:self.sdkNewAd];
}

- (void)adLoaderDidFinishLoading:(GADAdLoader *) adLoader {
  // The adLoader has finished loading ads, and a new request can be sent.
    [self.nativeDelegate adLoaderDidFinishLoading];
}

- (void)adLoader:(nonnull GADAdLoader *)adLoader didFailToReceiveAdWithError:(nonnull NSError *)error {
    [self loadNextBestAds];
//    [self.nativeDelegate didFailToReceiveAdWithError:error];
}

- (void)nativeAdDidRecordImpression:(GADNativeAd *)nativeAd {
  // The native ad was shown.
    [self.nativeDelegate nativeAdDidRecordImpression];
}

- (void)nativeAdDidRecordClick:(GADNativeAd *)nativeAd {
  // The native ad was clicked on.
    [self.nativeDelegate nativeAdDidRecordClick];
}

- (void)nativeAdWillPresentScreen:(GADNativeAd *)nativeAd {
  // The native ad will present a full screen view.
    [self.nativeDelegate nativeAdWillPresentScreen];
}

- (void)nativeAdWillDismissScreen:(GADNativeAd *)nativeAd {
  // The native ad will dismiss a full screen view.
    [self.nativeDelegate nativeAdDidDismissScreen];
}

- (void)nativeAdDidDismissScreen:(GADNativeAd *)nativeAd {
  // The native ad did dismiss a full screen view.
    [self.nativeDelegate nativeAdWillDismissScreen];
}

- (void)nativeAdWillLeaveApplication:(GADNativeAd *)nativeAd {
  // The native ad will cause the app to become inactive and
  // open a new app.
    [self.nativeDelegate nativeAdWillLeaveApplication];
}

//- (void)nativeAdDidLoad:(FBNativeAd *)nativeAd {
////    NSLog(@"%@", nativeAd.adChoicesLinkURL);
//    self.nativeAd = nativeAd;
//    
//    self.sdkNewAd = [[TMNativeAd alloc] init];
//    self.sdkNewAd.headline = nativeAd.headline;
//    
//    self.sdkNewAd.body = nativeAd.bodyText;
//    self.sdkNewAd.callToAction = nativeAd.callToAction;
//
//    self.sdkNewAd.advertiser = nativeAd.advertiserName;
//    self.sdkNewAd.icon = nativeAd.iconImage;
//    
////    [nativeAd downloadMedia];
//    FBAdChoicesView *adChoiceView = [[FBAdChoicesView alloc] init];
//    adChoiceView.nativeAd = nativeAd;
//    self.sdkNewAd.adChoiceView = adChoiceView;
//    
//    // ---- CREATE CUSTOM AD VIEW ----
//    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
//    container.backgroundColor = [UIColor whiteColor];
//    
//    // MEDIA VIEW (THIS IS WHAT YOU WANT)
//    self.mediaView = [[FBMediaView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
//    self.mediaView.delegate = self;
//    [container addSubview: self.mediaView];
//    
//    // ---- REGISTER VIEWS ----
//    [nativeAd registerViewForInteraction:container
//                               mediaView:self.mediaView
//                                iconView:nil
//                          viewController:nil
//                          clickableViews:@[container]];
//    
//    self.sdkNewAd.hasVideoContent = nativeAd.adFormatType != FBAdFormatTypeUnknown;
//    self.sdkNewAd.mediaContentAspectRatio = nativeAd.aspectRatio;
//    self.sdkNewAd.mediaView = self.mediaView;
//    
//    [self.nativeDelegate didLoadAdView: self.sdkNewAd];
//}
//
//-(void)mediaViewDidLoad:(FBMediaView *)mediaView {
//    NSLog(@"%lu", (unsigned long)mediaView.nativeAdViewTag);
//}
//
//-(void)mediaViewVideoDidPlay:(FBMediaView *)mediaView {
//    
//}

- (void)loadNextBestAds {
    if (adUnitData.count > 0) {
        adUnit = [adUnitData objectAtIndex:0];
        [adUnitData removeObjectAtIndex:0];
        NSLog(@"[TapMindSDK] Receive Ad Unit ID from api ==== %@", [adUnit adUnitId]);
        NSLog(@"[TapMindSDK] Receive Partner from api ==== %@", [adUnit partner]);
        [self loadNativeAd];
    }else{
        [self.nativeDelegate didFailToReceiveAdWithError: adError];
    }
}
@end
