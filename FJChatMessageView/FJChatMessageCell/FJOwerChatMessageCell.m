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
        [self layoutOwerChatMessageCellControls];
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


#pragma mark --------------- Private Methods

// 设置 控件
- (void)setupCellControls {
    UIImage *backgroundImg = [UIImage imageNamed:@"bg_liaotianqipao_lv_dianji.png"];
    UIImage *stretchImg = [backgroundImg stretchableImageWithLeftCapWidth:backgroundImg.size.width * 0.5 topCapHeight:backgroundImg.size.height * 0.5];
    self.backgroundImgView.image = stretchImg;
    self.backgroundColor = [UIColor clearColor];
}


// 布局 控件
- (void)layoutOwerChatMessageCellControls {
    self.avatarImgView.frame = CGRectMake(kChatMessageCellOwerAvatarX, 0, kChatMessageCellAvatarSize, kChatMessageCellAvatarSize);
}
@end
