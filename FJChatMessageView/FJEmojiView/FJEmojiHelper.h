//
//  FaceHelper.h
//  mblove
//
//  Created by youq on 12-3-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FJEmojiHelper : NSObject {
    NSMutableDictionary *faceDict;
}


// 表情 长度
@property (nonatomic, assign) NSInteger oneEmojiLength;


// 选择 位置
@property (nonatomic, assign) NSInteger selectedLocation;


// 是否 点击 表情
@property (nonatomic, getter=isClickedEmoji,assign) BOOL clickedEmoji;

/*必须调用该单例初始化方法，不能直接alloc init*/
+ (instancetype)sharedInstance;

//是否是表情
- (BOOL)stringIsFace:(NSString *)string;

//根据表情编号，返回emoji表情 (用于输入框中，用户选择表情后，根据选择的编号，在输入框中显示emoji)
- (NSString*)emojiWithIndex:(NSInteger)index;

/*
 以下的方法回在XmppClient类中调用，上层不需要再处理
 */

//根据emoji，找到对应的编号，以{##}的格式返回 (用于在发送之前，转换)
- (NSString*)indexStrFromEmoji:(NSString*)str;

//根据{##},找到相应的emoji表情返回 (用于接收到msg之后，转换成emoji)
- (NSString*)emojiFromIndexStr:(NSString*)str;

// 删除一个表情或者文本
- (NSString *)deletedTextWithOriginText:(NSString *)originText;

// 更新 文本 位置
- (void)updateSelectLocationWithTextLocation:(NSInteger)textLocation;

//点击表情
- (NSString *)textWithEmojiTag:(NSInteger)emojiTag originText:(NSString *)originText;
@end
