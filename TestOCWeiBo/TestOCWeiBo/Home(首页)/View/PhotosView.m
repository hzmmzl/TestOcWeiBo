//
//  PhotosView.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/16.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "PhotosView.h"
#import "PhotoView.h"
#define IWPhotoW 70
#define IWPhotoH 70
#define IWPhotoMargin 10
@interface PhotosView()
@property (nonatomic , assign) int maxColumns;
#define photoSingleW
@end
@implementation PhotosView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (NSInteger i=0; i<9; i++) {
            PhotoView *photoView = [[PhotoView alloc] init];
            photoView.tag = i;
            photoView.userInteractionEnabled = YES;
            [photoView addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
            photoView.hidden = YES;
        }
    }
    return self;
}
- (void)setPhonts:(NSArray *)phonts
{
    _phonts = phonts;
    NSInteger count = MIN(phonts.count, self.subviews.count);
    for (NSInteger i=0; i<count; i++) {
        PhotoView *photoView = self.subviews[i];
        photoView.photo = phonts[i];
        CGFloat photoX = IWPhotoMargin;
        CGFloat photoY = IWPhotoMargin;
        CGFloat photoW = 0;
        CGFloat photoH = IWPhotoH;
        if (count == 1) {
            photoW = IWPhotoW;
            photoView.contentMode = UIViewContentModeScaleAspectFit;
            photoView.clipsToBounds = NO;
        }else if(count > 1 && count < 5)
        {
            self.maxColumns = 2;
            int col = i % self.maxColumns; //0,1
            int row = i / self.maxColumns; //0,0,1,1,2
            photoView.contentMode = UIViewContentModeScaleAspectFill;
            photoView.clipsToBounds = YES;
            photoW = (self.width - (self.maxColumns + 1)*IWPhotoMargin) / self.maxColumns;
            photoX = col * (photoW + IWPhotoMargin);
            photoY = row * (IWPhotoH + IWPhotoMargin);
        }else if (count > 4)
        {
            self.maxColumns = 3;
            int col = i % self.maxColumns; //0,1
            int row = i / self.maxColumns; //0,0,1,1,2
            photoView.contentMode = UIViewContentModeScaleAspectFill;
            photoView.clipsToBounds = YES;
            photoW = (self.width - (self.maxColumns + 1)*IWPhotoMargin) / self.maxColumns;
            photoX = col * (photoW + IWPhotoMargin);
            photoY = row * (IWPhotoH + IWPhotoMargin);
            photoView.clipsToBounds = YES;
        }
        photoView.frame = CGRectMake(photoX, photoY, photoW, photoH);
        photoView.hidden = NO;
    }
}

- (void)photoTap:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%ld",gestureRecognizer.view.tag);
}

+ (CGSize)photosViewSizeWithPhotosCount:(NSInteger)count
{
    if(count <= 3){
        return CGSizeMake(IWPhotoW*count, IWPhotoH);
    }else if (count >= 4 && count <= 6){
        return CGSizeMake(IWPhotoW*2, IWPhotoH*2);
    }else if (count >= 7 && count <= 9){
        return CGSizeMake(IWPhotoW*3, IWPhotoH*3);
    }
    return CGSizeZero;
}

@end
