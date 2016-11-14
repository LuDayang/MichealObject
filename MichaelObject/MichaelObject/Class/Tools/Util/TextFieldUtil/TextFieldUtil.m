//
//  TextFieldUtil.m
//  InputCheak
//
//  Created by 卢达洋 on 16/4/19.
//  Copyright © 2016年 oftenfull_iOSTeam. All rights reserved.
//

#import "TextFieldUtil.h"

@implementation TextFieldUtil

+(BOOL)limitTextEntryWith:(NSInteger )length textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  if ([string isEqualToString:@"\n"]) {
    return YES;
  }
  //得到输入框的原有内容+新增
  NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    if ([toBeString length] > length) {
      textField.text = [toBeString substringToIndex:length];
      return NO;
    }
  return YES;
}

+(BOOL)limitTextEntryWith:(NSInteger )length textView:(UITextView *)textView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        return YES;
    }
    //得到输入框的原有内容+新增
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([toBeString length] > length) {
        textView.text = [toBeString substringToIndex:length];
        return NO;
    }
    return YES;
}

+(BOOL)isValidatePhoneNum:(NSString *)string
{
  NSString *phoneRegex = @"^1+[34578]+\\d{9}";//@"[0-9-+ ]{7,15}";
  NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
  return [phoneTest evaluateWithObject:string];
}


+ (BOOL)isStringAEmailAddress:(NSString *)string {
  NSString *strTestPhone = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}";
  NSPredicate *reTestPhone = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",strTestPhone];
  return [reTestPhone evaluateWithObject:string];
}

@end
