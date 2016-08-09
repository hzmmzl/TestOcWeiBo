//
//  TitleView.h
//  TestOCWeiBo
//
//  Created by winbei on 16/8/8.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleView : UIButton
@property (weak, nonatomic) IBOutlet UILabel *titleViewTitle;
@property (weak, nonatomic) IBOutlet UIImageView *titleViewImage;

+ (TitleView *)titleView;
- (void)titleViewWithNormalImage:(NSString *)normalImg HighImage:(NSString *)highImg Title:(NSString *)title;
@end
