//
//  NSDate+DYExtension.m
//  DYVander
//
//  Created by 卢达洋 on 16/3/17.
//  Copyright © 2016年 ludayang. All rights reserved.
//

#import "NSDate+DYExtension.h"

@implementation NSDate (DYExtension)
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  // 获得某个时间的年月日时分秒
  NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
  NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
  return dateCmps.year == nowCmps.year;
}

/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday
{
  NSDate *now = [NSDate date];
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"yyyy-MM-dd";
  NSString *dateStr = [fmt stringFromDate:self];
  NSString *nowStr = [fmt stringFromDate:now];
  
  NSDate *date = [fmt dateFromString:dateStr];
  now = [fmt dateFromString:nowStr];
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
  NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
  NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
  
  return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday
{
  NSDate *now = [NSDate date];
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"yyyy-MM-dd";
  
  NSString *dateStr = [fmt stringFromDate:self];
  NSString *nowStr = [fmt stringFromDate:now];
  
  return [dateStr isEqualToString:nowStr];
}

/**
 *  获取当前格式化日期
 *
 *  @param dateFormat 日期格式
 *
 *  @return 格式化时间字符串
 */
+(NSString *)getCurrentDate:(NSString *)dateFormat
{
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//  [fmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
  fmt.dateFormat = dateFormat;
  
  return [fmt stringFromDate:[NSDate date]];
}

-(NSString *)getDateStringWithDateFormat:(NSString *)dateFormat{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
      [fmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
    fmt.dateFormat = dateFormat;
    return [fmt stringFromDate:self];
}
@end
