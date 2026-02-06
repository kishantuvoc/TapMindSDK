//
//  TMNetworkType.h
//  TapMindSDK
//
//  Created by Kishan Italiya on 21/11/25.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TMNetworkType) {
    AdMob = 0,
    Facebook = 1,
    GAM = 2
};

/// Requested ad format.
typedef NS_ENUM(NSInteger, AdFormat) {
  TMAdFormatBanner = 0,                ///< Banner.
  TMAdFormatInterstitial = 1,          ///< Interstitial.
  TMAdFormatRewarded = 2,              ///< Rewarded.
  TMAdFormatNative = 3                ///< Native.
};
