//
//  FJChatMessageServer.m
//  FJChatMessageViewDemo
//
//  Created by fjf on 2017/11/10.
//  Copyright © 2017年 fjf. All rights reserved.
//

#import "FJChatMessageModel.h"
#import "FJChatMessageServer.h"

@implementation FJChatMessageServer
// 加载 聊天 数据
+ (void)loadChatMessageWithChatSessionType:(FJChatMessageSessionType)chatSessionType requestCount:(NSInteger)requestCount
                                completion:(FJChatMessageRequestCompletionBlock)completion {
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
    
    for (int i = 0; i < requestCount; i++) {
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
        model.chatMessageSessionType = chatSessionType;
        [resArr addObject:model];
    }
    completion(resArr, YES);
}
@end
