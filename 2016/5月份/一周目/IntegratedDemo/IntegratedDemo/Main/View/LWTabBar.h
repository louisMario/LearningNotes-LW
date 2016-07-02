//
//  LWTabBar.h
//  IntegratedDemo
//
//  Created by Wiley on 16/5/3.
//  Copyright © 2016年 Wiley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LWTabBar;
@protocol LWTabBarDelegate <NSObject>

@optional
- (void)tabBar:(LWTabBar *)tabBar didClickButton:(NSInteger)index;

@end
@interface LWTabBar : UIView
@property(nonatomic,strong)NSArray * items;
@property(nonatomic,weak)id<LWTabBarDelegate>delegate;
+(instancetype)shareOneTab;
@end
