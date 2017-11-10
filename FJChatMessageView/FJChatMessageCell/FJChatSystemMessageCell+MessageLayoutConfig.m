//
//  FJChatSystemMessageCell+MessageLayoutConfig.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageModel.h"
#import "FJChatMessageLayout.h"
#import "FJChatSystemMessageCell+MessageLayoutConfig.h"

@implementation FJChatSystemMessageCell (MessageLayoutConfig)
- (void)configWithMessageLayout:(FJChatMessageLayout *)messageLayout {
    self.messageLayout = messageLayout;
    if (self.messageLayout) {
        // 内容 文本
        self.systemTextLbl.text = self.messageLayout.messageModel.content;
        self.systemTextLbl.frame = self.messageLayout.contentTextViewFrame;
    }
}
@end
