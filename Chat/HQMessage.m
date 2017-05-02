//
//  HQMessage.m
//  Chat
//
//  Created by Macbook on 2017/5/2.
//  Copyright © 2017年 Macbook. All rights reserved.
//

#import "HQMessage.h"

@implementation HQMessage

+ (instancetype)messageWithDict:(NSDictionary *)dict {
    HQMessage *message = [[HQMessage alloc] init];
    [message setValuesForKeysWithDictionary:dict];
    return message;
}
@end
