//
//  YVView.m
//  YVSlideOutAnimation
//
//  Created by Юрий Воскресенский on 22.06.15.
//  Copyright (c) 2015 Yury Voskresensky. All rights reserved.
//

#import "YVView.h"

@implementation YVView

- (void)awakeFromNib
{
    self.subviewAnimationDelay = [NSNumber numberWithFloat:0.2];
    [self yv_slideOutAnimationForAllSubviewsFromPosition:YVSlideOutAnimationPositionFromRightToLeft duration:0.3 delay:0.1 slidingOffset:50 reversedOrder:NO];
}

@end
