//
//  IWHomeViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWHomeViewController.h"

@interface IWHomeViewController ()

@end

@implementation IWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *bu = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    [self.view addSubview:bu];
    [bu addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [bu setBackgroundColor:[UIColor redColor]];
}

- (void)buttonClick:(UIButton *)btn
{
    self.tabBarItem.badgeValue = @"4";
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
@end
