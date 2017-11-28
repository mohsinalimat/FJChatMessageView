
//
//  FJChatMessageStateView.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/24.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageStateView.h"

@interface FJChatMessageStateView()
// 图片
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation FJChatMessageStateView

#pragma mark --------------- Init Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.indicatorView];
    }
    return self;
}


#pragma mark --------------- Override Methods

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.indicatorView.frame = self.bounds;
}


#pragma mark --------------- Getter / Setter

- (void)setChatMessageState:(FJChatMessageState)chatMessageState {
    _chatMessageState = chatMessageState;
    self.hidden = NO;
    switch (chatMessageState) {
        case FJChatMessageStateFailed:
            self.indicatorView.hidden = YES;
            self.imageView.hidden = NO;
            [self.indicatorView stopAnimating];
            break;
        case FJChatMessageStateSending:
        case FJChatMessageStateRecieving:
            self.indicatorView.hidden = NO;
            self.imageView.hidden = YES;
            [self.indicatorView startAnimating];
            break;
        default:
            self.hidden = YES;
            break;
    }
}
//  提示 图标
- (UIImageView *)imageView {
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"icon_tongyong_liaotian_tishi.png"];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return  _imageView;
}

// 转圈
- (UIActivityIndicatorView *)indicatorView {
    if(!_indicatorView){
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return  _indicatorView;
}

@end
