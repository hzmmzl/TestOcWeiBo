//
//  CustomTabbar.h
//  TestOCWeiBo
//
//  Created by winbei on 16/8/3.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTabbar;
@protocol CustomTabbarDelegate <NSObject>

@optional
- (void)tabBar:(CustomTabbar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
@end

@interface CustomTabbar : UIView
@property (nonatomic, weak) id<CustomTabbarDelegate> delegate;
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@end
