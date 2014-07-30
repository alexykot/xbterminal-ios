//
//  UIView+Additions.m
//  xbterminal
//
//  Created by Evgeniy Tka4enko on 05.07.14.
//  Copyright (c) 2014 vexadev. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

+ (id)loadFromNib
{
    return [self loadFromNibWithOwner:nil];
}

+ (id)loadFromNib:(NSString *)nibName
{
    return [self loadFromNib:nibName withOwner:nil];
}

+ (id)loadFromNibWithOwner:(id)owner
{
    return [self loadFromNib:NSStringFromClass(self) withOwner:owner];
}

+ (id)loadFromNib:(NSString *)nibName withOwner:(id)owner
{
    return [[NSBundle mainBundle] loadNibNamed:nibName
                                         owner:owner
                                       options:nil][0];
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = y;
    self.frame = newFrame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = x;
    self.frame = newFrame;
}

- (CGFloat)width
{
    return self.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    self.frame = newFrame;
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = newFrame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect newFrame = self.frame;
    newFrame.origin = origin;
    self.frame = newFrame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect newFrame = self.frame;
    newFrame.size = size;
    self.frame = newFrame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated
{
    [self setHidden:hidden animated:animated completion:nil];
}

- (void)setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void(^)())completion
{
    if(animated)
    {
        UIViewAnimationOptions options;
        if(!hidden)
        {
            if(self.hidden)
            {
                self.hidden = NO;
                self.alpha = 0.0f;
                
                options = UIViewAnimationOptionAllowUserInteraction;
            }
            else
            {
                options = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction;
            }
        }
        else
        {
            if(self.alpha == 0.0f)
            {
                self.alpha = 1.0f;
            }
            
            options = UIViewAnimationOptionAllowUserInteraction;
        }
        [UIView animateWithDuration:0.3 delay:0.01 options:options animations:^{
            
            self.alpha = (hidden ? 0.0f : 1.0f);
            
        } completion:^(BOOL finished) {
            
            if(finished && hidden)
            {
                self.hidden = YES;
                self.alpha = 1.0f;
            }
            if(completion)
            {
                completion();
            }
            
        }];
    }
    else
    {
        self.hidden = hidden;
        if(completion)
        {
            completion();
        }
    }
}

- (void)pulse
{
    self.transform = CGAffineTransformMakeScale(0.6, 0.6);
    
	[UIView animateWithDuration: 0.2
					 animations: ^{
						 self.transform = CGAffineTransformMakeScale(1.1, 1.1);
					 }
					 completion: ^(BOOL __finished){
						 [UIView animateWithDuration:1.0/15.0
										  animations: ^{
											  self.transform = CGAffineTransformMakeScale(0.9, 0.9);
										  }
										  completion: ^(BOOL _finished){
											  [UIView animateWithDuration:1.0/7.5
															   animations: ^{
																   self.transform = CGAffineTransformIdentity;
															   }];
										  }];
					 }];
}

- (void)shake
{
    CGFloat t = 2.0;
    CGAffineTransform translateRight  = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
    CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    
    self.transform = translateLeft;
    
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        self.transform = translateRight;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:nil];
        }
    }];
}

@end
