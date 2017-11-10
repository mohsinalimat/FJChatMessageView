//
//  NSString+Extention.h
//  资讯平台
//
//  Created by summer on 15/9/2.
//  Copyright (c) 2015年 Qingning Science & Technology Development Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extention)


// 根据 字体 和 宽高 返回 字符串 宽高
- (CGSize)qn_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

// 根据 限定 宽度 和 字体大小 返回 宽高
- (CGSize)qn_sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize;

// 根据 限定 宽度 和 字体 返回 宽高
- (CGSize)qn_sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

// 根据 限定 高度 和 字体 返回 宽高
- (CGSize)qn_sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH;

// 根据 字体 大小 返回 宽高
- (CGSize)qn_sizeWithFontSize:(CGFloat)fontSize;

// 根据 字体 返回 宽高
- (CGSize)qn_sizeWithFont:(UIFont *)font;


@end

