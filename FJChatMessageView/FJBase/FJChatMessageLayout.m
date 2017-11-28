//
//  FJChatMessageLayout.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJEmojiHelper.h"
#import "NSString+Extention.h"
#import "FJChatMessageModel.h"
#import "FJChatMessageLayout.h"

@implementation FJChatMessageLayout

#pragma mark --- init method

// 初始化
- (instancetype)initWithMessageModel:(FJChatMessageModel *)messageModel {
     if (!messageModel) return nil;
    if (self = [super init]) {
        _messageModel = messageModel;
        [self layoutMessageControl];
    }
    return self;
}

#pragma mark --- public method
// 布局
- (void)layoutMessageControl {

    // 计算高度
    _cellHeight = 0;
    
    // 文本排版，计算布局
    [self layoutMessageCell];
    
    _cellHeight += CGRectGetMinY(self.contentTextViewFrame);
    _cellHeight += CGRectGetHeight(self.contentTextViewFrame);
    if (_cellHeight < kChatMessageCellAvatarSize && _messageModel.owner != FJChatMessageOwnerSystem) {
        _cellHeight = kChatMessageCellAvatarSize;
    }
    _cellHeight += _marginBottom;
}

#pragma mark --- private method
// 布局 cell
- (void)layoutMessageCell {
    
    _nameTextTop = 0;
    CGFloat contentTextViewWidth = 0;
    CGFloat contentTextViewHeight = 0;
    CGFloat contentTextViewTop = 0;
    CGFloat contentTextViewX = 0;
    
    _messageModel.content = [[FJEmojiHelper sharedInstance] emojiFromIndexStr:_messageModel.content];
    // 系统 消息
    if (_messageModel.owner == FJChatMessageOwnerSystem) {
        if (_messageModel.content) {
            _messageModel.content = @"林大鹏加入";
            
            CGSize contentSize = [_messageModel.content qn_sizeWithFont:kChatMessageCellSystemTextLblFontSize maxW:kChatMessageCellContentWidth];
            
            contentTextViewWidth = contentSize.width + kChatMessageCellSystemMessageTextExtendWidth;
            
            contentTextViewHeight = contentSize.height + kChatMessageCellSystemMessageTextExtendHeight;
            
            contentTextViewX = kScreenWidth / 2.0 - contentTextViewWidth / 2.0f;
            
            _contentTextViewFrame = CGRectMake(contentTextViewX, contentTextViewTop, contentTextViewWidth, contentTextViewHeight);
            _marginBottom = kChatMessageSystemCellBottomMargin;
        }
    }
    
    // 自己的消息
    else if (_messageModel.owner == FJChatMessageOwnerSelf) {
        
        if (_messageModel.content) {
            NSMutableAttributedString *contentAttrStr = [[NSMutableAttributedString alloc] initWithString:_messageModel.content];
            contentAttrStr.color = kChatMessageCellOwerContentTextNormalColor;
            contentAttrStr.font = kChatMessageCellContextLblFontSize;
            contentAttrStr.lineSpacing = kChatMessageCellContentLblLineSpacing;
            
            YYTextContainer *container = [YYTextContainer new];
            container.size = CGSizeMake(kChatMessageCellContentLblWidth, HUGE);
            
            _contentTextLayout = [YYTextLayout layoutWithContainer:container text:contentAttrStr];
            
            contentTextViewHeight = _contentTextLayout.textBoundingSize.height + 2 * kChatMessageCellContentTextVerticalPadding;
            
            CGFloat tmpCurrentContentTextViewWidth = _contentTextLayout.textBoundingSize.width + 2 * kChatMessageCellContentTextHorizontalPadding;
            contentTextViewWidth = tmpCurrentContentTextViewWidth < kChatMessageCellContentWidth ? tmpCurrentContentTextViewWidth : kChatMessageCellContentWidth;
            contentTextViewX = kChatMessageCellOwerAvatarX - contentTextViewWidth - kChatMessageCellNameLblToAvatar;
            
            _contentTextViewFrame = CGRectMake(contentTextViewX, contentTextViewTop, contentTextViewWidth, contentTextViewHeight);
            
            _messageStateViewFrame = CGRectMake(contentTextViewX -  kChatMessageCellStateViewToContentView - kChatMessageCellStateViewSize, contentTextViewTop + (contentTextViewHeight / 2.0f) - kChatMessageCellStateViewSize/2.0, kChatMessageCellStateViewSize, kChatMessageCellStateViewSize);
            _marginBottom = kChatMessageCellBottomMargin;
        }
    }
    // 其他人的消息
    else if(_messageModel.owner == FJChatMessageOwnerOther){
        // 单聊 非 自己的消息
        if (_messageModel.chatMessageSessionType == FJChatMessageSessionTypeSingle) {
            if (_messageModel.content) {
                NSMutableAttributedString *contentAttrStr = [[NSMutableAttributedString alloc] initWithString:_messageModel.content];
                contentAttrStr.color = kChatMessageCellOtherContentTextNormalColor;
                contentAttrStr.font = kChatMessageCellContextLblFontSize;
                contentAttrStr.lineSpacing = kChatMessageCellContentLblLineSpacing;
                
                YYTextContainer *container = [YYTextContainer new];
                container.size = CGSizeMake(kChatMessageCellContentLblWidth, HUGE);
                
                _contentTextLayout = [YYTextLayout layoutWithContainer:container text:contentAttrStr];
                
                contentTextViewHeight = _contentTextLayout.textBoundingSize.height + 2 * kChatMessageCellContentTextVerticalPadding;
            }
        }
        // 群聊且非自己的消息
        else {
            if (_messageModel.nickname) {
                NSMutableAttributedString *nickNameAttrStr = [[NSMutableAttributedString alloc] initWithString:_messageModel.nickname];
                nickNameAttrStr.color = kChatMessageCellNicknameLblTextNormalColor;
                nickNameAttrStr.font = kChatMessageCellNicknameLblFontSize;
                
                YYTextContainer *container = [YYTextContainer new];
                container.size = CGSizeMake(kChatMessageCellContentWidth, HUGE);
                
                _nameTextLayout = [YYTextLayout layoutWithContainer:container text:nickNameAttrStr];
                contentTextViewTop = _nameTextTop + _nameTextLayout.textBoundingSize.height + kChatMessageCellContentLblToNameLbl;
                
            }
            
            if (_messageModel.content) {
                NSMutableAttributedString *contentAttrStr = [[NSMutableAttributedString alloc] initWithString:_messageModel.content];
                contentAttrStr.color = kChatMessageCellOtherContentTextNormalColor;
                contentAttrStr.font = kChatMessageCellContextLblFontSize;
                contentAttrStr.lineSpacing = kChatMessageCellContentLblLineSpacing;
                
                YYTextContainer *container = [YYTextContainer new];
                container.size = CGSizeMake(kChatMessageCellContentLblWidth, HUGE);
                
                _contentTextLayout = [YYTextLayout layoutWithContainer:container text:contentAttrStr];
                
                contentTextViewHeight = _contentTextLayout.textBoundingSize.height + 2 * kChatMessageCellContentTextVerticalPadding;
            }
        }
        
        CGFloat tmpCurrentContentTextViewWidth = _contentTextLayout.textBoundingSize.width + 2 * kChatMessageCellContentTextHorizontalPadding;
        contentTextViewWidth = tmpCurrentContentTextViewWidth < kChatMessageCellContentWidth ? tmpCurrentContentTextViewWidth : kChatMessageCellContentWidth;
        contentTextViewX = kChatMessageCellContentX;
        
        _contentTextViewFrame = CGRectMake(contentTextViewX, contentTextViewTop, contentTextViewWidth, contentTextViewHeight);
    
        _messageStateViewFrame = CGRectMake(CGRectGetMaxX(_contentTextViewFrame) + kChatMessageCellStateViewToContentView, contentTextViewTop + (contentTextViewHeight / 2.0f) - kChatMessageCellStateViewSize/2.0, kChatMessageCellStateViewSize, kChatMessageCellStateViewSize);
        _marginBottom = kChatMessageCellBottomMargin;
    }
}
@end
