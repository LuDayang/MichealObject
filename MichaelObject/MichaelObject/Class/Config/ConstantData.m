//
//  ConstantData.m
//  QianZhenyn
//
//  Created by 卢达洋 on 16/5/16.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#import "AppConfig.h"
#import "ConstantData.h"
#import <Foundation/Foundation.h>

// Bmob
NSString *const kAppIdForBmob = @"be4e0859eec4eea20e8baa465d674f10";

//微信
NSString *const kWXAppKey = @"wx7e98aae914f43084";
NSString *const kWXSecret = @"7c7a5771847fba3d283251f64a54e36b";
NSString *const kWXUrl = @"http://www.umeng.com/social";

// QQ
NSString *const kQQAppKey = @"1105798422";
NSString *const kQQSecret = @"RJZR3XWnIwpYXKdG";
NSString *const kQQUrl = @"http://www.umeng.com/social";

//新浪微博
NSString *const kSinaAppKey = @"860078523";
NSString *const kSinaSecret = @"f1464f9c709ff1dc56df2891ac92f4f6";
NSString *const kSinaUrl = @"http://sns.whalecloud.com/sina2/callback";

//友盟统计
NSString *const kUmengAppKey = @"5811997204e205496b002533";

//友盟分享
NSString *const kUMSocialAppKey = @"5811997204e205496b002533";

//极光推送
NSString *const kJPushAppKey = @"5a419f3c3ee0805fe87d0802";

//服务器地址
#if OPEN_TEST_DOMAIN
/*********测试环境*********/
#if OPEN_DEV_DOMAIN
NSString *const kAPI_HOST = @"http://guojian.vsource.com.cn";
#else
NSString *const kAPI_HOST = @"http://guojian2.vsource.com.cn";
#endif


#else
/*********正式环境*********/
NSString *const kAPI_HOST = @"http://www.workingdom.com";
#endif

//加解密
NSString *const kAESENCODEKEY = @"gjasdfas";

@implementation ConstantData
+(NSString *)typeNameWithType:(NSString *)type{
    
    NSDictionary *userTypeDic = @{@"0":@"艺术机构",
                               @"1":@"艺术家",
                               @"2":@"藏家"
                               };
    return type?[userTypeDic objectForKey:type]:@"未选择";
}

+(NSString *)sexNameWithSex:(NSString *)sex{
    NSDictionary *sexDic = @{@"0":@"女",
                          @"1":@"男",
                          @"2":@"其他"
                          };
    return sex?[sexDic objectForKey:sex]:@"未选择";
}
+(NSString *)statusNameWithStatus:(NSString *)status{
    NSDictionary *statusDic = @{
                                @"-2":@"未完善",
                                @"-1":@"认证失败",
                             @"0":@"未认证",
                             @"1":@"认证中",
                             @"2":@"已认证"};
    return status?[statusDic objectForKey:status]:@"未认证";
}

+(NSString *)certificationStatusNameWithStatus:(NSString *)status{
    NSDictionary *statusDic = @{
                                @"-2":@"未认证",
                                @"-1":@"认证失败",
                                @"0":@"未认证",
                                @"1":@"认证中",
                                @"2":@"已认证"};
    return status?[statusDic objectForKey:status]:@"未认证";
}
@end
