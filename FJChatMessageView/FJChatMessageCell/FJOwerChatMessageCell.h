//
//  FJOwerChatMessageCell.h
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/9.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJChatMessageCell.h"

UIKIT_EXTERN NSString *const kFJOwerChatMessageCellId ;

@class YYLabel;
@class FJChatMessageLayout;

@interface FJOwerChatMessageCell : FJChatMessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
