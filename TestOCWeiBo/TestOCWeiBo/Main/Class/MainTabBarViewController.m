//
//  MainTabBarViewController.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/3.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "CustomTabbar.h"
@interface MainTabBarViewController ()<CustomTabbarDelegate>
@property (strong,nonatomic) CustomTabbar *customTabbar;
@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupItemButton];
    [self setupAllChildViewControllers];
}

//
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)setupItemButton
{
    self.customTabbar = [[CustomTabbar alloc] initWithFrame:self.tabBar.bounds];
//    _customTabbar.backgroundColor = [UIColor redColor];
    _customTabbar.delegate = self;
    [self.tabBar addSubview:_customTabbar];
}

- (void)setupAllChildViewControllers{
    NSArray *vcArray = @[@"IWHomeViewController",@"IWMessageViewController",@"IWDiscoverViewController",@"IWMessageViewController"];
    NSArray *vcNormalImageArray = @[@"tabbar_home",@"tabbar_message_center",@"tabbar_discover",@"tabbar_profile"];
    NSArray *vcSelectedImageArray = @[@"tabbar_home_selected",@"tabbar_message_center_selected",@"tabbar_discover_selected",@"tabbar_profile_selected"];
    NSArray *vcTitleArray = @[@"首页",@"消息",@"广场",@"我"];
    
    
    for (NSInteger i = 0; i<vcArray.count; i++) {
        UIViewController *vcController = [[NSClassFromString(vcArray[i]) alloc] init];
        vcController.title = vcTitleArray[i];
        vcController.tabBarItem.image = [UIImage imageNamed:vcNormalImageArray[i]];
        vcController.tabBarItem.selectedImage = [UIImage imageNamed:vcSelectedImageArray[i]];
        [_customTabbar addTabBarButtonWithItem:vcController.tabBarItem];//tabbaritem
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vcController];
        [self addChildViewController:nav];
    }
}


#pragma mark CustomTabbarDelegate
- (void)tabBar:(CustomTabbar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}


@end
