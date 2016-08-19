//
//  PhotosView.h
//  TestOCWeiBo
//
//  Created by winbei on 16/8/16.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosView : UIView
@property (nonatomic , strong) NSArray *phonts;

/**
 *  根据图片的个数返回相册的最终尺寸
 */
+ (CGSize)photosViewSizeWithPhotosCount:(NSInteger)count;
@end
