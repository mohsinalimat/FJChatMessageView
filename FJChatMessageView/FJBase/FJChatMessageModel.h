//
//  FJChatMessageModel.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageViewHeader.h"
#import <Foundation/Foundation.h>

@interface FJChatMessageModel : NSObject
/** 消息的状态 */
@property (nonatomic, assign) FJChatMessageState state;

/** 消息的附加状态 */
@property (nonatomic, assign) FJChatMessageSubState substate;

/** 消息的类型 只读 */
@property (nonatomic, assign) FJChatMessageType messageType;

/** 消息发送者 */
@property (nonatomic, assign) FJChatMessageOwner owner;

/** 消息发送的时间 时间戳格式 */
@property (nonatomic, assign) NSTimeInterval time;

/** 消息的内容 */
@property (nonatomic, strong) NSString *content;

/** 消息拥有者昵称 */
@property (nonatomic, copy)   NSString *nickname;
/** 消息拥有者的头像地址 */
@property (nonatomic, copy)   NSString *avatarUrl;
/** 消息拥有者的id */
@property (nonatomic, copy)   NSString *userId;
/** 消息 会话 */
@property (nonatomic, copy)   NSString *session_id;
/** 消息会话的样式 只读 */
@property (nonatomic, assign) FJChatMessageSessionType chatMessageSessionType;
@end
