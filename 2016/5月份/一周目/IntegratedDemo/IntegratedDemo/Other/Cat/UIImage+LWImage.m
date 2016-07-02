//
//  UIImage+LWImage.m
//  IntegratedDemo
//
//  Created by Wiley on 16/5/3.
//  Copyright © 2016年 Wiley. All rights reserved.

#import "UIImage+LWImage.h"

@implementation UIImage (LWImage)
+(instancetype)imageWithOriginalName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
