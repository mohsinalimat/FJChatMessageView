//
//  FJChatMessageViewController.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/8.
//  Copyright © 2017年 fjf. All rights reserved.
//

// view
#import "FJChatEmojiView.h"
#import "FJChatToolView.h"

// other
#import "FJEmojiHelper.h"
#import "FJChatMessageModel.h"
#import "FJChatMessageLayout.h"
#import "FJChatMessageViewHeader.h"
// cell
#import "FJOwerChatMessageCell.h"
#import "FJChatSystemMessageCell.h"
#import "FJOtherChatMessageCell.h"
#import "FJOtherChatMessageCell+MessageLayoutConfig.h"
#import "FJOwerChatMessageCell+MessageLayoutConfig.h"
#import "FJChatSystemMessageCell+MessageLayoutConfig.h"
// vc
#import "FJChatMessageViewController.h"
#import "FJChatMessageViewController+GestureAction.h"

@interface FJChatMessageViewController ()<UITableViewDataSource,UITableViewDelegate,FJChatToolViewDelegate>
// 表情图
@property (nonatomic, strong) FJChatEmojiView *chatEmojiView;
// 聊天框
@property (nonatomic, strong) FJChatToolView *chatToolView;
// layout
@property (nonatomic, strong) NSMutableArray *tableCellLayouts;
// 转圈
@property (nonatomic, strong) UIActivityIndicatorView *indatorView;
@end

@implementation FJChatMessageViewController

#pragma mark --- life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGestures];
    [self setupViewControls];
    [self setupNetworkRequest];
    [self addKeyboardNotiObserver];
    [self layoutViewControllerSubviews];
}


#pragma mark --- private method
// 设置 子控件
- (void)setupViewControls {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatToolView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.chatEmojiView.backgroundColor = [UIColor colorWithCustomType:AppColorTypeFontA];
}

// 设置 网络 请求
- (void)setupNetworkRequest {
    [self requestNeedData];
    [self.indatorView startAnimating];
}

// 设置 手势
- (void)setupGestures {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction:)];
    [self.tableView addGestureRecognizer:tap];
}


// 布局
- (void)layoutViewControllerSubviews {
    [self.chatToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(kChatToolViewHeight);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

// 获取  数据
- (void)requestNeedData {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong typeof(self) strongSelf = weakSelf;
        
        for (FJChatMessageModel *tmpSigleModel in [strongSelf creatModelsWithCount:50]) {
            FJChatMessageLayout *tmpLayout = [[FJChatMessageLayout alloc] initWithMessageModel:tmpSigleModel];
            [strongSelf.tableCellLayouts addObject:tmpLayout];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf.indatorView stopAnimating];
            [strongSelf.tableView reloadData];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [strongSelf scrollBottom:NO];
            });
        });
    });
}

// 添加 键盘 通知 监听
- (void)addKeyboardNotiObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboard:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

// 发送 聊天 信息
- (void)sendChatMessage:(NSString *)chatMessage {
    FJChatMessageModel *model = [FJChatMessageModel new];
    model.avatarUrl = @"http://image.dnews.blessi.cn/o_1btebleip1qt61bg81htur8213pmu.jpg?imageView2/2/w/800";
    model.nickname = @"池善概";
    model.content = chatMessage;
    model.owner = FJChatMessageOwnerSelf;
    model.messageType = FJChatMessageTypeText;
    model.chatMessageSessionType = FJChatMessageSessionTypeGroup;
    
    FJChatMessageLayout *tmpLayout = [[FJChatMessageLayout alloc] initWithMessageModel:model];
    [self.tableCellLayouts addObject:tmpLayout];
    [self.chatToolView clearTextView];
    [self.tableView reloadData];
    [self scrollBottom:NO];
}


