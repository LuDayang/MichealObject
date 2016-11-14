//
//  TextFieldUtil.h
//  InputCheak
//
//  Created by 卢达洋 on 16/4/19.
//  Copyright © 2016年 oftenfull_iOSTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TextFieldUtil : NSObject

/**
 *  限制输入长度，当输入长度大于限制长度时截取最大限制长度的前半段
 *
 *  @param length    最大长度
 *  @param textField 输入框
 *  @param range     当前字符位置
 *  @param string    将要添加的字符
 *
 *  @return 是否添加将要添加的字符
 */

+(BOOL)limitTextEntryWith:(NSInteger )length textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;


+(BOOL)limitTextEntryWith:(NSInteger )length textView:(UITextView *)textView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;


/**
 *  判断字符串是否是合法数字电话号码
 *
 *  @param string 待检测字符串
 *
 *  @return 是否为合法手机号码
 */
+(BOOL)isValidatePhoneNum:(NSString *)string;


/**
 *  判断字符串是否是邮箱
 *
 *  @param string 待检测字符串
 *
 *  @return 是否是邮箱
 */
+ (BOOL)isStringAEmailAddress:(NSString *)string;

@end
