//
//  AppConfig.h
//  ofshop
//
//  Created by 卢达洋 on 16/3/18.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h


//特别注意：
//打包正式环境时：OPEN_TEST_DOMAIN＝0，OPEN_ENCRYPTION＝1
//打包测试环境时：OPEN_TEST_DOMAIN＝1，OPEN_ENCRYPTION＝0

//设置切换正式环境(0)、测试环境(1)
#define OPEN_TEST_DOMAIN 1

//设置切换测试环境模式      开发环境(1)  测试环境(0)
#define OPEN_DEV_DOMAIN 0


//是否开启加解密 1为开启 0为关闭
#define OPEN_ENCRYPTION 0

//是否显示接口日志
#define SHOW_INTFACE_LOGO 1

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

//设置超时时间
#define REQUEST_TIMEOUT 30

//缓存
#define UD_KEY_ACCOUNTDATA            @"AccountData"       //用户信息
#define UD_KEY_FIRINSTALL             @"FirstInstall"      //第一次安装


#endif /* AppConfig_h */
