//
//  MacroDefinition.h
//  MichaelObject
//
//  Created by 卢达洋 on 2016/11/14.
//  Copyright © 2016年 卢达洋. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h


/**
 *  输入RGB值获取颜色
 *
 *  @param r RED值
 *  @param g GREEN值
 *  @param b BLUE值
 *  @param a 透明度
 *
 *  @return UIColor
 */
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a)]

/**
 *  输入16进制值获取颜色
 *
 *  @param rgbValue 16进制值
 *
 *  @return UIColor
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* MacroDefinition_h */
