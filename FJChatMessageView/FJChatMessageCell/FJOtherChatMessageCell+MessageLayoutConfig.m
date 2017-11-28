//
//  FJOtherChatMessageCell+MessageLayoutConfig.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//


#import "FJChatMessageModel.h"
#import "FJChatMessageLayout.h"
#import "FJChatMessageStateView.h"
#import "FJOtherChatMessageCell+MessageLayoutConfig.h"
#import "FJChatMessageContentView+MessageLayoutConfig.h"

@implementation FJOtherChatMessageCell (MessageLayoutConfig)

- (void)configWithMessageLayout:(FJChatMessageLayout *)messageLayout {
    self.messageLayout = messageLayout;
    if (messageLayout) {
        // 头像
        [self.avatarImgView setImageWithURL:[NSURL URLWithString:messageLayout.messageModel.avatarUrl] placeholder:[UIImage imageNamed:kChatMessageDefaultAvatar]];
        
        // 状态 view
        self.messageStateView.frame = messageLayout.messageStateViewFrame;
        
        // 昵称
        self.nickNameLbl.textLayout = messageLayout.nameTextLayout;
        self.nickNameLbl.top = messageLayout.nameTextTop;
        self.nickNameLbl.height = messageLayout.nameTextLayout.textBoundingSize.height;
        
        // 内容
        self.backgroundImgView.frame = messageLayout.contentTextViewFrame;
        self.messageContentView.frame = messageLayout.contentTextViewFrame;
        [self.messageContentView configMessageContentViewWithMessageLayout:messageLayout];
    }
}
@end
