//
//  ImgUtil.m
//  iOSLibraryDemo
//
//  Created by Lu on 15/2/16.
//  Copyright © 2016年 LuDayang. All rights reserved.
//

#import "ImgUtil.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

static void RGBtoHSV( float r, float g, float b, float *h, float *s, float *v )
{
  float min, max, delta;
  min = MIN( r, MIN( g, b ));
  max = MAX( r, MAX( g, b ));
  *v = max;               // v
  delta = max - min;
  if( max != 0 )
    *s = delta / max;       // s
  else {
    // r = g = b = 0        // s = 0, v is undefined
    *s = 0;
    *h = -1;
    return;
  }
  if( r == max )
    *h = ( g - b ) / delta;     // between yellow & magenta
  else if( g == max )
    *h = 2 + ( b - r ) / delta; // between cyan & yellow
  else
    *h = 4 + ( r - g ) / delta; // between magenta & cyan
  *h *= 60;               // degrees
  if( *h < 0 )
    *h += 360;
}

@implementation ImgUtil
+ (UIImageView *)getImageForView:(UIImageView*)imageView andImageURL:(NSString*)url{
  UIImageView* setImageView = imageView;
  setImageView.backgroundColor = [UIColor whiteColor];
  if (setImageView)
  {
    __block UIActivityIndicatorView *activityIndicator;
    [setImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
    setImageView.backgroundColor = [UIColor whiteColor];
    
    // 使用mas_makeConstraints添加约束
    [activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(imageView.mas_centerX).with.offset(0);
      make.center.equalTo(imageView.mas_centerY).with.offset(0);
    }];
    [activityIndicator startAnimating];
    [setImageView sd_setImageWithURL:[NSURL  URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      [activityIndicator stopAnimating];
      [activityIndicator setHidesWhenStopped:YES];
      [activityIndicator setHidden:YES];
      setImageView.image = image;
    }];
  }
  return setImageView;
}

+(UIColor *)mostColor:(UIImage*)image{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
  int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
  int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
  //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
  CGSize thumbSize=CGSizeMake(40, 40);
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = CGBitmapContextCreate(NULL,
                                               thumbSize.width,
                                               thumbSize.height,
                                               8,//bits per component
                                               thumbSize.width*4,
                                               colorSpace,
                                               bitmapInfo);
  CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
  CGContextDrawImage(context, drawRect, image.CGImage);
  CGColorSpaceRelease(colorSpace);
  //第二步 取每个点的像素值
  unsigned char* data = CGBitmapContextGetData (context);
  if (data == NULL) return nil;
  NSArray *MaxColor=nil;
  // NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
  float maxScore=0;
  for (int x=0; x<thumbSize.width*thumbSize.height; x++) {
    int offset = 4*x;
    int red = data[offset];
    int green = data[offset+1];
    int blue = data[offset+2];
    int alpha =  data[offset+3];
    if (alpha<25)continue;
    float h,s,v;
    RGBtoHSV(red, green, blue, &h, &s, &v);
    float y = MIN(abs(red*2104+green*4130+blue*802+4096+131072)>>13, 235);
    y= (y-16)/(235-16);
    if (y>0.9) continue;
    float score = (s+0.1)*x;
    if (score>maxScore) {
      maxScore = score;
    }
    MaxColor=@[@(red),@(green),@(blue),@(alpha)];
    //[cls addObject:clr];
  }
  CGContextRelease(context);
  return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}


@end
