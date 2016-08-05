//
//  CustomBadgeButton.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/3.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "CustomBadgeButton.h"

@implementation CustomBadgeButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateDisabled];
        [self sizeToFit];
        self.enabled = NO;
        self.hidden = YES;
        self.titleLabel.font = kSystemSize(10);
        CGRect frame = self.frame;
        frame.size.width = self.currentBackgroundImage.size.width;
        frame.size.height = self.currentBackgroundImage.size.height;
        self.frame = frame;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    CGRect frame = self.frame;
    frame.size.height = self.currentBackgroundImage.size.height;
    if (badgeValue && badgeValue.length >1) {
      CGSize size = [badgeValue sizeWithAttributes:@{NSFontAttributeName:kSystemSize(10)}];
        frame.size.width = size.width + 6;
        self.frame = frame;
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateDisabled];
    }else if(badgeValue){
        frame.size.width = self.currentBackgroundImage.size.width;
        self.frame = frame;
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateDisabled];
    }else{
        self.hidden = YES;
    }
}


@end
