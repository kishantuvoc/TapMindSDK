//
//  TMAdInfoView.m
//  TapMindSDK
//
//  Created by Kishan Italiya on 27/11/25.
//

#import "TMAdInfoView.h"

@implementation TMAdInfoView

/// NS_DESIGNATED_INITIALIZER
- (instancetype)init {
  self = [super initWithFrame:CGRectMake(0, 0, 24.0, 24.0)];
  if (self) {
    [self createInfoImageView];
    self.backgroundColor = [UIColor clearColor];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                           action:@selector(infoViewTapped)]];
  }

  return self;
}

/// Creates and adds info image in the view hierarchy.
- (void)createInfoImageView {
  UIImageView *infoImageView =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"info_icon"]];
  [self addSubview:infoImageView];

  // Adding constraints to info image to cover the super view.
  NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(infoImageView);
  infoImageView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[infoImageView]|"
                                                               options:0
                                                               metrics:nil
                                                                 views:viewDictionary]];
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[infoImageView]|"
                                                               options:0
                                                               metrics:nil
                                                                 views:viewDictionary]];
}

/// Handles user tap on the view.
- (void)infoViewTapped {

}

@end
