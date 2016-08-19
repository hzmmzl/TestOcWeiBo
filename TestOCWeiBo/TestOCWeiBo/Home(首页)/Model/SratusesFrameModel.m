//
//  SratusesFrameModel.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/15.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "SratusesFrameModel.h"
#import "SratusesModel.h"
#import "UserModel.h"
#import "PhotosView.h"
@implementation SratusesFrameModel
- (void)setSratusModel:(SratusesModel *)sratusModel
{
    _sratusModel = sratusModel;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * IWStatusTableBorder;
    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    CGFloat topViewX = IWStatusTableBorder;
    CGFloat topViewY = 0;
    
    // 2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = IWStatusCellBorder;
    CGFloat iconViewY = IWStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + IWStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = sratusModel.user.name ? [sratusModel.user.name boundingRectWithSize:CGSizeMake(300, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size :  CGSizeZero;
    _nameLabelF = (CGRect){{nameLabelX,nameLabelY},nameLabelSize};
    
    // 4.会员图标
    if (sratusModel.user.mbtype) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + IWStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    // 5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF);
    CGSize timeLabelSize = [sratusModel.created_at boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSystemFontSize(11)} context:nil].size;
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + IWStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [sratusModel.source boundingRectWithSize:CGSizeMake(200, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSystemFontSize(11)} context:nil].size;
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.微博正文内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF)) + IWStatusCellBorder * 0.5;
    CGFloat contentLabelMaxW = topViewW - 2 * IWStatusCellBorder;
    CGSize contentLabelSize = [sratusModel.text boundingRectWithSize:CGSizeMake(contentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSystemFontSize(13)} context:nil].size;
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 8.配图
    if (sratusModel.pic_urls.count) {
#warning 根据图片个数计算整个相册的尺寸
        CGFloat photosViewX = contentLabelX;
        CGFloat photosViewY = CGRectGetMaxY(_contentLabelF) + IWStatusCellBorder;
//        CGSize photosViewSize = CGSizeMake(70, 70);
        CGSize photosViewSize = [PhotosView photosViewSizeWithPhotosCount:sratusModel.pic_urls.count];
        _photosViewF = (CGRect){{photosViewX,photosViewY},photosViewSize};
    }
    
    // 9.被转发微博
    if (sratusModel.retweeted_status) {
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + IWStatusCellBorder * 0.5;
        CGFloat retweetViewH = 0;
        
        // 10.被转发微博的昵称
        CGFloat retweetNameLabelX = IWStatusCellBorder;
        CGFloat retweetNameLabelY = IWStatusCellBorder;
        NSString *name = [NSString stringWithFormat:@"@%@", sratusModel.retweeted_status.user.name];
        CGSize retweetNameLabelSize = [name boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSystemFontSize(12)} context:nil].size;
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        // 11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + IWStatusCellBorder * 0.5;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * IWStatusCellBorder;
        CGSize retweetContentLabelSize = [sratusModel.retweeted_status.text boundingRectWithSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSystemFontSize(12)} context:nil].size;
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};
        
        // 12.被转发微博的配图
        if(sratusModel.retweeted_status.pic_urls.count) {
#warning 根据图片个数计算整个相册的尺寸
            CGSize retweetPhotosViewSize = [PhotosView photosViewSizeWithPhotosCount:sratusModel.retweeted_status.pic_urls.count];
            CGFloat retweetPhotosViewX = retweetContentLabelX;
            CGFloat retweetPhotosViewY = CGRectGetMaxY(_retweetContentLabelF) + IWStatusCellBorder;
            _retweetPhotosViewF = CGRectMake(retweetPhotosViewX, retweetPhotosViewY, retweetPhotosViewSize.width, retweetPhotosViewSize.height);
            
            retweetViewH = CGRectGetMaxY(_retweetPhotosViewF);
        } else { // 没有配图
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += IWStatusCellBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        // 有转发微博时topViewH
        topViewH = CGRectGetMaxY(_retweetViewF);
    } else { // 没有转发微博
        if (sratusModel.pic_urls.count) { // 有图
            topViewH = CGRectGetMaxY(_photosViewF);
        } else { // 无图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH += IWStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 13.工具条
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolbarH = 35;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + IWStatusTableBorder;
}
@end
