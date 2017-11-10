//
//  FJChatToolView.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/8.
//  Copyright © 2017年 fjf. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FJChatMessageViewHeader.h"

// 高度
UIKIT_EXTERN const CGFloat kChatToolViewHeight;

@class FJChatToolView;

@protocol FJChatToolViewDelegate <NSObject>
@optional
// 切换
- (void)chatToolView:(FJChatToolView *)chatToolView showType:(FJChatToolBarShowingView)showType;
// 发送 内容
- (void)chatToolView:(FJChatToolView *)chatToolView sendText:(NSString *)sendText;
// 当前 位置
- (void)chatToolView:(FJChatToolView *)chatToolView textLocation:(NSInteger)textLocation;
@end


@class YYTextView;
@interface FJChatToolView : UIView
// 分割线
@property (nonatomic, strong) UIView *lineView;
// 背景 view
@property (nonatomic, strong) UIView *textBgView;
// 内容 view
@property (nonatomic, strong) YYTextView *textView;
// 表情/键盘 切换键
@property (nonatomic, strong) UIButton *switchBtn;
// 是否 发送
@property (nonatomic, getter=isSendText, assign) BOOL sendText;
// 字数 限制
@property (nonatomic, assign) NSInteger chatMessageMaxValue;
// 委托
@property (nonatomic, weak) id<FJChatToolViewDelegate> delegate;

// 清空 数据
- (void)clearTextView;
@end
