//
//  PhotosView.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/16.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "PhotosView.h"
#import "PhotoView.h"
#import "MJPhotoBrowser.h"
#import "IWPhoto.h"
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
//            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
//            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
        }
    }
    return self;
}
- (void)setPhonts:(NSArray *)phonts
{
    _phonts = phonts;
    CGFloat widthSC = [UIScreen mainScreen].bounds.size.width - 3*IWPhotoMargin;
    NSLog(@"photoCount = %ld",phonts.count);
    NSInteger count = MIN(phonts.count, self.subviews.count);
    for (int i = 0; i<self.subviews.count; i++) {
        // 取出i位置对应的imageView
        PhotoView *photoView = self.subviews[i];
        
        // 判断这个imageView是否需要显示数据
        if (i < phonts.count) {
            // 显示图片
            photoView.hidden = NO;
            
            // 传递模型数据
            photoView.photo = phonts[i];
            
            // 设置子控件的frame
            int maxColumns = (phonts.count == 4) ? 2 : 3;
            //            if (phonts.count == 1) {
            //                maxColumns = 1;
            //            }
            int col = i % maxColumns;
            int row = i / maxColumns;
            CGFloat photoX = col * (IWPhotoW + IWPhotoMargin);
            CGFloat photoY = row * (IWPhotoH + IWPhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, IWPhotoW, IWPhotoH);
            if (phonts.count == 1) {
                photoView.frame = CGRectMake(photoX, photoY, IWPhotoW, IWPhotoH);
            }
            
            // Aspect : 按照图片的原来宽高比进行缩
            // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
            // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
            // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
            
            if (phonts.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        } else { // 隐藏imageView
            photoView.hidden = YES;
        }
    }

}
/*
 
 for (int i = 0; i<self.subviews.count; i++) {
 // 取出i位置对应的imageView
 PhotoView *photoView = self.subviews[i];
 
 // 判断这个imageView是否需要显示数据
 if (i < phonts.count) {
 // 显示图片
 photoView.hidden = NO;
 
 // 传递模型数据
 photoView.photo = phonts[i];
 
 // 设置子控件的frame
 int maxColumns = (phonts.count == 4) ? 2 : 3;
 //            if (phonts.count == 1) {
 //                maxColumns = 1;
 //            }
 int col = i % maxColumns;
 int row = i / maxColumns;
 CGFloat photoX = col * (IWPhotoW + IWPhotoMargin);
 CGFloat photoY = row * (IWPhotoH + IWPhotoMargin);
 photoView.frame = CGRectMake(photoX, photoY, IWPhotoW, IWPhotoH);
 if (phonts.count == 1) {
 photoView.frame = CGRectMake(photoX, photoY, IWPhotoW, IWPhotoH);
 }
 
 // Aspect : 按照图片的原来宽高比进行缩
 // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
 // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
 // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
 
 if (phonts.count == 1) {
 photoView.contentMode = UIViewContentModeScaleAspectFit;
 photoView.clipsToBounds = NO;
 } else {
 photoView.contentMode = UIViewContentModeScaleAspectFill;
 photoView.clipsToBounds = YES;
 }
 } else { // 隐藏imageView
 photoView.hidden = YES;
 }
 }
 
 
 
 for (NSInteger i=0; i<self.subviews.count; i++) {
 PhotoView *photoView = self.subviews[i];
 if (i<phonts.count) {
 
 photoView.photo = phonts[i];
 CGFloat photoX = IWPhotoMargin;
 CGFloat photoY = IWPhotoMargin;
 CGFloat photoW = IWPhotoW;
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
 photoW = (widthSC - (self.maxColumns + 1)*IWPhotoMargin) / self.maxColumns;
 photoX = col * (photoW + IWPhotoMargin);
 photoY = row * (IWPhotoH + IWPhotoMargin);
 }else if (count > 4)
 {
 self.maxColumns = 3;
 int col = i % self.maxColumns; //0,1
 int row = i / self.maxColumns; //0,0,1,1,2
 photoView.contentMode = UIViewContentModeScaleAspectFill;
 photoView.clipsToBounds = YES;
 photoW = (widthSC - (self.maxColumns + 1)*IWPhotoMargin) / self.maxColumns;
 photoX = col * (photoW + IWPhotoMargin);
 photoY = row * (IWPhotoH + IWPhotoMargin);
 photoView.clipsToBounds = YES;
 }
 photoView.frame = CGRectMake(photoX, photoY, photoW, photoH);
 NSLog(@"frame = %@",NSStringFromCGRect(photoView.frame));
 photoView.hidden = NO;
 }else{
 photoView.hidden = YES;
 }
 }

 */

- (void)photoTap:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%ld",gestureRecognizer.view.tag);
    int count = self.phonts.count;
    
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        mjphoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        
        IWPhoto *iwphoto = self.phonts[i];
        NSString *photoUrl = [iwphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = gestureRecognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];

}

+ (CGSize)photosViewSizeWithPhotosCount:(NSInteger)count
{
//    if(count <= 3){
//        return CGSizeMake(IWPhotoW*count, IWPhotoH);
//    }else if (count >= 4 && count <= 6){
//        return CGSizeMake(IWPhotoW*2, IWPhotoH*2);
//    }else if (count >= 7 && count <= 9){
//        return CGSizeMake(IWPhotoW*3+IWPhotoMargin, IWPhotoH*3+IWPhotoMargin);
//    }
//    return CGSizeZero;
    
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * IWPhotoH + (rows - 1) * IWPhotoMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * IWPhotoW + (cols - 1) * IWPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
    /**
     一共60条数据 == count
     一页10条 == size
     总页数 == pages
     pages = (count + size - 1)/size;
     */

}

@end
