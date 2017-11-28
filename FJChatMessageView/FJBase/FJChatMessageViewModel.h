//
//  FJChatMessageViewModel.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/10.
//  Copyright © 2017年 fjf. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FJChatMessageConfiguration.h"

@class FJChatMessageLayout;
@class FJChatMessageViewController;


typedef void(^FJChatMessageViewModelCompletionBlock) (BOOL isSuccess);

typedef void(^FJChatMessageViewModelScrollBlock) (UIScrollView * _Nullable scrollView);


@interface FJChatMessageViewModel : NSObject<UITableViewDataSource,UITableViewDelegate>

/**
 *  会话类型
 */
@property (nonatomic, assign, readonly) FJChatMessageSessionType chatSessionType;

/**
 *  scrollView 滚动 block
 */
@property (nonatomic, copy) FJChatMessageViewModelScrollBlock scrollBlock;

/**
 *  存储所有信息的数组
 */
@property (nonatomic, strong, readonly, nonnull) NSMutableArray <FJChatMessageLayout *>*tableCellLayouts;


/**
 *  @brief 需要实现此方法,进行服务器交互,将消息发送到服务器
 *
 *  @param aMessage 需要发送的消息
 */
- (void)sendMessage:(FJChatMessageModel *_Nullable)aMessage;

/**
 *  初始化方法
 *
 *  @param chatSessionType 会话类型
 *
 *  @return XMNChatViewModel 实例
 */
- (_Nullable instancetype)initWithChatSessionType:(FJChatMessageSessionType)chatSessionType;


/**
 加载 聊天 信息

 @param requestCount 请求 条数
 @param completion 回调
 */
- (void)loadChatMessageWithRequestCount:(NSInteger)requestCount completion:(FJChatMessageViewModelCompletionBlock _Nullable )completion;
@end
