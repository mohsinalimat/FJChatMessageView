//
//  FJChatMessageContentView+MessageLayoutConfig.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/27.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageModel.h"
#import "FJChatMessageLayout.h"
#import "FJChatMessageTextLabel.h"
#import "FJChatMessageContentView+MessageLayoutConfig.h"

@implementation FJChatMessageContentView (MessageLayoutConfig)
- (void)configMessageContentViewWithMessageLayout:(FJChatMessageLayout *)messageLayout {
    if (messageLayout) {
        // 内容 文本
        self.textLabel.textLayout = messageLayout.contentTextLayout;
        self.chatMessageType = messageLayout.messageModel.messageType;
        
    }
}
@end
