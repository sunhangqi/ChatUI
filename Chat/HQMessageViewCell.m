//
//  HQMessageViewCell.m
//  Chat
//
//  Created by Macbook on 2017/5/1.
//  Copyright © 2017年 Macbook. All rights reserved.
//

#import "HQMessageViewCell.h"
#import "HQMessage.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface HQMessageViewCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *contentButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *otherIconView;
@property (weak, nonatomic) IBOutlet UIButton *otherContentButton;

@end

@implementation HQMessageViewCell

- (void)setMessage:(HQMessage *)message {
    _message = message;
    
    if (message.isHideTime) {
        self.timeLabel.hidden = message.hideTime;
        self.timeLabel.text = message.time;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);//设置timeLabel的高度为0；
        }];
    }else{
        //self.timeLabel.text = message.time;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(21);
        }];
    }
    if (message.type == HQMessageTypeMe) {
        [self settingShowTextButton:self.contentButton showIconView:self.iconView hideTextButton:self.otherContentButton hideIconView:self.otherIconView];
//        self.otherContentButton.hidden = YES;
//        self.otherIconView.hidden = YES;
//        self.contentButton.hidden = NO;
//        self.iconView.hidden = NO;
//        
//        //设置按钮的文字（self.contentButton.titleLabel就有文字)
//        [self.contentButton setTitle:message.text forState:UIControlStateNormal];
//        
//        //强制更新,将button类型设置成custom.
//        [self.contentButton layoutIfNeeded];
//        
//        //设置按钮的高度就是titleLabel的高度
//        [self.contentButton updateConstraints:^(MASConstraintMaker *make) {
//            CGFloat buttonH = self.contentButton.titleLabel.frame.size.height;
//            make.height.equalTo(buttonH);
//        }];
//        
//        [self.contentButton layoutIfNeeded];
//        
//        //设置cell的高度
//        CGFloat buttonMaxY = CGRectGetMaxY(self.contentButton.frame);
//        CGFloat iconMaxY = CGRectGetMaxY(self.iconView.frame);
//        message.cellHeight = MAX(buttonMaxY, iconMaxY) + 10;

    }else{
        [self settingShowTextButton:self.otherContentButton showIconView:self.otherIconView hideTextButton:self.contentButton hideIconView:self.iconView];
//        self.otherContentButton.hidden = NO;
//        self.otherIconView.hidden = NO;
//        self.contentButton.hidden = YES;
//        self.iconView.hidden = YES;
//        
//        //设置按钮的文字（self.contentButton.titleLabel就有文字)
//        [self.otherContentButton setTitle:message.text forState:UIControlStateNormal];
//        
//        //强制更新,将button类型设置成custom.
//        [self.otherContentButton layoutIfNeeded];
//        
//        //设置按钮的高度就是titleLabel的高度
//        [self.otherContentButton updateConstraints:^(MASConstraintMaker *make) {
//            CGFloat buttonH = self.otherContentButton.titleLabel.frame.size.height;
//            make.height.equalTo(buttonH);
//        }];
//        
//        [self.otherContentButton layoutIfNeeded];
//        
//        //设置cell的高度
//        CGFloat buttonMaxY = CGRectGetMaxY(self.otherContentButton.frame);
//        CGFloat iconMaxY = CGRectGetMaxY(self.otherIconView.frame);
//        message.cellHeight = MAX(buttonMaxY, iconMaxY) + 10;

    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentButton.titleLabel.numberOfLines = 0;
    self.otherContentButton.titleLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)settingShowTextButton:(UIButton *)showTextButton showIconView:(UIImageView *)showIconView hideTextButton:(UIButton *)hideTextButton hideIconView:(UIImageView *)hideIconView
{
    hideTextButton.hidden = YES;
    hideIconView.hidden = YES;
    showTextButton.hidden = NO;
    showIconView.hidden = NO;
    
    //设置按钮的文字（self.contentButton.titleLabel就有文字)
    [showTextButton setTitle:self.message.text forState:UIControlStateNormal];
    
    //强制更新,将button类型设置成custom.
    [showTextButton layoutIfNeeded];
    
    //设置按钮的高度就是titleLabel的高度
    [showTextButton updateConstraints:^(MASConstraintMaker *make) {
        CGFloat buttonH = showTextButton.titleLabel.frame.size.height + 30;
        make.height.equalTo(buttonH);
    }];
    
    [showTextButton layoutIfNeeded];
    
    //设置cell的高度
    CGFloat buttonMaxY = CGRectGetMaxY(showTextButton.frame);
    CGFloat iconMaxY = CGRectGetMaxY(showIconView.frame);
    self.message.cellHeight = MAX(buttonMaxY, iconMaxY) + 10;
    
    [showTextButton layoutIfNeeded];
    

}

@end
