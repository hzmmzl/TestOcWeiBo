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
        self.plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [_plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [_plusButton sizeToFit];
        [self addSubview:_plusButton];
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    CustomTabBarButton *custButton = [[CustomTabBarButton alloc] init];
    
    [custButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
    
    custButton.item = item;
    [self addSubview:custButton];
    [self.tabBarButtons addObject:custButton];
    if (self.tabBarButtons.count >= 1) {
        [self buttonClicked:self.tabBarButtons[0]];
    }
    
}

- (void)buttonClicked:(CustomTabBarButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    CGFloat w = self.width / count;
    CGFloat h = self.frame.size.height;
    CGFloat y = 0;
    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    for (int i=0; i<self.tabBarButtons.count; i++) {
        CustomTabBarButton *subView = self.tabBarButtons[i];
            subView.tag = i;
        CGFloat x = w*i;
        if (i>1) {
            x += w;
        }
            subView.frame = CGRectMake(x, y, w, h);
    
        
    }
}

@end
