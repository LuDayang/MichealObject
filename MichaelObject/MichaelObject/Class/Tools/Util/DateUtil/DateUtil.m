//
//  DateUtil.m
//  iOSLibraryDemo
//
//  Created by chengjian on 16/2/3.
//  Copyright © 2016年 LuDayang. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil
+ (NSString *)dateStringWithTimeInterval:(NSNumber *)timeInterval
{
  NSTimeInterval time = [timeInterval doubleValue];
  NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:time];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];//GMT+8 = 中国时区
  [dateFormatter setDateFormat:@"yyyy/MM/dd - HH:mm"];
  return [dateFormatter stringFromDate:detailDate];
}

+ (long)TimeIntervalWithDateString:(NSString *)dateString
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy/MM/dd - HH:mm"];
  NSDate *date = [dateFormatter dateFromString:dateString];
  return [date timeIntervalSince1970];
}

+ (long)getTimeInterval
{
  NSInteger interval = [[NSTimeZone timeZoneWithName:@"GMT+8"] secondsFromGMTForDate:[NSDate date]];
  NSDate *locaDate = [[NSDate date] dateByAddingTimeInterval:interval];
  long longTime = [locaDate timeIntervalSince1970];
  return longTime;
}

+ (NSString *)getCurrentTimeInfromYMD {
  NSDate *senddate = [NSDate date];
  
  NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
  [dateformatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
  [dateformatter setDateFormat:@"YYYY/MM/dd - HH:mm"];
  
  NSString *locationString = [dateformatter stringFromDate:senddate];
  return locationString;
}


@end
