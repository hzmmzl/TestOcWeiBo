//
//  HomeStatusTableViewCell.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/12.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "HomeStatusTableViewCell.h"
#import "UIImage+Size.h"
@interface HomeStatusTableViewCell()

/** 顶部的view */
@property (nonatomic, weak) UIImageView *topView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) UIImageView *retweetView;
/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;

/** 微博的工具条 */
@property (nonatomic, weak) UIImageView *statusToolbar;
@end


@implementation HomeStatusTableViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUserMessage];
        [self setUpUserRetweetedStatus];
        [self setUpBottomMessage];
    }
    return self;
}

//个人
- (void)setUpUserMessage
{
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage resizedImageWithName:@"timeline_card_top_background" EdgeInsets:UIEdgeInsetsMake(0.5, 0.5, 0.5, 0.5)];
    topView.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted" EdgeInsets:UIEdgeInsetsMake(0.5, 0.5, 0.5, 0.5)];
    topView.contentMode = UIViewContentModeCenter;
    self.topView = topView;
    
    [self.contentView addSubview:self.topView];
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    [self.contentView addSubview:self.iconView];
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    [self.contentView addSubview:self.vipView];
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self.contentView addSubview:self.nameLabel];
    /** 配图 */
    UIImageView *photoView = [[UIImageView alloc] init];
    self.photoView = photoView;
    [self.contentView addSubview:self.photoView];
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    [self.contentView addSubview:self.timeLabel];
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    self.sourceLabel = sourceLabel;
    [self.contentView addSubview:self.sourceLabel];
    /** 正文\内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = kSystemFontSize(13);
    self.contentLabel = contentLabel;
    [self.contentView addSubview:self.contentLabel];
}
//转发内容
- (void)setUpUserRetweetedStatus
{
    /** 1.被转发微博的view(父控件) */
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage resizedImageWithName:@"timeline_retweet_background" EdgeInsets:UIEdgeInsetsMake(0.5, 0.9, 0.5, 0.1)];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    
    /** 2.被转发微博作者的昵称 */
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.font = kSystemFontSize(12);
    retweetNameLabel.textColor = kColorWithRBGA(67, 107, 163,1);
    retweetNameLabel.backgroundColor = [UIColor clearColor];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    /** 3.被转发微博的正文\内容 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = kSystemFontSize(12);
    retweetContentLabel.backgroundColor = [UIColor clearColor];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.textColor = kColorWithRBGA(90, 90, 90,1);
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 4.被转发微博的配图 */
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

//赞，评论
- (void)setUpBottomMessage
{
    
}
@end
