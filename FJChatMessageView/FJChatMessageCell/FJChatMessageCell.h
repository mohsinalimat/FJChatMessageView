//
//  FJChatMessageCell.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/24.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJChatMessageLayout;
@class FJChatMessageStateView;
@class FJChatMessageContentView;

@interface FJChatMessageCell : UITableViewCell
// 头像
@property (nonatomic, strong) UIImageView *avatarImgView;
// 背景图
@property (nonatomic, strong) UIImageView *backgroundImgView;
// 消息 状态 view
@property (nonatomic, strong) FJChatMessageStateView *messageStateView;
// 内容 view
@property (nonatomic, strong) FJChatMessageContentView *messageContentView;
// 模型 布局
@property (nonatomic, strong) FJChatMessageLayout *messageLayout;
@end
