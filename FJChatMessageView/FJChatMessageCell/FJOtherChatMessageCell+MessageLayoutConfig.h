//
//  FJOtherChatMessageCell+MessageLayoutConfig.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJOtherChatMessageCell.h"

@interface FJOtherChatMessageCell (MessageLayoutConfig)
// 依据 messageLayout 配置
- (void)configWithMessageLayout:(FJChatMessageLayout *)messageLayout;
@end
