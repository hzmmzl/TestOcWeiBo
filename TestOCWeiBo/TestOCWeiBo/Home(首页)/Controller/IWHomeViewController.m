//
//  IWHomeViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWHomeViewController.h"
#import "UIBarButtonItem+HeadName.h"
#import "UserAccountInfo.h"
#import "IWTitleButton.h"
#import "TitleView.h"
@interface IWHomeViewController ()
@property (nonatomic,strong)TitleView *titleButton;
@end

@implementation IWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavBarItems];//导航条上
    [self setupUserStatus];
}

- (void)setupUserStatus
{
   NetWorkManager *manager = [NetWorkManager shareManager];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:UserAccountInfo.account.access_token forKey:@"access_token"];
    [manager getRequestWithUrl:@"statuses/home_timeline.json" Parameters:parametersDic Progress:^(NSProgress *progress) {
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"status = %@",responseObject);
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error%@",error);
    }];
}


- (void)setupNavBarItems
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithNormalImage:@"navigationbar_friendsearch" HighlightedImage:@"navigationbar_friendsearch_highlighted" Title:nil TitleSize:0 maxSize:CGSizeMake(0, 0) Target:self Action:@selector(findFriend)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithNormalImage:@"navigationbar_pop" HighlightedImage:@"navigationbar_pop_highlighted" Title:nil TitleSize:0 maxSize:CGSizeMake(0, 0) Target:self Action:@selector(pop)];
    
    //    IWTitleButton *titleButton = [IWTitleButton titleButton];
    //    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    //    [titleButton setTitle:@"哈哈哈哈" forState:UIControlStateNormal];
    //    titleButton.frame = CGRectMake(0, 0, 100, 40);
    //    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    //    self.navigationItem.titleView = titleButton;
    
    //标题按钮
    self.titleButton = [TitleView titleView];
    _titleButton.titleViewTitle.text = @"啊哈哈哈";
    _titleButton.titleViewTitle.font = kSystemBoldFontSize(16);
    
    CGSize size = [_titleButton.titleViewTitle.text boundingRectWithSize:CGSizeMake(300, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSystemBoldFontSize(16)} context:nil].size;
    _titleButton.frame = CGRectMake(0, 0, size.width + _titleButton.titleViewImage.image.size.width + 10, 30);
    [_titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _titleButton;
}

- (void)titleClick:(TitleView *)button
{
    if (button.selected == NO) {
        [UIView animateWithDuration:0.3 animations:^{
            button.titleViewImage.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            button.titleViewImage.transform = CGAffineTransformMakeRotation(0);
        }];
    }
    button.selected = !button.selected;
    
    NSLog(@"titleView");
}
- (void)findFriend
{
    NSLog(@"findFriend");
}

- (void)pop
{
    NSLog(@"pop");
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
