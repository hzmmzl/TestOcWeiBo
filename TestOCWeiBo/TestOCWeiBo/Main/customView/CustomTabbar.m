//
//  CustomTabbar.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/3.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "CustomTabbar.h"
#import "CustomBadgeButton.h"
#import "CustomTabBarButton.h"
@interface CustomTabbar()
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, strong) CustomTabBarButton *selectedButton;
@property (nonatomic, strong) UIButton *plusButton;
@end
@implementation CustomTabbar

- (NSMutableArray *)tabBarButtons
{
    if (!_tabBarButtons) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加一个加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [self addSubview:plusButton];

    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    CustomTabBarButton *button = [[CustomTabBarButton alloc] init];
    [self addSubview:button];
    [self.tabBarButtons addObject:button];
    button.item = item;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonClicked:(CustomTabBarButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:(int)(self.selectedButton.tag) to:(int)(button.tag)];
        self.selectedButton.selected = NO;
        button.selected = YES;
        self.selectedButton = button;
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
    // 按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.tabBarButtons.count; index++) {
        // 1.取出按钮
        CustomTabBarButton *button = self.tabBarButtons[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        if (index > 1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}

@end
