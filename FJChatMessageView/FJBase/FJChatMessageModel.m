//
//  FJChatMessageModel.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageModel.h"

@implementation FJChatMessageModel
#pragma mark --- init method
- (instancetype)initWithContent:(id)aContent
                          state:(FJChatMessageState)aState
                          owner:(FJChatMessageOwner)aOwner {
    
    return [self initWithContent:aContent
                           state:aState
                           owner:aOwner
                            time:[[NSDate date] timeIntervalSince1970]];
}

- (instancetype)initWithContent:(id)aContent
                          state:(FJChatMessageState)aState
                          owner:(FJChatMessageOwner)aOwner
                           time:(NSTimeInterval)aTime {
    if (self = [super init]) {
        
        _content = aContent;
        _state = aState;
        _owner = aOwner;
        _time = aTime;
         _nickname = @"池善概";
        _messageType = FJChatMessageTypeText;
        _avatarUrl =  @"http://image.dnews.blessi.cn/o_1btebleip1qt61bg81htur8213pmu.jpg?imageView2/2/w/800";
    }
    return self;
}


@end
