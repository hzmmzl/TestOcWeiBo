//
//  StatusTopView.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/15.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "StatusTopView.h"
#import "UIImage+Size.h"
#import "SratusesModel.h"
#import "UserModel.h"
#import "SratusesFrameModel.h"
#import "PhotosView.h"
@interface StatusTopView()
/** 顶部的view */
@property (nonatomic, weak) UIImageView *topView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) PhotosView *photosView;
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
@property (nonatomic, weak) PhotosView *retweetPhotosView;
@end

@implementation StatusTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpUserMessage];
        [self setUpUserRetweetedStatus];
    }
    return self;
}

- (void)setFrameModel:(SratusesFrameModel *)frameModel
{
    _frameModel = frameModel;
    // 1.取出模型数据
    SratusesModel *status = frameModel.sratusModel;
    UserModel *user = status.user;
    _topView.frame = self.frameModel.topViewF;
    // 2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = self.frameModel.iconViewF;
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.frameModel.nameLabelF;
    // 4.vip
    if (user.mbtype) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.vipView.frame = self.frameModel.vipViewF;
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        
        self.vipView.hidden = YES;
    }
    
    // 5.时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = self.frameModel.timeLabelF;
    // 6.来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = self.frameModel.sourceLabelF;
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.frameModel.contentLabelF;
    // 8.配图
    if (status.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = self.frameModel.photosViewF;
//        self.photoView.photos = status.pic_urls;
        [self addSubview:_photosView];
    } else {
        self.photosView.hidden = YES;
    }

    // 9.被转发微博
    SratusesModel *retweetStatus = status.retweeted_status;
    if (retweetStatus) {
        UserModel *user = retweetStatus.user;

        self.retweetView.hidden = NO;
        self.retweetView.frame = self.frameModel.retweetViewF;
        self.retweetNameLabel.frame = self.frameModel.retweetNameLabelF;
        self.retweetNameLabel.text = user.name;
        self.retweetContentLabel.frame = self.frameModel.retweetContentLabelF;
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetPhotosView.frame = self.frameModel.retweetPhotosViewF;
        
    } else {
        self.retweetView.hidden = YES;
    }
}


//个人
- (void)setUpUserMessage
{
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage imageNamed:@"timeline_card_top_background"];
    topView.highlightedImage = [UIImage imageNamed:@"timeline_card_top_background_highlighted"];
//    topView.contentMode = UIViewContentModeCenter;
    self.topView = topView;
    [self addSubview:self.topView];
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    [self addSubview:self.iconView];
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    [self addSubview:self.vipView];
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    self.nameLabel.font = kSystemFontSize(13);
    [self addSubview:self.nameLabel];
    /** 配图 */
    PhotosView *photoView = [[PhotosView alloc] init];
    self.photosView = photoView;
    [self addSubview:self.photosView];
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    self.timeLabel.font = kSystemFontSize(12);
    [self addSubview:self.timeLabel];
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    self.sourceLabel = sourceLabel;
    self.sourceLabel.font = kSystemFontSize(12);
    [self addSubview:self.sourceLabel];
    /** 正文\内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = kSystemFontSize(13);
    self.contentLabel = contentLabel;
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];

}

//转发内容
- (void)setUpUserRetweetedStatus
{
    /** 1.被转发微博的view(父控件) */
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
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
    PhotosView *retweetPhotosView = [[PhotosView alloc] init];
    [self.retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
}

@end
