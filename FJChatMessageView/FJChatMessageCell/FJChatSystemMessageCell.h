//
//  FJChatSystemMessageCell.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kFJChatSystemMessageCellId;
@class FJChatMessageLayout;
@interface FJChatSystemMessageCell : UITableViewCell
// 系统 消息
@property (nonatomic, strong) UILabel *systemTextLbl;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

// 模型 布局
@property (nonatomic, strong) FJChatMessageLayout *messageLayout;
@end
