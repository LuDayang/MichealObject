//
//  ImgUtil.h
//  iOSLibraryDemo
//
//  Created by Lu on 15/2/16.
//  Copyright © 2016年 LuDayang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImgUtil : NSObject
/**
 *  优化版加载图片
 *
 *  @param imageView 图片视图
 *  @param url       图片地址链接
 *
 *  @return 优化后的图片视图
 */
+ (UIImageView *)getImageForView:(UIImageView *)imageView andImageURL:(NSString*)url;

/**
 *  获取图片的主色调
 *
 *  @param image 图片
 *
 *  @return 主色调颜色
 */
+ (UIColor *)mostColor:(UIImage *)image;

@end
