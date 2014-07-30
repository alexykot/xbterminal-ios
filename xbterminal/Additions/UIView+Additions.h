//
//  UIView+Additions.h
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 05.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

+ (id)loadFromNib;
+ (id)loadFromNib:(NSString *)nibName;
+ (id)loadFromNibWithOwner:(id)owner;
+ (id)loadFromNib:(NSString *)nibName withOwner:(id)owner;

@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void(^)())completion;

- (void)pulse;

- (void)shake;

@end
