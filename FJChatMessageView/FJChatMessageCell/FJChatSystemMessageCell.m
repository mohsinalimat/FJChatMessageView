//
//  FJChatSystemMessageCell.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageViewHeader.h"
#import "FJChatSystemMessageCell.h"


NSString *const kFJChatSystemMessageCellId = @"FJChatSystemMessageCellId";

@implementation FJChatSystemMessageCell

#pragma mark --- init method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCellControls];
    }
    return self;
}


#pragma mark --- public method

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellId = @"FJChatSystemMessageCellId";
    FJChatSystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[FJChatSystemMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



#pragma mark --- private method
// 设置 控件
- (void)setupCellControls {
    [self.contentView addSubview:self.systemTextLbl];
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark --- getter method
// 系统 消息
- (UILabel *)systemTextLbl {
    if (!_systemTextLbl) {
        _systemTextLbl = [[UILabel alloc] init];
        _systemTextLbl.layer.cornerRadius = 2.0f;
        _systemTextLbl.top = 0;
        _systemTextLbl.textAlignment = NSTextAlignmentCenter;
        _systemTextLbl.lineBreakMode = NSLineBreakByClipping;
        _systemTextLbl.font = kChatMessageCellSystemTextLblFontSize;
        _systemTextLbl.textColor = kChatMessageCellSystemLblTextNormalColor;
        _systemTextLbl.backgroundColor = kChatMessageCellSystemLblTextBackground;
    }
    return _systemTextLbl;
}
@end
