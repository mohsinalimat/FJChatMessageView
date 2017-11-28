//
//  FJChatMessageServer.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/10.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJChatMessageConfiguration.h"

typedef void(^FJChatMessageRequestCompletionBlock) (NSArray *resDataArray, BOOL isSuccess);

@interface FJChatMessageServer : NSObject
// 加载 聊天 数据
+ (void)loadChatMessageWithChatSessionType:(FJChatMessageSessionType)chatSessionType requestCount:(NSInteger)requestCount
                                completion:(FJChatMessageRequestCompletionBlock)completion;
@end
