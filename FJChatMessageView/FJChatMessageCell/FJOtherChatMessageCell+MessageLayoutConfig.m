//
//  FJOtherChatMessageCell+MessageLayoutConfig.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//
#import "FJChatMessageModel.h"
#import "FJChatMessageLayout.h"
#import "FJOtherChatMessageCell+MessageLayoutConfig.h"

@implementation FJOtherChatMessageCell (MessageLayoutConfig)

- (void)configWithMessageLayout:(FJChatMessageLayout *)messageLayout {
    self.messageLayout = messageLayout;
    if (self.messageLayout) {
        // 头像
        [self.avatarImgView setImageWithURL:[NSURL URLWithString:self.messageLayout.messageModel.avatarUrl] placeholder:[UIImage imageNamed:kChatMessageDefaultAvatar]];
        // 昵称
        self.nickNameLbl.textLayout = self.messageLayout.nameTextLayout;
        self.nickNameLbl.top = self.messageLayout.nameTextTop;
        self.nickNameLbl.height = self.messageLayout.nameTextLayout.textBoundingSize.height;
        
        // 文本
        self.contentLbl.textLayout = self.messageLayout.contentTextLayout;
        self.backgroundImgView.frame = self.messageLayout.contentTextViewFrame;
        self.contentLbl.frame = self.messageLayout.contentTextLblFrame;
    }
}
@end
