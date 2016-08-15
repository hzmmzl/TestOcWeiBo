//
//  UIImage+Size.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/8.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (Size)
+ (UIImage *)resizedImageWithName:(NSString *)name EdgeInsets:(UIEdgeInsets)edgeInsets
{
    UIImage *image = [UIImage imageNamed:name];
    [image stretchableImageWithLeftCapWidth:image.size.width * edgeInsets.left topCapHeight:image.size.height * edgeInsets.top];
    return image;
}
@end
