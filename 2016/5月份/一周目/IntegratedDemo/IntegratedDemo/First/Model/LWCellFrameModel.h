//
//  LWCellFrameModel.h
//  IntegratedDemo
//
//  Created by Wiley on 16/5/5.
//  Copyright © 2016年 Wiley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define textPadding 15

@class LWSampleMessage;
@interface LWCellFrameModel : NSObject

@property (nonatomic, strong) LWSampleMessage *message;

@property (nonatomic, assign, readonly) CGRect timeFrame;
@property (nonatomic, assign, readonly) CGRect iconFrame;
@property (nonatomic, assign, readonly) CGRect textFrame;
@property (nonatomic, assign, readonly) CGFloat cellHeght;

@end
