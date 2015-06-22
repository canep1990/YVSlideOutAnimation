//
//  UIView+YVSlideOutAnimation.h
//  SlidingViewAnimation
//
//  Created by Юрий Воскресенский on 18.06.15.
//  Copyright (c) 2015 Юрий Воскресенский. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Enum for describing the animation position
 */
typedef NS_ENUM (NSInteger, YVSlideOutAnimationPosition) {
    YVSlideOutAnimationPositionFromRightToLeft = 0,
    YVSlideOutAnimationPositionFromLeftToRight = 1,
    YVSlideOutAnimationPositionFromBottomToTop = 2,
    YVSlideOutAnimationPositionFromTopToBottom = 3
};

/**
 UIView category provides sliding animation without effecting any constraints. Supports stair-like animation effect on subviews.
 */
@interface UIView (YVSlideOutAnimation)

/** 
 Property for delaying the animation between subviews. Can't be less than 0
 Simply set this property and use one of the yv_slideOutAnimationForAllSubviewsFromPosition: selectors to see the animation.
 If you want to remove stair-like effect - set this property to 0.
 NOTE: When you want to animate only one view using selector yv_slideOutAnimationFromPosition:duration:delay:slidingOffset: setting this property won't have any effect.
 */
@property (strong, nonatomic) NSNumber *subviewAnimationDelay;

/**
 Easy way to implement stair-like animation effect on subviews.
 Use reversedOrder parameter to start animation from first/last subview. For example, if you want the animation to start from top to bottom, it's may be better to start from last subview.
 Default subview delay is 0.1
 Default animation duration is 0.3
 Default offset is 20
 Default animation delay is 0.1
 @param animationPosition Position from where to animate the view
 @param reversedOrder Flag for starting animation from first/last subview
 */
- (void)yv_slideOutAnimationForAllSubviewsFromPosition:(YVSlideOutAnimationPosition)animationPosition reversedOrder:(BOOL)reversed;

/** 
 Implement stair-like animation effect on subviews with custom parameters.
 @param animationPosition Position from where to animate the view
 @param duration Animation duration time
 @param delay Animation delay time
 @param slidingOffset Offset for sliding animation
 @param reversedOrder Flag for starting animation from first/last subview
 */
- (void)yv_slideOutAnimationForAllSubviewsFromPosition:(YVSlideOutAnimationPosition)animationPosition duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay slidingOffset:(CGFloat)offset reversedOrder:(BOOL)reversed;

/** 
 Slide animation for any view
 @param animationPosition Position from where to animate the view
 @param duration Animation duration time
 @param delay Animation delay time
 @param slidingOffset Offset for sliding animation
 */
- (void)yv_slideOutAnimationFromPosition:(YVSlideOutAnimationPosition)animationPosition duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay slidingOffset:(CGFloat)offset;

@end
