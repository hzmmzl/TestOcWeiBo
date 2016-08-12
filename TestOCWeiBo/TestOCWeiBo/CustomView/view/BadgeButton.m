//
//  BadgeButton.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/11.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "BadgeButton.h"

@implementation BadgeButton
//@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentVC;
//@property (weak, nonatomic) IBOutlet CustomBadgeButton *badgeValue1;
//@property (weak, nonatomic) IBOutlet CustomBadgeButton *badgeValue2;

+ (BadgeButton *)badgeButton
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BadgeButton" owner:self options:nil] lastObject];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.badgeValue = [[CustomBadgeButton alloc] init];
        [self addSubview:_badgeValue];
        
        self.badgeValue2 = [[CustomBadgeButton alloc] init];
        [self addSubview:_badgeValue2];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _badgeValue.x = self.width * 0.25 +20;
    _badgeValue.centerY = _badgeValue2.centerY = 12;
    _badgeValue2.x = self.width *0.75 + 20;
    
}

@end
