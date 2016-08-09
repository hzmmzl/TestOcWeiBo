//
//  TitleView.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/8.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "TitleView.h"
#import "UIImage+Size.h"
@implementation TitleView

+ (TitleView *)titleView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"TitleView" owner:self options:nil] lastObject];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}


- (void)setTitleViewTitle:(UILabel *)titleViewTitle
{
    _titleViewTitle = titleViewTitle;
    _titleViewImage.contentMode = UIViewContentModeCenter;
    [_titleViewImage sizeToFit];
   
    
}


- (void)setTitleViewImage:(UIImageView *)titleViewImage
{
    _titleViewImage = titleViewImage;
    titleViewImage.contentMode = UIViewContentModeCenter;
    
}


- (void)titleViewWithNormalImage:(NSString *)normalImg HighImage:(NSString *)highImg Title:(NSString *)title
{
    _titleViewImage.contentMode = UIViewContentModeCenter;
    UIImage *image = [UIImage imageNamed:normalImg];
    [_titleViewImage sizeToFit];
   CGSize size = [self.titleViewTitle.text boundingRectWithSize:CGSizeMake(300, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    self.frame = CGRectMake(0, 0, size.width + image.size.width + 20, image.size.height);
    [self layoutIfNeeded];
}
@end