- (NSArray *)creatModelsWithCount:(NSInteger)count {
    NSArray *iconImageNamesArray = @[@"http://image.dnews.blessi.cn/o_1btekj9fb1i39nhkavk1jfvr7sa.png",
                                     @"http://image.dnews.blessi.cn/FueE9vWlCcsae9m6avzT1O2ihq5r",
                                     @"http://image.dnews.blessi.cn/o_1btebl2sn14ta146n1487shc1ar1a.jpg?imageView2/2/w/800",
                                     @"http://image.dnews.blessi.cn/o_1bteblipmu3t1efq92bn3318m313.jpg?imageView2/2/w/800",
                                     @"http://image.dnews.blessi.cn/o_1btebl5jued6ahm1h78q9g1konf.jpg?imageView2/2/w/800",
                                     @"http://image.dnews.blessi.cn/o_1btebl82615f31etap8eljljd3k.jpg?imageView2/2/w/800",
                                     @"http://image.dnews.blessi.cn/o_1bteblb1genm1jg419copa9ktap.jpg?imageView2/2/w/800",
                                     @"http://image.dnews.blessi.cn/o_1btebleip1qt61bg81htur8213pmu.jpg?imageView2/2/w/800",
                                     @"http://image.dnews.blessi.cn/o_1bteblm071kre6p3vd3vvg6h18.jpg?imageView2/2/w/800",
                                     @"http://image.dnews.blessi.cn/o_1bteblp03rvq1f3g1l1kfj3pu51d.jpg?imageView2/2/w/800",
                                     @"http://image.dnews.blessi.cn/o_1bteblsku1vfa1hsna621kc8jrk1i.jpg?imageView2/2/w/800",];
    
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
    NSArray *owerArray = @[@"1",@"2",@"3"];
    
    NSArray *messageTypeArray = @[@"1",@"2"];
    
    NSArray *textArray = @[@"当你的 app",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期",
                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
   
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(10);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        int owerIndex = arc4random_uniform(3);
        int messageTypeIndex = arc4random_uniform(2);
        FJChatMessageModel *model = [FJChatMessageModel new];
        model.avatarUrl = iconImageNamesArray[iconRandomIndex];
        model.nickname = namesArray[nameRandomIndex];
        model.content = textArray[contentRandomIndex];
        model.owner = [owerArray[owerIndex] integerValue];
        model.messageType = [messageTypeArray[messageTypeIndex] integerValue];
        model.chatMessageSessionType = FJChatMessageSessionTypeGroup;

        [resArr addObject:model];
    }
    return [resArr copy];
}


- (void)scrollBottom:(BOOL)animated {
    
    if (self.tableCellLayouts.count >= 1) {
        [self.tableView scrollToBottomAnimated:animated];
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


#pragma mark --- custom delegate
// 表情 / 键盘 切换
- (void)chatToolView:(FJChatToolView *)chatToolView showType:(FJChatToolBarShowingView)showType {
    // 表情
    if (showType == FJChatToolBarShowingFaceView) {
        self.chatToolView.textView.inputView = self.chatEmojiView;
        self.chatToolView.textView.extraAccessoryViewHeight = kFJChatEmojiViewHeight;
        [self.chatToolView.textView reloadInputViews];
        [self.chatToolView.textView becomeFirstResponder];
    }
    // 键盘
    else if(showType == FJChatToolBarShowingKeyboard){
        self.chatToolView.textView.inputView = nil;
        [self.chatToolView.textView reloadInputViews];
        [self.chatToolView.textView becomeFirstResponder];
    }
    // 点击 空白 区域
    else if (showType == FJChatToolBarShowingNoneView) {
        self.chatToolView.textView.inputView = nil;
        [self.chatToolView.textView endEditing:YES];
        [self.chatToolView.textView resignFirstResponder];
    }
}

// 点击 发送 按键
- (void)chatToolView:(FJChatToolView *)chatToolView sendText:(NSString *)sendText {
    [self sendChatMessage:sendText];
}


- (void)chatToolView:(FJChatToolView *)chatToolView textLocation:(NSInteger)textLocation {
    
    [[FJEmojiHelper sharedInstance] updateSelectLocationWithTextLocation:textLocation];
}


#pragma mark --- noti method

// 处理键盘frame改变通知
- (void)handleKeyboard:(NSNotification *)aNotification {
    
    CGRect keyboardFrame = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [self.chatToolView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-([UIScreen mainScreen].bounds.size.height - keyboardFrame.origin.y));
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-([UIScreen mainScreen].bounds.size.height - keyboardFrame.origin.y));
    }];
    /** 增加监听键盘大小变化通知,并且让tableView 滚动到最底部 */
    [self.view layoutIfNeeded];
    [self scrollBottom:NO];
}

