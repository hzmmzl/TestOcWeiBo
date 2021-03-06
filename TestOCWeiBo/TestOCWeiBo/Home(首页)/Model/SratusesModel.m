//
//  SratusesModel.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/12.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "SratusesModel.h"
#import "MJExtension.h"
#include "IWPhoto.h"
#import "NSDate+MJ.h"
@implementation SratusesModel

+(void)load
 {
     [SratusesModel mj_setupObjectClassInArray:^NSDictionary *{
         return @{
                  @"pic_urls" : @"IWPhoto",
                  };
     }];
 }

- (void)setSource:(NSString *)source
{
    if (source.length) {
        int loc = [source rangeOfString:@">"].location + 1;
        int length = [source rangeOfString:@"</"].location - loc;
        source = [source substringWithRange:NSMakeRange(loc, length)];
    }
    
    _source = [NSString stringWithFormat:@"来自%@", source];
}


- (NSString *)created_at
{
    // _created_at == Fri May 09 16:30:34 +0800 2014
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    // 2..判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%d小时前", createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%d分钟前", createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}
@end
