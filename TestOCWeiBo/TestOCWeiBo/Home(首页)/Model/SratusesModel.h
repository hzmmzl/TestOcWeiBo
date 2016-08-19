//
//  SratusesModel.h
//  TestOCWeiBo
//
//  Created by winbei on 16/8/12.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@interface SratusesModel : NSObject
/**
 *  微博的内容(文字)
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博的单张配图
 */
//@property (nonatomic, copy) NSString *thumbnail_pic;

/**
 *  微博配图
 */
@property (nonatomic, copy) NSArray *pic_urls;

/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的表态数(被赞数)
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  微博的作者
 */
@property (nonatomic, strong) UserModel *user;
/**
 *  被转发的微博
 */
@property (nonatomic, strong) SratusesModel *retweeted_status;
@end




