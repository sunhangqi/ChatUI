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
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

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
    //设置文本框左边的内容
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor redColor];
    leftView.frame = CGRectMake(0, 0, 10, 0);
    self.messageField.leftView = leftView;
    //需要设置显示，默认为never。
    self.messageField.leftViewMode = UITextFieldViewModeAlways;
    // Do any additional setup after loading the view.
    
    //发送通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)note {
    NSLog(@"HELLO - %@", note.userInfo);
    //数组对象转换成CGRect
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = rect.size.height;
    NSLog(@"%f",self.bottomSpace.constant);
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)note {
    NSLog(@"HELLO - %@", note.userInfo);
    //数组对象转换成CGRect
//    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = 0;
    NSLog(@"%f",self.bottomSpace.constant);
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self.messageField resignFirstResponder];
    //只要是控制器view里的控件，点一下就结束编辑模式，退出键盘
//    [self.messageField endEditing:YES];
    //推荐使用下面的方法退出键盘
    [self.view endEditing:YES];
}

@end
