//
//  NSDate+DYExtension.h
//  DYVander
//
//  Created by 卢达洋 on 16/3/17.
//  Copyright © 2016年 ludayang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DYExtension)
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;
/**
 *  获取当前日期
 *
 *  @param dateFormat 日期格式
 *
 *  @return 格式化时间
 */
+(NSString *)getCurrentDate:(NSString *)dateFormat;


-(NSString *)getDateStringWithDateFormat:(NSString *)dateFormat;
@end
