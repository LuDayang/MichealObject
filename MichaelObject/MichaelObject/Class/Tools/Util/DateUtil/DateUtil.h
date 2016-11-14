//
//  DateUtil.h
//  iOSLibraryDemo
//
//  Created by chengjian on 16/2/3.
//  Copyright © 2016年 LuDayang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtil : NSObject
+ (NSString *)dateStringWithTimeInterval:(NSNumber *)timeInterval;//时间戳转换为时间字符串
+ (long)getTimeInterval;//获取时间戳
+ (long)TimeIntervalWithDateString:(NSString *)dateString; //时间字符串转换为时间戳
+ (NSString *)getCurrentTimeInfromYMD; //获取当前时间 格式 年月日 没有-
@end
