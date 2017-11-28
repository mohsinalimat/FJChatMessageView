//
//  FJChatMessageConfiguration.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/10.
//  Copyright © 2017年 fjf. All rights reserved.
//

#ifndef FJChatMessageConfiguration_h
#define FJChatMessageConfiguration_h

#import <UIKit/UIKit.h>
#import "FJChatMessageViewHeader.h"


#define FJ_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define FJ_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// iPhone X 宏定义
#define  iPhoneX (FJ_SCREEN_WIDTH == 375.f && FJ_SCREEN_HEIGHT == 812.f ? YES : NO)

// 适配iPhone X 状态栏高度
#define  FJ_STATUS_BAR_HEIGHT      (iPhoneX ? 44.f : 20.f)

// 适配iPhone X 状态栏高度
#define  FJ_NAVIGATION_BAR_HEIGHT  (iPhoneX ? 88.f : 64.f)

// iPhoneX 状态栏 高度差
#define FJ_TABBAR_SAFE_BOTTOM_MARGIN  (iPhoneX ? 34.f : 0.f)



/** XMNChatBar显示的view类型 */
typedef NS_ENUM(NSUInteger, FJChatToolBarShowingView) {
    /** 默认不显示任何view */
    FJChatToolBarShowingNoneView = 0,
    
    /** 显示了表情选择视图 */
    FJChatToolBarShowingFaceView,
    /** 显示了键盘 */
    FJChatToolBarShowingKeyboard,
};



/**
 *  聊天消息的类型
 */
typedef NS_ENUM(NSUInteger, FJChatMessageSessionType){
    FJChatMessageSessionTypeSingle = 0 /**< 单人聊天,不显示nickname */,
    FJChatMessageSessionTypeGroup /**< 群组聊天,显示nickname */,
};


/**
 *  消息拥有者类型
 */
typedef NS_ENUM(NSUInteger, FJChatMessageOwner){
    FJChatMessageOwnerUnknown = 0 /**< 未知的消息拥有者 */,
    FJChatMessageOwnerSystem /**< 系统消息 */,
    FJChatMessageOwnerSelf /**< 自己发送的消息 */,
    FJChatMessageOwnerOther /**< 接收到的他人消息 */,
};

/**
 *  消息类型
 */
typedef NS_ENUM(NSUInteger, FJChatMessageType){
    FJChatMessageTypeUnknow = 0 /**< 未知的消息类型 */,
    FJChatMessageTypeSystem /**< 系统消息 */,
    FJChatMessageTypeText /**< 文本消息 */,
    FJChatMessageTypeImage /**< 图片消息 */,
    FJChatMessageTypeVoice /**< 语音消息 */,
    FJChatMessageTypeLocation /**< 地理位置消息 */,
    FJChatMessageTypeFile /**< 文件消息 */,
};



typedef NS_ENUM(NSUInteger, FJChatMessageState) {
    /** 未知的消息装填 */
    FJChatMessageStateUnknown = 0,
    /** 正在发送消息中 */
    FJChatMessageStateSending = 10,
    /** 正在接受消息中 */
    FJChatMessageStateRecieving,
    /** 消息成功 */
    FJChatMessageStateSuccess = 20,
    /** 消息失败 */
    FJChatMessageStateFailed,
};


typedef NS_ENUM(NSUInteger, FJChatMessageSubState) {
    
    FJChatMessageSubStateSendingContent = 30,
    /** 发送消息内容失败 */
    FJChatMessageSubStateSendContentFaield,
    /** 发送消息内容成功 */
    FJChatMessageSubStateSendContentSuccess,
    /** 接收的消息的内容还没有下载*/
    FJChatMessageSubStateUnRecievedContent = 40,
    /** 正在接收消息的内容 */
    FJChatMessageSubStateRecievingContent,
    /** 接收消息内容失败 */
    FJChatMessageSubStateRecieveContentFailed,
    /** 已成功接收消息的内容 */
    FJChatMessageSubStateRecieveContentSuccess,
    /** 正在播放接收的消息内容 */
    FJChatMessageSubStatePlayingContent,
    /** 无法播放消息的具体内容 */
    FJChatMessageSubStatePlayContentFailed,
    /** 可以播放消息的具体内容 */
    FJChatMessageSubStatePlayContentSuccess,
    /** 消息已读 */
    FJChatMessageSubStateReadedContent
};




