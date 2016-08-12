//
//  BadgeButton.h
//  TestOCWeiBo
//
//  Created by winbei on 16/8/11.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBadgeButton.h"
@interface BadgeButton : UIView
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentVC;
@property (strong, nonatomic) CustomBadgeButton *badgeValue2;
@property (strong, nonatomic) CustomBadgeButton *badgeValue;
+(BadgeButton *)badgeButton;
@end
