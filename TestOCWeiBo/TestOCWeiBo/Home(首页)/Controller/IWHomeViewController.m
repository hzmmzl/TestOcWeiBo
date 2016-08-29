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
#import "SratusesFrameModel.h"
#import "SratusesModel.h"
#import "MJExtension.h"
#import "HomeStatusTableViewCell.h"
#import "UIImage+Size.h"
#import "UserModel.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
@interface IWHomeViewController ()
@property (nonatomic,strong)TitleView *titleButton;
@property (nonatomic , strong) NSMutableArray *statusFrameArray;
@property (nonatomic , strong) UIButton *statusButton;
@end

@implementation IWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavBarItems];//导航条上
    [self setupUserStatus];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //刷新
    [self setupRefreshView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

//刷新
- (void)setupRefreshView
{
    
}

- (void)showNewStatusCount:(int)count
{
    if (!_statusButton) {
        self.statusButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 24, kScreenWidth, 40)];
        [self.navigationController.view insertSubview:_statusButton belowSubview:self.navigationController.navigationBar];
        [_statusButton setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
        _statusButton.titleLabel.font = kSystemFontSize(14);
        [_statusButton setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
        
        _statusButton.enabled = NO;
    }
    self.statusButton.hidden = NO;
    [self.statusButton setTitle:[NSString stringWithFormat:@"你有%d条新消息哦~",count] forState:UIControlStateDisabled];
    [UIView animateWithDuration:0.7 animations:^{
        self.statusButton.transform = CGAffineTransformMakeTranslation(0, 42);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            self.statusButton.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.statusButton.hidden = YES;
        }];
    }];
}

- (void)setupUserStatus
{
    self.statusFrameArray = [NSMutableArray array];
   NetWorkManager *manager = [NetWorkManager shareManager];
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:UserAccountInfo.account.access_token forKey:@"access_token"];
    [parametersDic setObject:@10 forKey:@"count"];
    [manager getRequestWithUrl:@"statuses/home_timeline.json" Parameters:parametersDic Progress:^(NSProgress *progress) {
    } Success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        NSArray *tempArr = [SratusesModel mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        [self showNewStatusCount:(int)tempArr.count];
        for (SratusesModel *status in tempArr) {
            SratusesFrameModel *frameModel = [[SratusesFrameModel alloc] init];
            frameModel.sratusModel = status;
            [_statusFrameArray addObject:frameModel];
        }
        
        [self.tableView reloadData];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error%@",error);
    }];
}

/**
 *  获得用户信息
 */
- (void)setupUserData
{
    // 1.创建请求管理对象
    NetWorkManager *mgr = [NetWorkManager shareManager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [UserAccountInfo account].access_token;
    params[@"uid"] = @([UserAccountInfo account].uid);
    
    // 3.发送请求
    [mgr getRequestWithUrl:@"https://api.weibo.com/2/users/show.json" Parameters:params Progress:^(NSProgress *progress) {
    } Success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
//        UserModel *userModel = [UserModel userInfoWithDic:responseObject];
//        _titleButton.titleViewTitle.text = userModel.name;
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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
    _titleButton.titleViewTitle.text = @"啊哈哈哈";
    //标题按钮
    self.titleButton = [TitleView titleView];
    _titleButton.titleViewTitle.font = kSystemBoldFontSize(16);
    
    CGSize size = [_titleButton.titleViewTitle.text boundingRectWithSize:CGSizeMake(300, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSystemBoldFontSize(16)} context:nil].size;
    _titleButton.frame = CGRectMake(0, 0, size.width + _titleButton.titleViewImage.image.size.width + 10, 30);
    [_titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _titleButton;
    
    self.tableView.backgroundColor = kColorWithRBGA(226, 226, 226,1);
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _statusFrameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeStatusTableViewCell *cell = [HomeStatusTableViewCell cellWithTableView:tableView];
    cell.frameModel = _statusFrameArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SratusesFrameModel *frameModel = _statusFrameArray[indexPath.row];
    return frameModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
