//
//  HomeStatusTableViewCell.h
//  TestOCWeiBo
//
//  Created by winbei on 16/8/12.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SratusesModel.h"
#import "SratusesFrameModel.h"
@interface HomeStatusTableViewCell : UITableViewCell
@property (nonatomic , strong) SratusesFrameModel *frameModel;
+(HomeStatusTableViewCell *)cellWithTableView:(UITableView *)tableView;
@end
