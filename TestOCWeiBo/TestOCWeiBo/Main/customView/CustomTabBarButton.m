//
//  CustomTabBarButton.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/3.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "CustomTabBarButton.h"

@implementation CustomTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = kSystemSize(11);
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, self.width, self.height*0.6);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.height*0.6, self.width, self.height*0.4);
}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    [self setTitle:item.title forState:UIControlStateNormal];
}
@end
