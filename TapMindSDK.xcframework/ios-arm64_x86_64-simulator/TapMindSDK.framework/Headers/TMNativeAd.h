//
//  TMNativeAd.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 25/11/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <TapMindSDK/TMMediaView.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMNativeAd : NSObject
/// The appId.
@property(nonatomic, copy) NSString *appId;
@property(nonatomic, copy) NSString *adapterId;
@property(nonatomic, copy) NSString *placementId;
@property(nonatomic, copy) NSString *partner;
@property(nonatomic, copy) NSString *adType;
/// The name of an advertiser.
@property(nonatomic, copy) NSString *advertiser;

/// The body text of the ad.
@property(nonatomic, copy) NSString *body;

/// The ad's call to action, such as "click here."
@property(nonatomic, copy) NSString *callToAction;

/// The ad's headline.
@property(nonatomic, copy) NSString *headline;

/// The icon image associated with the ad.
@property(nonatomic, strong) UIImage *icon;

/// The URL from which the icon image can be downloaded.
@property(nonatomic, copy) NSURL *iconURL;

/// The scale of the image file (pixels/pts) that can be downloaded from iconURL.
@property(nonatomic, assign) CGFloat iconScale;

/// The main image associated with the ad.
@property(nonatomic, strong) UIImage *image;

/// The URL from which the ad's main image can be downloaded.
@property(nonatomic, copy) NSURL *imageURL;

/// The scale of the image file (pixels/pts) that can be downloaded from imageURL.
@property(nonatomic, assign) CGFloat imageScale;

/// The main video associated with the ad.
@property(nonatomic) UIView *mediaView;

@property(nonatomic) UIView *adChoiceView;

/// The price of the app being advertised.
@property(nonatomic, copy) NSString *price;

/// The star rating of the advertised app.
@property(nonatomic, copy) NSDecimalNumber *starRating;

/// The store from which the app can be purchased.
@property(nonatomic, copy) NSString *store;

/// The ad's degree of awesomeness. This is a simple string field designed to show how
/// custom events and adapters can handle extra assets.
@property(nonatomic, copy) NSString *degreeOfAwesomeness;

@property(nonatomic, readwrite) CGFloat mediaContentAspectRatio;

@property(nonatomic, readwrite) double duration;

@property(nonatomic, readwrite) double currentTime;

@property(nonatomic, readwrite) BOOL hasVideoContent;

/// Handles clicks on the native ad's assets (it just NSLogs them).
- (void)handleClickOnView:(UIView *)view;

/// Records impressions for the native ad (it just NSLogs them).
- (void)recordImpression;

/// Starts playing the video after the view is rendered
- (void)playVideo;
@end

NS_ASSUME_NONNULL_END