/** 位置 **/

// 依据 屏幕 宽度 获取 宽高
#define kFJGetWidthByScreenWidth(x) (kFJScreenWidth * (x)/375.0)

// 屏幕  宽度
#define kFJScreenWidth [[UIScreen mainScreen] bounds].size.width
// cell 内边距
#define kChatMessageCellPadding 15
// cell 系统 消息 文本 扩大 宽度
#define kChatMessageCellSystemMessageTextExtendWidth 20
// cell 系统 消息 文本 扩大 高度
#define kChatMessageCellSystemMessageTextExtendHeight 6
// cell 聊天 消息 竖直 间距
#define kChatMessageCellContentTextVerticalPadding 8
// cell 聊天 消息 水平 间距
#define kChatMessageCellContentTextHorizontalPadding 14
// cell 头像 size
#define kChatMessageCellAvatarSize kFJGetWidthByScreenWidth(44)
// cell 昵称 高度
#define kChatMessageCellNameLblHeight kFJGetWidthByScreenWidth(15)
// cell 昵称 与 头像 间距
#define kChatMessageCellNameLblToAvatar 12
// cell 文本 与 昵称 距离
#define kChatMessageCellContentLblToNameLbl 8
// cell content X值
#define kChatMessageCellContentX (kChatMessageCellAvatarSize + kChatMessageCellNameLblToAvatar + kChatMessageCellPadding)
// cell content 宽度
#define kChatMessageCellContentWidth (kFJScreenWidth - (2 *kChatMessageCellContentX))
// cell contentLabel 宽度
#define kChatMessageCellContentLblWidth (kChatMessageCellContentWidth - 2 * kChatMessageCellContentTextHorizontalPadding)
// cell content X值
#define kChatMessageCellOwerAvatarX (kFJScreenWidth  - kChatMessageCellAvatarSize - kChatMessageCellPadding)
// 聊天 cell 底部 间距
#define kChatMessageCellBottomMargin 25
// 系统 消息 底部 间距
#define kChatMessageSystemCellBottomMargin 20
// 聊天 文本 行间距
#define kChatMessageCellContentLblLineSpacing 2.0f
// 聊天 状态 View size
#define kChatMessageCellStateViewSize 16
// 聊天 状态 View size
#define kChatMessageCellStateViewToContentView 8

// 默认 头像
#define kChatMessageDefaultAvatar @"chat_icon_default_avatar.png"


// 字体

/** 字体 **/

// font
#define kFJSystemFontSize(a) [UIFont fontWithCustomType:a]

// 系统 提醒 字体
#define kChatMessageCellSystemTextLblFontSize kFJSystemFontSize(AppFontTypeI)

// 昵称 字体
#define kChatMessageCellNicknameLblFontSize kFJSystemFontSize(AppFontTypeG)

// 正文 字体
#define kChatMessageCellContextLblFontSize kFJSystemFontSize(AppFontTypeE)


// font
#define kFJSystemColorType(a) [UIColor colorWithCustomType:a]
// 系统 消息 文本 字体 颜色
#define kChatMessageCellSystemLblTextNormalColor kFJSystemColorType(AppColorTypeFontE)
// 系统 消息 文本 背景 颜色
#define kChatMessageCellSystemLblTextBackground kFJSystemColorType(AppColorTypeC)
// 昵称 文本 字体 颜色
#define kChatMessageCellNicknameLblTextNormalColor kFJSystemColorType(AppColorTypeFontD)
// 内容 文本 字体 颜色
#define kChatMessageCellOwerContentTextNormalColor kFJSystemColorType(AppColorTypeFontA)
// 内容 文本 字体 颜色
#define kChatMessageCellOtherContentTextNormalColor kFJSystemColorType(AppColorTypeFontC)
#endif /* FJChatMessageConfiguration_h */
