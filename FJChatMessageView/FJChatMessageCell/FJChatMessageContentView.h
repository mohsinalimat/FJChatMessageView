//
//  FJChatMessageContentView.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/24.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJChatMessageConfiguration.h"

@class FJChatMessageTextLabel;

@interface FJChatMessageContentView : UIView

// 文本 view
@property (nonatomic, strong) FJChatMessageTextLabel *textLabel;

// 状态
@property (nonatomic, assign) FJChatMessageType chatMessageType;
@end
