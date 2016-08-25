//
//  PhotoView.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/16.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "PhotoView.h"
#import "IWPhoto.h"
@interface PhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@end
@implementation PhotoView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加一个GIF小图片
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
        self.gifView.hidden = YES;
    }
    return self;
}


- (void)setPhoto:(IWPhoto *)photo
{
    _photo = photo;
    NSLog(@"photoUrl = %@",photo.thumbnail_pic);
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.frame = CGRectMake(self.width - self.gifView.width, self.height - self.gifView.height, self.gifView.width, self.gifView.height);
}
@end
