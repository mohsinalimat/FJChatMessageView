//
//  FJChatMessageModel.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageConfiguration.h"
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

/**
 *  实例化FJChatMessageModel实例
 *
 *  使用此方法初始化 会将time属性 -> 自动设置为当前时间的时间戳
 *  @param aContent 消息内容
 *  @param aState   消息状态
 *  @param aOwner   消息发送者
 *
 *  @return 实例
 */
- (instancetype)initWithContent:(id)aContent
                          state:(FJChatMessageState)aState
                          owner:(FJChatMessageOwner)aOwner;

/**
 *  实例化FJChatMessageModel实例
 *
 *  @param aContent 消息内容
 *  @param aState   消息状态
 *  @param aOwner   消息发送者
 *  @param aTime    消息时间
 *
 *  @return 实例
 */
- (instancetype)initWithContent:(id)aContent
                          state:(FJChatMessageState)aState
                          owner:(FJChatMessageOwner)aOwner
                           time:(NSTimeInterval)aTime;
@end
