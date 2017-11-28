//
//  FJChatEmojiView.h
//  funcode
//
//  Created by BuJi on 14/12/27.
//  Copyright (c) 2014年 Echo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FJChatEmojiBtnClickedBlock)(UIButton *btn, NSInteger btnTag);

@class PageControl;

@interface FJChatEmojiView : UIView
// 发送 按键
@property (nonatomic, strong) UIButton *sendBtn;
// 分割线
@property (nonatomic, strong) UIView *separatorLineView;
// 页码
@property (nonatomic, strong) PageControl *pageControl;
// 滚动栏
@property (nonatomic, strong) UIScrollView *emotionView;
// 删除
@property (nonatomic, copy) FJChatEmojiBtnClickedBlock deleteBtnBlock;
// 表情
@property (nonatomic, copy) FJChatEmojiBtnClickedBlock emojiBtnBlock;
// 发送
@property (nonatomic, copy) FJChatEmojiBtnClickedBlock sendBtnBlock;
// 是否 显示 表情 界面
@property (nonatomic, assign, getter=isShowChatEmojiView) BOOL showChatEmojiView;
// 获取 高度
+ (CGFloat)getChatEmojiViewHeight;
@end
