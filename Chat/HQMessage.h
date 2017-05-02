//
//  HQMessage.h
//  Chat
//
//  Created by Macbook on 2017/5/2.
//  Copyright © 2017年 Macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    HQMessageTypeMe = 0,
    HQMessageTypeOther = 1
} HQMessageType;

@interface HQMessage : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *time;

/**
 * cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 * 是否隐藏时间
 */
@property (nonatomic, assign, getter=isHideTime) BOOL hideTime;


@property (nonatomic, assign) HQMessageType type;
+ (instancetype)messageWithDict:(NSDictionary *)dict;

@end
