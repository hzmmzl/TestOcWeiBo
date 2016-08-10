//
//  AppDelegate.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/3.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "GuidePageViewController.h"
#import "OAuthViewController.h"
#import "UserAccountInfo.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    [self oauth2access_token];
    
    return YES;
}

//版本
- (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    // 上一次版本
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    
    if ([currentVersion isEqualToString:lastVersion])
    { //相同
        self.window.rootViewController = [[MainTabBarViewController alloc] init];
    } else { //不同
        self.window.rootViewController = [[GuidePageViewController alloc] init];
        
        // 存入当前版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)oauth2access_token
{
    if (UserAccountInfo.account) {
        self.window.rootViewController = [[MainTabBarViewController alloc] init];
    }else{
        self.window.rootViewController = [[OAuthViewController alloc] init];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
