//
//  FJOtherChatMessageCell.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageViewHeader.h"
#import "FJOtherChatMessageCell.h"
#import "UIImageView+CornerRadius.h"


NSString *const kFJOtherChatMessageCellId = @"FJOtherChatMessageCellId";

@implementation FJOtherChatMessageCell

#pragma mark --- init method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCellControls];
    }
    return self;
}


#pragma mark --- public method

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    FJOtherChatMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kFJOtherChatMessageCellId];
    if (cell == nil) {
        cell = [[FJOtherChatMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFJOtherChatMessageCellId];
    }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



#pragma mark --- private method
// 设置 控件
- (void)setupCellControls {
    [self addSubview:self.backgroundImgView];
    [self addSubview:self.avatarImgView];
    [self addSubview:self.nickNameLbl];
    [self addSubview:self.contentLbl];
    self.backgroundColor = [UIColor clearColor];
}


#pragma mark --- getter method
// 昵称
- (YYLabel *)nickNameLbl {
    if (!_nickNameLbl) {
        _nickNameLbl = [YYLabel new];
        _nickNameLbl.displaysAsynchronously = YES;
        _nickNameLbl.ignoreCommonProperties = YES;
        _nickNameLbl.fadeOnAsynchronouslyDisplay = NO;
        _nickNameLbl.fadeOnHighlight = NO;
        _nickNameLbl.top = 0;
        _nickNameLbl.width = kChatMessageCellContentWidth;
        _nickNameLbl.left = kChatMessageCellContentX;
        _nickNameLbl.layer.cornerRadius = 2.0f;
        _nickNameLbl.lineBreakMode = NSLineBreakByClipping;
        _nickNameLbl.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    return _nickNameLbl;
}

// 头像
- (UIImageView *)avatarImgView {
    if(!_avatarImgView){
        _avatarImgView = [UIImageView new];
        _avatarImgView.size = CGSizeMake(kChatMessageCellAvatarSize, kChatMessageCellAvatarSize);
        _avatarImgView.origin = CGPointMake(kChatMessageCellPadding, 0);
        _avatarImgView.contentMode = UIViewContentModeScaleAspectFill;
        [_avatarImgView zy_cornerRadiusRoundingRect];
    }
    return _avatarImgView;
}

// 文本
- (YYLabel *)contentLbl {
    if (!_contentLbl) {
        _contentLbl = [[YYLabel alloc] init];
        _contentLbl.width = kChatMessageCellContentWidth;
        _contentLbl.left = kChatMessageCellContentX;
        _contentLbl.displaysAsynchronously = YES;
        _contentLbl.ignoreCommonProperties = YES;
        _contentLbl.fadeOnAsynchronouslyDisplay = NO;
        _contentLbl.fadeOnHighlight = NO;
        _contentLbl.lineBreakMode = NSLineBreakByClipping;
        _contentLbl.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    return _contentLbl;
}

// 背景图
- (UIImageView *)backgroundImgView {
    if(!_backgroundImgView){
        _backgroundImgView = [UIImageView new];
        UIImage *backgroundImg = [UIImage imageNamed:@"bg_liaotianqipao_hui.png"];
        UIImage *stretchImg = [backgroundImg stretchableImageWithLeftCapWidth:backgroundImg.size.width * 0.5 topCapHeight:backgroundImg.size.height * 0.5];
         [_backgroundImgView setImage:stretchImg];
    }
    return _backgroundImgView;
}


@end
