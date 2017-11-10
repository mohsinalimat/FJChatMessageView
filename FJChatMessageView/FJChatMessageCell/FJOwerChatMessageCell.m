//
//  FJOwerChatMessageCell.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "UIImageView+CornerRadius.h"
#import "FJChatMessageViewHeader.h"
#import "FJOwerChatMessageCell.h"

@implementation FJOwerChatMessageCell

NSString *const kFJOwerChatMessageCellId = @"FJOwerChatMessageCellId";

#pragma mark --- init method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCellControls];
    }
    return self;
}


#pragma mark --- public method

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    FJOwerChatMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kFJOwerChatMessageCellId];
    if (cell == nil) {
        cell = [[FJOwerChatMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFJOwerChatMessageCellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



#pragma mark --- private method
// 设置 控件
- (void)setupCellControls {
    [self addSubview:self.backgroundImgView];
    [self addSubview:self.avatarImgView];
    [self addSubview:self.contentLbl];
    self.backgroundColor = [UIColor clearColor];
}


#pragma mark --- getter method
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
        UIImage *backgroundImg = [UIImage imageNamed:@"bg_liaotianqipao_lv_dianji.png"];
        UIImage *stretchImg = [backgroundImg stretchableImageWithLeftCapWidth:backgroundImg.size.width * 0.5 topCapHeight:backgroundImg.size.height * 0.5];
         [_backgroundImgView setImage:stretchImg];
    }
    return _backgroundImgView;
}
@end
