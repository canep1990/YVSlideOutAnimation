//
//  UIView+YVSlideOutAnimation.m
//  SlidingViewAnimation
//
//  Created by Юрий Воскресенский on 18.06.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import "UIView+YVSlideOutAnimation.h"
#import <objc/runtime.h>

static NSTimeInterval const YVDefaultAnimationDurationTimeInterval = 0.3;

static NSTimeInterval const YVDefaultAnimationDelayTimeInterval = 0.1;

static CGFloat const YVDefaultAnimationOffset = 20;

@implementation UIView (YVSlideOutAnimation)

- (void)setSubviewAnimationDelay:(NSNumber *)subviewAnimationDelay
{
    if (subviewAnimationDelay)
        NSAssert(subviewAnimationDelay.doubleValue >= 0, @"View animation delay can't be less than zero!");
    objc_setAssociatedObject(self, @selector(subviewAnimationDelay), subviewAnimationDelay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)subviewAnimationDelay
{
    return objc_getAssociatedObject(self, @selector(subviewAnimationDelay));
}

- (void)yv_slideOutAnimationForAllSubviewsFromPosition:(YVSlideOutAnimationPosition)animationPosition reversedOrder:(BOOL)reversed
{
    NSArray *subviewsArray = self.subviews;
    CGFloat delay = YVDefaultAnimationDelayTimeInterval;
    if (reversed)
    {
        [self yv_animateSubviewsReversedFromPosition:animationPosition subviews:subviewsArray duration:YVDefaultAnimationDurationTimeInterval delay:delay slidingOffset:YVDefaultAnimationOffset];
    }
    else
    {
        [self yv_animateSubviewFromPosition:animationPosition subviews:subviewsArray duration:YVDefaultAnimationDurationTimeInterval delay:YVDefaultAnimationDelayTimeInterval slidingOffset:YVDefaultAnimationOffset];
    }
}

- (void)yv_slideOutAnimationForAllSubviewsFromPosition:(YVSlideOutAnimationPosition)animationPosition duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay slidingOffset:(CGFloat)offset reversedOrder:(BOOL)reversed
{
    NSArray *subviewsArray = self.subviews;
    if (reversed)
    {
        [self yv_animateSubviewsReversedFromPosition:animationPosition subviews:subviewsArray duration:duration delay:delay slidingOffset:offset];
    }
    else
    {
        [self yv_animateSubviewFromPosition:animationPosition subviews:subviewsArray duration:duration delay:delay slidingOffset:offset];
    }

}

- (void)yv_animateSubviewsReversedFromPosition:(YVSlideOutAnimationPosition)animationPosition subviews:(NSArray *)subviewsArray duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay slidingOffset:(CGFloat)offset
{
    if (subviewsArray && subviewsArray.count > 0)
    {
        for (NSInteger i = subviewsArray.count-1; i >= 0; --i )
        {
            UIView *viewToAnimate = [subviewsArray objectAtIndex:i];
            if (self.subviewAnimationDelay)
            {
                delay = delay + self.subviewAnimationDelay.doubleValue;
            }
            else
            {
                delay = delay + YVDefaultAnimationDelayTimeInterval;
            }
            [viewToAnimate yv_slideOutAnimationFromPosition:animationPosition duration:duration delay:delay slidingOffset:offset];
        }
    }
}

- (void)yv_animateSubviewFromPosition:(YVSlideOutAnimationPosition)animationPosition subviews:(NSArray *)subviewsArray duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay slidingOffset:(CGFloat)offset
{
    if (subviewsArray && subviewsArray.count > 0)
    {
        for (UIView *viewToAnimate in subviewsArray)
        {
            if (self.subviewAnimationDelay)
            {
                delay = delay + self.subviewAnimationDelay.doubleValue;
            }
            else
            {
                delay = delay + YVDefaultAnimationDelayTimeInterval;
            }
            [viewToAnimate yv_slideOutAnimationFromPosition:animationPosition duration:duration delay:delay slidingOffset:offset];
        }
    }
}

- (void)yv_slideOutAnimationFromPosition:(YVSlideOutAnimationPosition)animationPosition duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay slidingOffset:(CGFloat)offset
{
    NSAssert(duration > 0, @"Animation duration can't be less than or equal to zero!");
    NSAssert(offset >= 0, @"Sliding offset can't be less than zero!");
    switch (animationPosition)
    {
        case YVSlideOutAnimationPositionFromBottomToTop:
        {
            self.transform = CGAffineTransformMakeTranslation(0, self.superview.frame.size.height + self.frame.size.height + self.frame.origin.y);
        }
            break;
        case YVSlideOutAnimationPositionFromLeftToRight:
        {
            self.transform = CGAffineTransformMakeTranslation(0 - self.frame.origin.x*2 - self.frame.size.width*2, 0);
        }
            break;
        case YVSlideOutAnimationPositionFromRightToLeft:
        {
            self.transform = CGAffineTransformMakeTranslation(self.superview.frame.size.width + self.frame.size.width, 0);
        }
            break;
        case YVSlideOutAnimationPositionFromTopToBottom:
        {
            self.transform = CGAffineTransformMakeTranslation(0, 0 - self.superview.frame.size.height - self.frame.size.height - self.frame.origin.y);
        }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGAffineTransform identityTransform = CGAffineTransformIdentity;
        switch (animationPosition)
        {
            case YVSlideOutAnimationPositionFromBottomToTop:
            {
                if (offset != 0)
                    identityTransform.ty = identityTransform.ty - offset;
            }
                break;
            case YVSlideOutAnimationPositionFromLeftToRight:
            {
                if (offset != 0)
                    identityTransform.tx = identityTransform.tx + offset;
            }
                break;
                
            case YVSlideOutAnimationPositionFromRightToLeft:
            {
                if (offset != 0)
                    identityTransform.tx = identityTransform.tx - offset;
            }
                break;
            case YVSlideOutAnimationPositionFromTopToBottom:
            {
                if (offset != 0)
                    identityTransform.ty = identityTransform.ty + offset;
            }
                break;
                
            default:
                break;
        }
        self.transform = identityTransform;
    } completion:^(BOOL finished) {
        if (finished)
        {
            if (offset != 0)
            {
                [UIView animateWithDuration:0.3 animations:^{
                    self.transform = CGAffineTransformIdentity;
                }];
            }
        }
    }];
    
}

@end

