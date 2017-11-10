//
//  FJChatEmojiView.m
//  funcode
//
//  Created by BuJi on 14/12/27.
//  Copyright (c) 2014年 Echo. All rights reserved.
//

#import "FJChatEmojiView.h"
#import "PageControl.h"
#import "FJChatMessageViewHeader.h"

// 高度
const CGFloat kFJChatEmojiViewHeight = 240.0f;
// 行
static const CGFloat kFJChatEmojiViewRow = 4;
// 列
static const CGFloat kFJChatEmojiViewColumn = 7;
// 页
static const CGFloat kFJChatEmojiViewPage = 2;


@interface FJChatEmojiView()<UIScrollViewDelegate>

@end

@implementation FJChatEmojiView

#pragma mark --- init method
- (instancetype)init {
    if (self = [super init]) {
        [self setupFJChatEmojiViewControls];
        [self layoutFJChatEmojiViewSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupFJChatEmojiViewControls];
        [self layoutFJChatEmojiViewSubViews];
    }
    return self;
}

#pragma mark --- private method
- (void)setupFJChatEmojiViewControls {
    
    [self addSubview:self.emotionView];
    [self addSubview:self.pageControl];
    [self addSubview:self.sendBtn];
    [self addSubview:self.separatorLineView];
    self.backgroundColor = [UIColor colorWithCustomType:AppColorTypeFontA];
}

- (void)layoutFJChatEmojiViewSubViews {
    [self.emotionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).mas_offset(-64.0f);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(20.0f);
        make.top.equalTo(self.emotionView.mas_bottom);
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(44.0f);
        make.bottom.mas_equalTo(self);
    }];
    
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}


#pragma mark --- sysetem delegate

- (void)scrollViewDidScroll:(UIScrollView *)ascrollView{
    NSInteger page = floor((ascrollView.contentOffset.x+ascrollView.frame.size.width/2)/ascrollView.frame.size.width);
    _pageControl.currentPage = page;
}


#pragma mark --- response event
// 删除
- (void)deleFaceClicked:(UIButton *)sender {
    if (self.deleteBtnBlock) {
        self.deleteBtnBlock(sender, sender.tag);
    }
}

// 选择
- (void)faceUpClicked:(UIButton *)sender {
    if (self.emojiBtnBlock) {
        self.emojiBtnBlock(sender, sender.tag);
    }
}

// 发送 按键
- (void)sendBtnClicked:(UIButton *)sender {
    if (self.sendBtnBlock) {
        self.sendBtnBlock(sender, sender.tag);
    }
}

#pragma mark --- getter method

// 表情
- (UIScrollView *)emotionView {
    if (!_emotionView) {
        _emotionView = [[UIScrollView alloc] init];
        _emotionView.delegate = self;
        _emotionView.pagingEnabled = YES;
        _emotionView.showsHorizontalScrollIndicator = NO;
        _emotionView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*2, kFJChatEmojiViewHeight - 64);
        //小表情
        NSInteger face_height = 40;
        NSInteger face_width = [UIScreen mainScreen].bounds.size.width/7.0;
        
        // 添加 表情
        for (NSInteger kIndex = 0; kIndex < kFJChatEmojiViewPage; kIndex++) {
            for (NSInteger iIndex = 0; iIndex < kFJChatEmojiViewColumn; iIndex++ ) {
                for (NSInteger jIndex = 0; jIndex < kFJChatEmojiViewRow; jIndex++) {
                    
                    CGFloat btnX = kIndex * [UIScreen mainScreen].bounds.size.width + face_width * iIndex;
                    CGFloat btnY = 5 + face_height * jIndex;
                    NSInteger deleteBtnTag =  kFJChatEmojiViewRow*kFJChatEmojiViewColumn-1+(kIndex * kFJChatEmojiViewColumn * kFJChatEmojiViewRow);
                    
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, face_width, face_height)];
                    btn.tag = jIndex * kFJChatEmojiViewColumn + iIndex + (kIndex * kFJChatEmojiViewColumn * kFJChatEmojiViewRow);
                    
                    NSString *strIndex = [NSString stringWithFormat:@"face_%02ld.png", (long)btn.tag];
                    
                    if (btn.tag == deleteBtnTag) {
                        strIndex = @"chat_tool_icon_delete.png";
                        [btn addTarget:self action:@selector(deleFaceClicked:) forControlEvents:UIControlEventTouchUpInside];
                    }else{
                        [btn addTarget:self action:@selector(faceUpClicked:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    [btn setImage:[UIImage imageNamed:strIndex] forState:UIControlStateNormal];
                    [_emotionView addSubview:btn];
                }
            }
        }
    }
    return _emotionView;
}

// 发送 按键
- (UIButton *)sendBtn {
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] init];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor colorWithCustomType:AppColorTypeFontA] forState:UIControlStateNormal];
        _sendBtn.backgroundColor = [UIColor colorWithCustomType:AppColorTypeA];
        [_sendBtn addTarget:self action:@selector(sendBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

// 页码
- (PageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[PageControl alloc] init];
        _pageControl.numberOfPages = 2;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

// 分割线
- (UIView *)separatorLineView {
    if (!_separatorLineView) {
        _separatorLineView = [[UIView alloc] init];
        _separatorLineView.backgroundColor = [UIColor colorWithCustomType:AppColorTypeC];
    }
    return _separatorLineView;
}
@end
