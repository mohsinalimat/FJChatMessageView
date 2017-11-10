//
//  FaceHelper.m
//  mblove
//
//  Created by youq on 12-3-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "FJEmojiHelper.h"

@implementation FJEmojiHelper

- (instancetype)init{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"faces" ofType:@"plist"];
        faceDict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        for (int i=0; i<faceDict.count; i++) {
            NSString *key = [[faceDict allKeys] objectAtIndex:i];
            NSString *value = [[faceDict allValues] objectAtIndex:i];
            [tempDic setObject:key forKey:value];
        }
        [faceDict addEntriesFromDictionary:tempDic];
    }
	return self;
}

- (BOOL)stringIsFace:(NSString *)string
{
    if ([faceDict objectForKey:string]) {
        return YES;
    }
    return NO;
}



+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static FJEmojiHelper *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FJEmojiHelper alloc] init];
    });
    return sharedInstance;
}

- (NSString*)emojiWithIndex:(NSInteger)index {
    //eg:   0->emoji
    NSString *strEmoji = [faceDict objectForKey:[NSString stringWithFormat:@"{%02ld}",index]];
    return strEmoji;
}

- (NSString*)indexStrFromEmoji:(NSString*)str {
//    str = @"32jkuilao😔黑社会😊😔👿👀💩🐷😔😭😔😁😔32jkuilaoweao公司";//for test
    //eg:   emoji->{00}
	NSMutableString *resultStr = [[NSMutableString alloc] init];
	for (int i=0; i<str.length; i++) {
		NSString *ch = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *matchResult = [faceDict objectForKey:ch];
        if (!matchResult) {
            if (i+2 <= str.length) {
                NSString *chTemp = [str substringWithRange:NSMakeRange(i, 2)];
                matchResult = [faceDict objectForKey:chTemp];
                if (matchResult) {
                    i++;
                    ch = chTemp;
                }
            }
        }
        if (matchResult) {//一个字符的情况
            ch = matchResult;
        }
		[resultStr appendString:ch];
	}
     return  [resultStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString*)emojiFromIndexStr:(NSString*)str {
    //eg:   {00}->emoji
	NSUInteger length = str.length;
	NSMutableString *resultStr = [[NSMutableString alloc] init];
	for (int i=0; i<length; i++) {
		NSString *ch = [str substringWithRange:NSMakeRange(i,1)];
		if ([ch isEqualToString:@"{"] && i<length-3) {
			NSString *nextCh = [str substringWithRange:NSMakeRange(i+3,1)];
			if ([nextCh isEqualToString:@"}"]) {
				NSString *matchResult = [faceDict valueForKey:[str substringWithRange:NSMakeRange(i, 4)]];
				if (matchResult) {
					ch = matchResult;
					i += 3;
				}
			}
		}
		[resultStr appendString:ch];
	}
	return resultStr;
}


//点击表情
- (NSString *)textWithEmojiTag:(NSInteger)emojiTag originText:(NSString *)originText {
    NSString *emoji = [self emojiWithIndex:emojiTag];
    self.oneEmojiLength = [emoji length];
    NSString *strEmoji = nil;
    _clickedEmoji = YES;
    if ([originText length] > 0) {
        if (_selectedLocation < [originText length]) {//选择中间位置插入表情
            if (_selectedLocation <= 0) {
                _selectedLocation = 0;
            }
            strEmoji = [[NSString alloc] initWithFormat:@"%@%@%@", [originText substringToIndex:_selectedLocation], emoji, [originText substringFromIndex:_selectedLocation]];
        }else{
            strEmoji = [[NSString alloc] initWithFormat:@"%@%@", originText, emoji];
        }
    }else{
        strEmoji = emoji;
    }
    return strEmoji;
}

// 更新 文本 位置
- (void)updateSelectLocationWithTextLocation:(NSInteger)textLocation {
    if (self.clickedEmoji) {
        self.selectedLocation += self.oneEmojiLength;
    }
    else {
        self.selectedLocation = textLocation;
    }
    self.clickedEmoji = NO;
}

// 删除一个表情或者文本
- (NSString *)deletedTextWithOriginText:(NSString *)originText {
    NSString *chatText = originText;
    if (chatText.length >= 2){
        if (_selectedLocation >= 2) {
            if ([self stringIsFace:[chatText substringWithRange:NSMakeRange(_selectedLocation-2, 2)]]) {
                originText = [NSString stringWithFormat:@"%@%@", [chatText substringToIndex:_selectedLocation-2], [chatText substringFromIndex:_selectedLocation]];
                return originText;
            }
        }
    }
    if (chatText.length > 0) {
        if (_selectedLocation >= 1) {
            originText = [NSString stringWithFormat:@"%@%@", [chatText substringToIndex:_selectedLocation-1], [chatText substringFromIndex:_selectedLocation]];
        }
    }
    return originText;
}

@end















