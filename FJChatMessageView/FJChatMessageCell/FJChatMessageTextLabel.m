//
//  FJChatMessageTextView.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/24.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageViewHeader.h"
#import "FJChatMessageTextLabel.h"

@implementation FJChatMessageTextLabel
#pragma mark --------------- Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        __weak typeof(self) weakSelf = self;
        self.textLongPressAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            [weakSelf initMenuController];
        };
    }
    return self;
}

#pragma mark --------------- Private Methods

// 初始化 复制 弹框
- (void)initMenuController{
    
    [self becomeFirstResponder];
    UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyAction:)];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:@[copy]];
    
    [menu setTargetRect:self.bounds inView:self];
    [menu setMenuVisible:YES animated:YES];
}

#pragma mark --- response event

- (void)copyAction:(id)sender {
    if (self.textLayout.text.string) {
        UIPasteboard *pboard = [UIPasteboard generalPasteboard];
        pboard.string = self.textLayout.text.string;
    }
}

#pragma mark --------------- Override Methods
- (BOOL)canBecomeFirstResponder {
    return YES;
}


@end
