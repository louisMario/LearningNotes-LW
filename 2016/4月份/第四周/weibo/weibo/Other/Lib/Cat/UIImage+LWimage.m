//
//  UIImage+LWimage.m
//  weibo
//
//  Created by Wiley on 16/4/25.
//  Copyright © 2016年 Wiley. All rights reserved.
//

#import "UIImage+LWimage.h"

@implementation UIImage (LWimage)
+ (instancetype)imageWithOriginalName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}
@end
