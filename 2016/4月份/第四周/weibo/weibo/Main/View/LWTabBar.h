//
//  LWTabBar.h
//  weibo
//
//  Created by Wiley on 16/4/25.
//  Copyright © 2016年 Wiley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LWTabBar;

@protocol LWTabBarDelegate<NSObject>

@optional
- (void)tabBar:(LWTabBar *)tabBar didClickButton:(NSInteger)index;

@end


@interface LWTabBar : UIView

@property(nonatomic,strong)NSArray * items;
@property(nonatomic,weak)id<LWTabBarDelegate>delegate;
@end
