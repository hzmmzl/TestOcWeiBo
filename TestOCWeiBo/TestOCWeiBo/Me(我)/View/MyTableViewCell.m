//
//  MyTableViewCell.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/25.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "MyTableViewCell.h"
#import "MyModel.h"
@interface MyTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;

@end
@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(MyTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"MyTableViewCellId";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setMyModel:(MyModel *)myModel
{
    _myModel = myModel;
    if (myModel.isShow == YES) {
        _stateImageView.hidden = NO;
    }else{
        _stateImageView.hidden = YES;
    }
}

@end
