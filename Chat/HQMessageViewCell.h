//
//  HQMessageViewCell.h
//  Chat
//
//  Created by Macbook on 2017/5/1.
//  Copyright © 2017年 Macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HQMessage;
@interface HQMessageViewCell : UITableViewCell

@property (nonatomic, strong) HQMessage *message;

@end
