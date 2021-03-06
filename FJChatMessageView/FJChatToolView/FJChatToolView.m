
//
//  FJChatToolView.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/8.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatToolView.h"
#import "FJChatMessageViewHeader.h"


// 高度
static const CGFloat kChatToolViewHeight = 50.0f;

static NSInteger const kChatMessageMaxLimit = 140;

@interface FJChatToolView()<YYTextViewDelegate>
// 显示 聊天 view
@property (nonatomic, getter=isShowFootView, assign) BOOL showFootView;
// 当前 高度
@property (nonatomic, assign) CGFloat currentChatFootViewHeight;
@end

@implementation FJChatToolView

#pragma mark -- init method

- (instancetype)init {
    if (self = [super init]) {
        [self addKeyboardNotiObserver];
        [self setupChatToolViewControls];
        [self layoutChatToolViewSubViews];
    }
    return self;
}


#pragma mark --- public method
// 清空 数据
- (void)clearTextView {
    self.textView.text = @"";
}

// 获取 聊天 高度
+ (CGFloat)getChatToolViewHeight {
    return kChatToolViewHeight + FJ_TABBAR_SAFE_BOTTOM_MARGIN;
}

#pragma mark --- private method
// 设置
- (void)setupChatToolViewControls {
    
    [self addSubview:self.textBgView];
    self.chatMessageMaxValue = kChatMessageMaxLimit;
    [self.textBgView addSubview:self.lineView];
    [self.textBgView addSubview:self.textView];
    [self.textBgView addSubview:self.switchBtn];
    self.currentChatFootViewHeight = [FJChatToolView getChatToolViewHeight];
    self.backgroundColor = [UIColor colorWithCustomType:AppColorTypeFontA];
}

// 添加 键盘 通知 监听
- (void)addKeyboardNotiObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}

// 显示 时候 底部 聊天 框 高度
- (CGFloat)chatMessageFootViewHeightWhenShow {
    if(self.isShowFootView == NO) {
        self.currentChatFootViewHeight = self.currentChatFootViewHeight - FJ_TABBAR_SAFE_BOTTOM_MARGIN;
    }
    self.showFootView = YES;
    return self.currentChatFootViewHeight;
}

// 隐藏 时候 底部 聊天 高度
- (CGFloat)chatMessageFootViewHeightWhenHidden {
    if(self.isShowFootView == YES) {
        self.currentChatFootViewHeight = self.currentChatFootViewHeight + FJ_TABBAR_SAFE_BOTTOM_MARGIN;
    }
    self.showFootView = NO;
    return self.currentChatFootViewHeight;
}

// 布局
- (void)layoutChatToolViewSubViews {
    
    [self.textBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(kChatToolViewHeight);
        make.top.equalTo(self);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.textBgView);
        make.height.equalTo(@(0.5));
    }];
    
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textBgView);
        make.centerY.equalTo(self.textBgView);
        make.width.equalTo(@55);
        make.height.equalTo(@30);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textBgView).offset(15);
        make.top.equalTo(self.textBgView).offset(8);
        make.right.equalTo(self.switchBtn.mas_left);
        make.bottom.equalTo(self.textBgView).offset(-8);
    }];
}

#pragma mark --- custom delegate

- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView {
    
    
    [self.superview layoutIfNeeded];
    [self.superview bringSubviewToFront:self];
    
    return YES;
}


- (void)textViewDidChange:(YYTextView *)textView {
    
    // 选中 位置
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolView:textLocation:)]) {
        [self.delegate chatToolView:self textLocation:textView.selectedRange.location];
    }
    
    //字数限制
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *toBeString = textView.text;
        UITextRange *selectedRange = [textView markedTextRange];//获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        if (!position) { // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > self.chatMessageMaxValue) {
                
