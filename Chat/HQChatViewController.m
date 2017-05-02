//
//  HQChatViewController.m
//  Chat
//
//  Created by Macbook on 2017/5/1.
//  Copyright © 2017年 Macbook. All rights reserved.
//

#import "HQChatViewController.h"
#import "HQMessage.h"
#import "HQMessageViewCell.h"

@interface HQChatViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *messages;

@end

@implementation HQChatViewController

- (NSArray *)messages {
    if (_messages == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *messageArrary = [NSMutableArray array];
        //用于记录上一条消息
        HQMessage *lastMessage = nil;
        for (NSDictionary *dict in dictArray) {
            HQMessage *message = [HQMessage messageWithDict:dict];
            message.hideTime = [message.time isEqualToString:lastMessage.time];
            [messageArrary addObject:message];
            
            //赋值当前消息模型
            lastMessage = message;
        }
        _messages = messageArrary;
    }
    return _messages;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HQMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message"];
    cell.message = self.messages[indexPath.row];
    return cell;
}

#pragma mark -<UITabelViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HQMessage *message = self.messages[indexPath.row];
    return message.cellHeight;
}


@end
