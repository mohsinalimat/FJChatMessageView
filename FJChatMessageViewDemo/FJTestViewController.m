
//
//  FJTestViewController.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/28.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJTestViewController.h"
#import "FJChatMessageViewController.h"

@interface FJTestViewController ()

@end

@implementation FJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *tmpButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    tmpButton.backgroundColor = [UIColor redColor];
    [tmpButton addTarget:self action:@selector(tmpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tmpButton];
}

- (void)tmpButtonClicked:(UIButton *)sender {
    FJChatMessageViewController *chatMessageViewControls = [[FJChatMessageViewController alloc] init];
    [self.navigationController pushViewController:chatMessageViewControls animated:YES];
}

@end
