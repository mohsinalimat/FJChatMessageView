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
        [self layoutOtherChateMessageCellControls];
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
    [self addSubview:self.nickNameLbl];
    UIImage *backgroundImg = [UIImage imageNamed:@"bg_liaotianqipao_hui.png"];
    UIImage *stretchImg = [backgroundImg stretchableImageWithLeftCapWidth:backgroundImg.size.width * 0.5 topCapHeight:backgroundImg.size.height * 0.5];
    self.backgroundImgView.image = stretchImg;
    self.backgroundColor = [UIColor clearColor];
}

// 布局 控件
- (void)layoutOtherChateMessageCellControls {
    self.avatarImgView.frame = CGRectMake(kChatMessageCellPadding, 0, kChatMessageCellAvatarSize, kChatMessageCellAvatarSize);
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
@end
