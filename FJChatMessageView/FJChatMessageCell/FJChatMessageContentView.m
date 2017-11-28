//
//  FJChatMessageContentView.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/24.
//  Copyright © 2017年 fjf. All rights reserved.
//

// tool
#import "FJChatMessageConfiguration.h"
// view

#import "FJChatMessageTextLabel.h"
#import "FJChatMessageContentView.h"

@implementation FJChatMessageContentView

#pragma mark --------------- Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupChatMessageContentViewControls];
    }
    return self;
}

#pragma mark --------------- Public Methods

- (void)setChatMessageType:(FJChatMessageType)chatMessageType {
    _chatMessageType = chatMessageType;
//    [self hiddenAllSubControls];
//    if (_chatMessageType == FJChatMessageTypeText) {
//        self.textLabel.hidden = NO;
//    }
}


#pragma mark --------------- Override Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat contentTextLblX = kChatMessageCellContentTextHorizontalPadding;
    CGFloat contentTextLblY = kChatMessageCellContentTextVerticalPadding;
    CGFloat contentTextLblWidth = self.width - 2 * kChatMessageCellContentTextHorizontalPadding;
    CGFloat contentTextLblHeight = self.height - 2 * kChatMessageCellContentTextVerticalPadding;
    
    self.textLabel.frame = CGRectMake(contentTextLblX,  contentTextLblY, contentTextLblWidth, contentTextLblHeight);
    
}

#pragma mark --------------- Private Methods

- (void)setupChatMessageContentViewControls {
    [self addSubview:self.textLabel];
}

// 隐藏 所有 子控件
- (void)hiddenAllSubControls {
    self.textLabel.hidden = YES;
}

#pragma mark --------------- Getter / Setter
// 文本 view
- (FJChatMessageTextLabel *)textLabel {
    if(!_textLabel){
        _textLabel = [[FJChatMessageTextLabel alloc] init];
        _textLabel.width = kChatMessageCellContentWidth;
        _textLabel.left = kChatMessageCellContentX;
        _textLabel.displaysAsynchronously = YES;
        _textLabel.ignoreCommonProperties = YES;
        _textLabel.fadeOnAsynchronouslyDisplay = NO;
        _textLabel.fadeOnHighlight = NO;
        _textLabel.lineBreakMode = NSLineBreakByClipping;
        _textLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    return  _textLabel;
}

@end
