//
//  FJChatMessageCell.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/24.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageCell.h"
#import "FJChatMessageStateView.h"
#import "FJChatMessageViewHeader.h"
#import "FJChatMessageContentView.h"
#import "UIImageView+CornerRadius.h"


@implementation FJChatMessageCell

#pragma mark --------------- Init Methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupChatMessageCellControls];
    }
    return self;
}

#pragma mark --------------- Private Methods

- (void)setupChatMessageCellControls {
    [self addSubview:self.avatarImgView];
    [self addSubview:self.backgroundImgView];
    [self addSubview:self.messageStateView];
    [self addSubview:self.messageContentView];
}

#pragma mark --------------- Getter / Setter
// 头像
- (UIImageView *)avatarImgView {
    if(!_avatarImgView){
        _avatarImgView = [UIImageView new];
        _avatarImgView.size = CGSizeMake(kChatMessageCellAvatarSize, kChatMessageCellAvatarSize);
        _avatarImgView.origin = CGPointMake(kChatMessageCellOwerAvatarX
                                            , 0);
        _avatarImgView.contentMode = UIViewContentModeScaleAspectFill;
        [_avatarImgView zy_cornerRadiusRoundingRect];
    }
    return _avatarImgView;
}

// 消息 状态 view
- (FJChatMessageStateView *)messageStateView {
    if(!_messageStateView){
        _messageStateView = [[FJChatMessageStateView alloc] init];
    }
    return _messageStateView;
}

// 内容 view
- (FJChatMessageContentView *)messageContentView {
    if (!_messageContentView) {
        
        _messageContentView = [[FJChatMessageContentView alloc] init];
    }
    return _messageContentView;
}

// 背景图
- (UIImageView *)backgroundImgView {
    if(!_backgroundImgView){
        _backgroundImgView = [UIImageView new];
        _backgroundImgView.clipsToBounds = YES;
        UIImage *backgroundImg = [UIImage imageNamed:@"bg_liaotianqipao_lv_dianji.png"];
        UIImage *stretchImg = [backgroundImg stretchableImageWithLeftCapWidth:backgroundImg.size.width * 0.5 topCapHeight:backgroundImg.size.height * 0.5];
        [_backgroundImgView setImage:stretchImg];
    }
    return _backgroundImgView;
}
@end
