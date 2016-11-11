//
//  ConstantData.h
//  QianZhenyn
//
//  Created by 卢达洋 on 16/5/16.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  弹出系统提醒对话框
 *
 *  @param title 对话框标题
 *  @param msg   对话框内容
 *
 *  @return 直接弹出
 */
#if __has_include(<UIKit/UIAlertController.h>)
#define MYALERTBYTITLE(title, msg,controller)                                                                                                                       \
{     \
UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle: UIAlertControllerStyleAlert];\
[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
}]];\
[controller presentViewController:alert animated:YES completion:nil];\
\
}
#define MYALERT(msg,controller)                                                                                                                       \
{     \
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle: UIAlertControllerStyleAlert];\
[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
}]];\
[controller presentViewController:alert animated:YES completion:nil];\
\
}
#else
//系统提醒对话框
#define MYALERTBYTITLE(title, msg)                                             \
{                                                                            \
if(msg.length == 0)\
{\
return;\
}\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title              \
message:msg                \
delegate:self               \
cancelButtonTitle:@"确认"          \
otherButtonTitles:nil, nil];         \
[alert setTag:110];                                                        \
[alert show];                                                              \
}

//系统提醒对话框
#define MYALERT(msg)                                                           \
{                                                                            \
if(msg.length == 0)\
{\
return;\
}\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"          \
message:msg                \
delegate:self               \
cancelButtonTitle:@"确认"          \
otherButtonTitles:nil, nil];         \
[alert setTag:110];                                                        \
[alert show];                                                              \
}

#endif

#pragma mark - APPKEY常量
//Bmob
extern NSString * const kAppIdForBmob;

//微信
extern NSString * const kWXAppKey;
extern NSString * const kWXSecret;
extern NSString * const kWXUrl;

//QQ
extern NSString * const kQQAppKey;
extern NSString * const kQQSecret;
extern NSString * const kQQUrl;

//新浪微博
extern NSString * const kSinaAppKey;
extern NSString * const kSinaSecret;
extern NSString * const kSinaUrl;

//友盟统计
extern NSString * const kUmengAppKey;

//友盟分享
extern NSString * const kUMSocialAppKey;

//极光推送
extern NSString * const kJPushAppKey;

//服务器地址
extern NSString * const kAPI_HOST;

//用户相关
extern NSString * const kUserType;
extern NSString * const kType_User;
extern NSString * const kType_Seller;
extern NSString * const kType_Helper;

//通知相关
extern NSString * const kUserType;
extern NSString * const kType_User;

//加解密
extern NSString * const kAESENCODEKEY;

#pragma mark - 颜色常量

typedef NS_ENUM(NSInteger, UserRole) {
  Role_User, // regular table view
  Role_Seller,
  Role_Helper
};

typedef NS_ENUM(NSInteger, GoodsListState) {
  GoodsListState_Normal,
  GoodsListState_Booking
};



@interface ConstantData : NSObject

+(NSString *)typeNameWithType:(NSString *)type;
+(NSString *)sexNameWithSex:(NSString *)sex;
+(NSString *)statusNameWithStatus:(NSString *)status;
+(NSString *)certificationStatusNameWithStatus:(NSString *)status;
@end
