//
//  Global.m
//  iOSProduct
//
//  Created by 卢达洋 on 16/4/8.
//  Copyright © 2016年 oftenfull_iOSTeam. All rights reserved.
//

#import "Global.h"
#import <Toast/UIView+Toast.h>
#import <objc/runtime.h>
#import "AppConfig.h"
static NSMutableArray *userInfoArr;
@implementation Global
+ (Global *)sharedSingleton {
    static dispatch_once_t once;
    static Global *_singleton = nil;
    dispatch_once(&once, ^{
        _singleton = [[super allocWithZone:NULL] init];
    });
    return _singleton;
}

#pragma mark - UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden:(UITableView *)tableView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

#pragma mark - Implement NSCopying
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - NSUserDefaults操作

- (void)setUserDefaultsWithKey:(NSString *)key andValue:(id)value {
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getUserDefaultsWithKey:(NSString *)key {
    NSString *value =
    (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:key];
    return value;
}

- (void)delUserDefaultsWithKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)makeToastWithTitle:(NSString *)title{
    UIViewController *RootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = RootVC;
    while (currentVC.presentedViewController) {
        currentVC = currentVC.presentedViewController;
    }
    [currentVC.view makeToast:title duration:5 position:CSToastPositionCenter];
}

+(UIViewController *)CurrentVc{
  UIViewController *RootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
  UIViewController *currentVC = RootVC;
  while (currentVC.presentedViewController) {
    currentVC = currentVC.presentedViewController;
  }
  return currentVC;
}

#pragma mark- 用户信息缓存
- (void)writeUserInfoInPlist{
    
  
}
-(void)readUserInfoFromPlist{
    

}

-(void)deletUserInfoFromPlist{
    
    for (int i = 0; i<userInfoArr.count; i++) {
        [self delUserDefaultsWithKey:[userInfoArr objectAtIndex:i]];
    }
}

+ (NSURL *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImageJPEGRepresentation(tempImage,0.5);
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* totalPath = [documentPath stringByAppendingPathComponent:imageName];
    NSURL *url = [NSURL URLWithString:totalPath];
    url = [NSURL fileURLWithPath:totalPath];
    //保存到 document
    [imageData writeToFile:totalPath atomically:NO];
    return url;
    
}


#pragma mark 图片压缩
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
