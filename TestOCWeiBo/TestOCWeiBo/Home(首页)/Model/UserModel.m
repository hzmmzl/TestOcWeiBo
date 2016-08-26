//
//  UserModel.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/15.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
+(UserModel *)userInfoWithDic:(NSDictionary *)dic
{
    id model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
