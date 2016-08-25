//
//  HomeStatusTableViewCell.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/12.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "HomeStatusTableViewCell.h"
#import "UIImage+Size.h"
#import "IWStatusToolbar.h"
#import "StatusTopView.h"
@interface HomeStatusTableViewCell()

/** 微博的工具条 */
@property (nonatomic , strong) StatusTopView *topView;
@property (nonatomic , strong) IWStatusToolbar *statusToolbar;

@end


@implementation HomeStatusTableViewCell

+(HomeStatusTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"cellId";
    HomeStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HomeStatusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.topView = [[StatusTopView alloc] init];
        [self.contentView addSubview:_topView];
        [self setUpBottomMessage];
    }
    return self;
}


- (void)setFrameModel:(SratusesFrameModel *)frameModel
{
    _frameModel = frameModel;
    _topView.frameModel = frameModel;
    _statusToolbar.status = frameModel.sratusModel;
    _statusToolbar.frame = _frameModel.statusToolbarF;
}

//赞，评论
- (void)setUpBottomMessage
{
    /** 微博的工具条 */
    self.statusToolbar = [[IWStatusToolbar alloc] init];
    [self.contentView addSubview:_statusToolbar];
    self.statusToolbar = _statusToolbar;
}
@end
