//
//  FJOtherChatMessageCell.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kFJOtherChatMessageCellId;

@class YYLabel;
@class FJChatMessageLayout;

@interface FJOtherChatMessageCell : UITableViewCell
// 头像
@property (nonatomic, strong) UIImageView *avatarImgView;
// 昵称
@property (nonatomic, strong) YYLabel *nickNameLbl;
// 内容
@property (nonatomic, strong) YYLabel *contentLbl;
// 背景图
@property (nonatomic, strong) UIImageView *backgroundImgView;
// 模型 布局
@property (nonatomic, strong) FJChatMessageLayout *messageLayout;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
