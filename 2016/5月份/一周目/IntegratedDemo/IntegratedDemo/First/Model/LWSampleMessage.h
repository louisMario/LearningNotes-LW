//
//  LWSampleMessage.h
//  IntegratedDemo
//
//  Created by Wiley on 16/5/5.
//  Copyright © 2016年 Wiley. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    kMessageModelTypeOther,
    kMessageModelTypeMe
} MessageModelType;

@interface LWSampleMessage : NSObject

@property(nonatomic,strong)NSString * text;
@property(nonatomic,strong)NSString * time;
@property(nonatomic,assign) MessageModelType type;
@property(nonatomic,assign)BOOL showTime;

+(instancetype)messageModelWithDict:(NSDictionary *)dict;
-(instancetype)initWithModelWithDict:(NSDictionary *)dict;
@end
