//
//  FJChatMessageLayout.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "YYKit.h"
#import <Foundation/Foundation.h>

@class FJChatMessageModel;

@interface FJChatMessageLayout : NSObject
// 初始化
- (instancetype)initWithMessageModel:(FJChatMessageModel *)messageModel;
// 计算布局
- (void)layoutMessageControl;

// 以下是数据
@property (nonatomic, strong) FJChatMessageModel *messageModel;

//以下是布局结果

// 昵称
@property (nonatomic, assign) CGFloat nameTextTop;
// 名字
@property (nonatomic, strong) YYTextLayout *nameTextLayout;



// 文本 frame
@property (nonatomic, assign) CGRect contentTextLblFrame;
// 文本 view frame
@property (nonatomic, assign) CGRect contentTextViewFrame;
//文本 layout
@property (nonatomic, strong) YYTextLayout *contentTextLayout;
//下边 留白
@property (nonatomic, assign) CGFloat marginBottom;
//总高度
@property (nonatomic, assign) CGFloat cellHeight;
@end