//                [LETostView showWithDefault:[NSString stringWithFormat:@"%@%ld%@", Localized(@"不能超过"),_LEChatToolViewMaxValue, Localized(@"字")]];
                
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex: self.chatMessageMaxValue];
                if (rangeIndex.length == 1) {
                    textView.text = [toBeString substringToIndex:self.chatMessageMaxValue];
                } else {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0,  self.chatMessageMaxValue)];
                    textView.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    });
    
    
    //适配高度
    
    if (self.textView.textLayout.rowCount <= 4 && self.textView.textLayout.rowCount >= 1) {
        
        CGFloat height = self.textView.textLayout.textBoundingSize.height + 20;
        self.currentChatFootViewHeight = height;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(self.currentChatFootViewHeight));
        }];
        [self.textBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(self.currentChatFootViewHeight));
        }];
    }
    
    if (self.isSendText) {
        self.sendText = NO;
        self.textView.text = @"";
    }
}


- (BOOL)textView:(YYTextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolView:sendText:)]) {
            [self.delegate chatToolView:self sendText:self.textView.text];
        }
        self.sendText = YES;
        return NO;
    }
    return YES;
}

#pragma mark --- noti method
// 处理键盘frame改变通知
- (void)handleKeyboard:(NSNotification *)aNotification {
    // 显示
    if([aNotification.name isEqualToString:UIKeyboardWillShowNotification]){
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo([self chatMessageFootViewHeightWhenShow]);
        }];
    }
    // 隐藏
    else if([aNotification.name isEqualToString:UIKeyboardWillHideNotification]){
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo([self chatMessageFootViewHeightWhenHidden]);
        }];
    }
}


#pragma mark --- response event
// 切换 表情/键盘
- (void)switchBtnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    FJChatToolBarShowingView showType = sender.selected ? FJChatToolBarShowingFaceView : FJChatToolBarShowingKeyboard;
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolView:showType:)]) {
        [self.delegate chatToolView:self showType:showType];
    }
}

#pragma mark --- getter method

// 是否 显示 footView
- (BOOL)isShowFootView {
    return _showFootView;
}
// 分割线
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithCustomType:AppColorTypeC];
    }
    return _lineView;
}

// 表情/键盘 切换键
- (UIButton *)switchBtn {
    if (_switchBtn == nil) {
        _switchBtn = [[UIButton alloc] init];
        _switchBtn.titleLabel.font = [UIFont fontWithCustomType:AppFontTypeB];
        [_switchBtn setImage:[UIImage imageNamed:@"chat_tool_icon_biaoqing.png"] forState:UIControlStateNormal];
        [_switchBtn setImage:[UIImage imageNamed:@"chat_tool_icon_jianpan.png"] forState:UIControlStateSelected];
        [_switchBtn addTarget:self
                       action:@selector(switchBtnClicked:)
                 forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchBtn;
}


// 输入框 背景
- (UIView *)textBgView {
    if (_textBgView == nil) {
        _textBgView = [[UIView alloc] init];
        _textBgView.backgroundColor = [UIColor colorWithCustomType:AppColorTypeFontA];
    }
    return _textBgView;
}

// 输入框
- (YYTextView *)textView {
    if (_textView == nil) {
        _textView = [[YYTextView alloc] init];
        _textView.textColor = [UIColor colorWithCustomType:AppColorTypeFontC];
        _textView.placeholderTextColor = [UIColor colorWithCustomType:AppColorTypeFontE];
        _textView.placeholderFont = [UIFont fontWithCustomType:AppFontTypeE];
        _textView.font = [UIFont fontWithCustomType:AppFontTypeE];
        _textView.tintColor = [UIColor colorWithCustomType:AppColorTypeFontC];
        _textView.returnKeyType = UIReturnKeySend;
        _textView.placeholderText = @"请输入消息...";
        _textView.textContainerInset = UIEdgeInsetsMake(8, 8, 0, 8);
        _textView.delegate = self;
        _textView.layer.cornerRadius = 17.0f;
        _textView.backgroundColor = [UIColor colorWithCustomType:AppColorTypeD];
    }
    return _textView;
}

#pragma mark --- dealloc method
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
