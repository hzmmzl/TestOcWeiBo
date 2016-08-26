//
//  UserAccountInfo.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/9.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "UserAccountInfo.h"
#define IWAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]
@implementation UserAccountInfo
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

/**
 *  从文件中解析对象的时候调
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.remind_in = [decoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [decoder decodeInt64ForKey:@"expires_in"];
        self.uid = [decoder decodeInt64ForKey:@"uid"];
        self.expiresTime = [decoder decodeObjectForKey:@"expiresTime"];
//        self.expiresTime = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [encoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [encoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [encoder encodeInt64:self.uid forKey:@"uid"];
//    [encoder encodeObject:self.name forKey:@"name"];
}


+(void)saveAccount:(UserAccountInfo *)account
{
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:IWAccountFile];
}

// 判断账号是否过期
+ (UserAccountInfo *)account
{
    UserAccountInfo *account = [NSKeyedUnarchiver unarchiveObjectWithFile:IWAccountFile];
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) {
        return account;
    }//过期
    return nil;
}
@end
