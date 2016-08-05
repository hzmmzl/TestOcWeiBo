//
//  MainTabBarViewController.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/3.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildViewControllers];
    
    
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
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vcController];
        [self addChildViewController:nav];
    }
}



@end
