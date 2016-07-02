//
//  LWFriendGroup.h
//  IntegratedDemo
//
//  Created by Wiley on 16/5/4.
//  Copyright © 2016年 Wiley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFriendGroup : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,assign)NSInteger online;
@property(nonatomic,strong)NSArray * friends;
@property(nonatomic,assign,getter=isOpen)BOOL  opened;

+ (instancetype)friendGroupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
