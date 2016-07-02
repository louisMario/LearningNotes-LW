//
//  LWFirends.h
//  IntegratedDemo
//
//  Created by Wiley on 16/5/4.
//  Copyright © 2016年 Wiley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWFirends : NSObject
@property(nonatomic,copy)NSString * icon;
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * intro;
@property(nonatomic,assign,getter=isVip)BOOL vip;


+ (instancetype)friendWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
