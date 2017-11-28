//
//  FJChatMessageContentView+MessageLayoutConfig.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/27.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageContentView.h"

@class FJChatMessageLayout;

@interface FJChatMessageContentView (MessageLayoutConfig)
// 配置 内容 view
- (void)configMessageContentViewWithMessageLayout:(FJChatMessageLayout *)messageLayout;
@end
