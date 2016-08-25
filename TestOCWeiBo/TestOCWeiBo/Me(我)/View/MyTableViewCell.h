//
//  MyTableViewCell.h
//  TestOCWeiBo
//
//  Created by winbei on 16/8/25.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyModel;
@interface MyTableViewCell : UITableViewCell
@property (nonatomic , strong) MyModel *myModel;
+(MyTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
