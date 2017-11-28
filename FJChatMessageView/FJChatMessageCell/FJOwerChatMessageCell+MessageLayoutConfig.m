
//
//  FJOwerChatMessageCell+MessageLayoutConfig.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageModel.h"
#import "FJChatMessageLayout.h"
#import "FJChatMessageStateView.h"
#import "FJOwerChatMessageCell+MessageLayoutConfig.h"
#import "FJChatMessageContentView+MessageLayoutConfig.h"

@implementation FJOwerChatMessageCell (MessageLayoutConfig)
- (void)configWithMessageLayout:(FJChatMessageLayout *)messageLayout {
    self.messageLayout = messageLayout;
    if (messageLayout) {
        // 头像
        [self.avatarImgView setImageWithURL:[NSURL URLWithString:self.messageLayout.messageModel.avatarUrl] placeholder:[UIImage imageNamed:kChatMessageDefaultAvatar]];
        
        // 状态 view
        self.messageStateView.frame = messageLayout.messageStateViewFrame;
        
        // 内容 view
        self.backgroundImgView.frame = messageLayout.contentTextViewFrame;
        self.messageContentView.frame = messageLayout.contentTextViewFrame;
        [self.messageContentView configMessageContentViewWithMessageLayout:messageLayout];
        
    }
}
@end