#pragma mark --- response event

- (void)handleTapAction:(UITapGestureRecognizer *)tap {
    
    [self.view endEditing:YES];
    [self chatToolView:self.chatToolView showType:FJChatToolBarShowingNoneView];
    
}
#pragma mark --- getter method
// 聊天 框
- (FJChatToolView *)chatToolView {
    if (!_chatToolView) {
        _chatToolView = [[FJChatToolView alloc] init];
        _chatToolView.delegate = self;
    }
    return _chatToolView;
}
// 表情
- (FJChatEmojiView *)chatEmojiView {
    if (!_chatEmojiView) {
        _chatEmojiView = [[FJChatEmojiView alloc] initWithFrame:CGRectMake(0, self.view.height - kFJChatEmojiViewHeight, self.view.width, kFJChatEmojiViewHeight)];
        
        __weak typeof(self) weakSelf = self;
        
        // 点击 删除 按键
        _chatEmojiView.deleteBtnBlock = ^(UIButton *btn, NSInteger btnTag) {
           weakSelf.chatToolView.textView.text = [[FJEmojiHelper sharedInstance] deletedTextWithOriginText:weakSelf.chatToolView.textView.text];
        };
        // 点击 表情
        _chatEmojiView.emojiBtnBlock = ^(UIButton *btn, NSInteger btnTag) {
            NSString *originalText = weakSelf.chatToolView.textView.text;
            weakSelf.chatToolView.textView.text = [[FJEmojiHelper sharedInstance] textWithEmojiTag:btnTag originText:originalText];
            [weakSelf.chatToolView.textView scrollRangeToVisible:NSMakeRange(weakSelf.chatToolView.textView.text.length, 1)];
            weakSelf.chatToolView.textView.selectedRange = NSMakeRange(weakSelf.chatToolView.textView.text.length, 1);
        };
        // 点击 发送
        _chatEmojiView.sendBtnBlock = ^(UIButton *btn, NSInteger btnTag) {
            [weakSelf sendChatMessage:weakSelf.chatToolView.textView.text];
        };
    }
    return _chatEmojiView;
}

// tableView
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = [UIColor colorWithCustomType:AppColorTypeD];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64.0f + kChatToolViewHeight)];
        [_tableView registerClass:[FJOwerChatMessageCell class] forCellReuseIdentifier:kFJOwerChatMessageCellId];
        [_tableView registerClass:[FJOtherChatMessageCell class] forCellReuseIdentifier:kFJOtherChatMessageCellId];
        [_tableView registerClass:[FJChatSystemMessageCell class] forCellReuseIdentifier:kFJChatSystemMessageCellId];
        // tableView 偏移20/64适配
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
        }
    }
    return _tableView;
}

// tableView cellLayouts
- (NSMutableArray *)tableCellLayouts {
    if (!_tableCellLayouts) {
        _tableCellLayouts = [NSMutableArray array];
    }
    return _tableCellLayouts;
}


// 转圈 菊花
- (UIActivityIndicatorView *)indatorView {
    if (!_indatorView) {
        _indatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indatorView.size = CGSizeMake(80.0f, 80.0f);
        _indatorView.center = CGPointMake(self.view.width / 2.0, self.view.height / 2.0);
        _indatorView.backgroundColor = [UIColor colorWithWhite:0.00f alpha:0.670];
        _indatorView.layer.cornerRadius = 6.0f;
        [_indatorView startAnimating];
        _indatorView.clipsToBounds = YES;
    }
    return _indatorView;
}
#pragma mark --- dealloc method
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
