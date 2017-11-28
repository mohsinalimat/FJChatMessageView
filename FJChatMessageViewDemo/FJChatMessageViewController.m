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
#import "FJChatMessageViewModel.h"
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

@interface FJChatMessageViewController ()<FJChatToolViewDelegate>
// tableView
@property (nonatomic, strong) UITableView *tableView;
// 转圈
@property (nonatomic, strong) UIActivityIndicatorView *indatorView;
// 表情图
@property (nonatomic, strong) FJChatEmojiView *chatEmojiView;
// 聊天框
@property (nonatomic, strong) FJChatToolView *chatToolView;
// viewModel
@property (nonatomic, strong) FJChatMessageViewModel *chatMessageViewModel;
// 会话类型
@property (nonatomic, assign, readonly) FJChatMessageSessionType chatSessionType;
@end

@implementation FJChatMessageViewController


#pragma mark --------------- Init Methods

- (instancetype)initWithChatSessionType:(FJChatMessageSessionType)chatSessionType {
    if (self = [super init]) {
        _chatSessionType = chatSessionType;
    }
    return self;
}
#pragma mark --- life circle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _chatSessionType = FJChatMessageSessionTypeGroup;
    [self setupGestures];
    [self setupViewControls];
    [self setupNetworkRequest];
    [self addKeyboardNotiObserver];
    [self layoutViewControllerSubviews];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
    });
}




#pragma mark --- custom delegate
// 表情 / 键盘 切换
- (void)chatToolView:(FJChatToolView *)chatToolView showType:(FJChatToolBarShowingView)showType {
    // 表情
    if (showType == FJChatToolBarShowingFaceView) {
        self.chatEmojiView.showChatEmojiView = YES;
        self.chatToolView.textView.inputView = self.chatEmojiView;
        self.chatToolView.textView.extraAccessoryViewHeight = [FJChatEmojiView getChatEmojiViewHeight];
        [self.chatToolView.textView reloadInputViews];
        [self.chatToolView.textView becomeFirstResponder];
    }
    // 键盘
    else if(showType == FJChatToolBarShowingKeyboard){
        self.chatToolView.textView.inputView = nil;
        self.chatEmojiView.showChatEmojiView = NO;
        [self.chatToolView.textView reloadInputViews];
        [self.chatToolView.textView becomeFirstResponder];
    }
    // 点击 空白 区域
    else if (showType == FJChatToolBarShowingNoneView) {
        self.chatEmojiView.showChatEmojiView = NO;
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

#pragma mark --------------- Response Event

- (void)handleTapAction:(UITapGestureRecognizer *)tap {
    
    [self.view endEditing:YES];
    [self chatToolView:self.chatToolView showType:FJChatToolBarShowingNoneView];
    
}


#pragma mark --------------- Private Methods
// 设置 子控件
- (void)setupViewControls {
    self.navigationItem.title = @"林大鹏";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatToolView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.chatEmojiView.backgroundColor = [UIColor colorWithCustomType:AppColorTypeFontA];
}

// 设置 网络 请求
- (void)setupNetworkRequest {
    __weak typeof(self) weakSelf = self;
    [self.chatMessageViewModel loadChatMessageWithRequestCount:50 completion:^(BOOL isSuccess) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.indatorView stopAnimating];
        [strongSelf.tableView reloadData];
        [strongSelf scrollBottom:NO];
    }];
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
        make.height.mas_equalTo([FJChatToolView getChatToolViewHeight]);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


// 添加 键盘 通知 监听
- (void)addKeyboardNotiObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboard:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

// 发送 聊天 信息
- (void)sendChatMessage:(NSString *)chatMessage {
    chatMessage = [chatMessage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    chatMessage = [[FJEmojiHelper sharedInstance] indexStrFromEmoji:chatMessage];
    FJChatMessageModel *chatMessageModel = [[FJChatMessageModel alloc] initWithContent:chatMessage state:FJChatMessageStateSending owner:FJChatMessageOwnerSelf];
    [self.chatMessageViewModel sendMessage:chatMessageModel];
    [self.chatToolView clearTextView];
    [self.tableView reloadData];
    [self scrollBottom:NO];
}


- (void)scrollBottom:(BOOL)animated {
    if (self.chatMessageViewModel.tableCellLayouts.count >= 1) {
        [self.tableView scrollToBottomAnimated:animated];
    }
}

// 处理 相关 view
- (void)handleChatToolInfoViewWhenScroll {
    if ([self.chatToolView isShowFootView] || self.chatEmojiView.isShowChatEmojiView) {
        [self handleTapAction:nil];
    }
}


#pragma mark --------------- Getter / Setter
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
        _chatEmojiView = [[FJChatEmojiView alloc] initWithFrame:CGRectMake(0, self.view.height - [FJChatEmojiView getChatEmojiViewHeight], self.view.width, [FJChatEmojiView getChatEmojiViewHeight])];
        
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
        _tableView.delegate = self.chatMessageViewModel;
        _tableView.dataSource = self.chatMessageViewModel;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = [UIColor colorWithCustomType:AppColorTypeD];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [FJChatToolView getChatToolViewHeight])];
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

// 聊天 viewModel
- (FJChatMessageViewModel *)chatMessageViewModel {
    if (!_chatMessageViewModel) {
        _chatMessageViewModel = [[FJChatMessageViewModel alloc] initWithChatSessionType:_chatSessionType];
        
        __weak typeof(self) weakSelf = self;
        _chatMessageViewModel.scrollBlock = ^(UIScrollView * _Nullable scrollView) {
            [weakSelf handleChatToolInfoViewWhenScroll];
        };
    }
    return _chatMessageViewModel;
}


@end
