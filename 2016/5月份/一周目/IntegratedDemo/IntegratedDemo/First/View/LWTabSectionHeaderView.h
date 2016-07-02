//
//  LWTabSectionHeaderView.h
//  IntegratedDemo
//
//  Created by Wiley on 16/5/4.
//  Copyright © 2016年 Wiley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LWFriendGroup;

@protocol LWTabSectionHeaderViewDelegate <NSObject>

@optional
-(void)clickHeadView;

@end


@interface LWTabSectionHeaderView : UITableViewHeaderFooterView
@property(nonatomic,strong)LWFriendGroup * FriendGroup;
@property(nonatomic,weak)id<LWTabSectionHeaderViewDelegate>delegate;
+(instancetype)headViewWithTableView:(UITableView*)tableview;
@end
