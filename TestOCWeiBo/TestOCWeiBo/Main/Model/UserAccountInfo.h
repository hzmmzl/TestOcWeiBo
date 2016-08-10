//
//  UserAccountInfo.h
//  TestOCWeiBo
//
//  Created by winbei on 16/8/9.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAccountInfo : NSObject<NSCoding>
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, strong) NSDate *expiresTime; // 账号的过期时间
// 如果服务器返回的数字很大, 建议用long long(比如主键, ID)
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(UserAccountInfo *)account;

/**
 *  返回存储的账号信息
 */
+ (UserAccountInfo *)account;
@end
