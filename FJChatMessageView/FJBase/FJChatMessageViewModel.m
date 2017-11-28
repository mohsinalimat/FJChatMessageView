
//
//  FJChatMessageViewModel.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/10.
//  Copyright © 2017年 fjf. All rights reserved.
//


#import "FJChatMessageServer.h"
#import "FJChatMessageLayout.h"
#import "FJChatMessageModel.h"
#import "FJChatMessageViewModel.h"

// cell
#import "FJOwerChatMessageCell.h"
#import "FJChatSystemMessageCell.h"
#import "FJOtherChatMessageCell.h"
#import "FJOtherChatMessageCell+MessageLayoutConfig.h"
#import "FJOwerChatMessageCell+MessageLayoutConfig.h"
#import "FJChatSystemMessageCell+MessageLayoutConfig.h"

@interface FJChatMessageViewModel()
/**
 *  存储所有信息的数组
 */
@property (nonatomic, strong,  nonnull) NSMutableArray <FJChatMessageLayout *>*tableCellLayouts;
@end

@implementation FJChatMessageViewModel

#pragma mark --- init method

- (_Nullable instancetype)initWithChatSessionType:(FJChatMessageSessionType)chatSessionType {
    if (self = [super init]) {
        _chatSessionType = chatSessionType;
        _tableCellLayouts = [NSMutableArray array];
    }
    return self;
}

#pragma mark --- public method

// 加载 聊天 信息
- (void)loadChatMessageWithRequestCount:(NSInteger)requestCount completion:(FJChatMessageViewModelCompletionBlock)completion {
    __weak typeof(self) weakSelf = self;
    [FJChatMessageServer loadChatMessageWithChatSessionType:_chatSessionType requestCount:requestCount completion:^(NSArray *resDataArray, BOOL isSuccess) {
        if (isSuccess) {
            for (FJChatMessageModel *tmpSigleModel in resDataArray) {
                FJChatMessageLayout *tmpLayout = [[FJChatMessageLayout alloc] initWithMessageModel:tmpSigleModel];
                [weakSelf.tableCellLayouts addObject:tmpLayout];
            }
        }
        completion(isSuccess);
    }];
}


// 发送的消息
- (void)sendMessage:(FJChatMessageModel *)aMessage {
    if (aMessage) {
        aMessage.chatMessageSessionType = _chatSessionType;
        FJChatMessageLayout *tmpLayout = [[FJChatMessageLayout alloc] initWithMessageModel:aMessage];
        [self.tableCellLayouts addObject:tmpLayout];
    }
}

#pragma mark --- system delegate
// UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableCellLayouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FJChatMessageLayout *tmpLayout = self.tableCellLayouts[indexPath.row];
    
    if (tmpLayout.messageModel.owner == FJChatMessageOwnerSystem) {
        FJChatSystemMessageCell *cell = [FJChatSystemMessageCell cellWithTableView:tableView];
        [cell configWithMessageLayout:tmpLayout];
        return cell;
    }
    else if (tmpLayout.messageModel.owner == FJChatMessageOwnerSelf) {
        FJOwerChatMessageCell *cell = [FJOwerChatMessageCell cellWithTableView:tableView];
        [cell configWithMessageLayout:tmpLayout];
        return cell;
    }
    else {
        FJOtherChatMessageCell *cell = [FJOtherChatMessageCell cellWithTableView:tableView];
        [cell configWithMessageLayout:tmpLayout];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((FJChatMessageLayout *)self.tableCellLayouts[indexPath.row]).cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark --- ScrollViewDelegate Methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if(self.scrollBlock) {
        self.scrollBlock(scrollView);
    }
}
@end
