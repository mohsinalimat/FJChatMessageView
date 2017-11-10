//
//  NSString+Extention.m
//  资讯平台
//
//  Created by summer on 15/9/2.
//  Copyright (c) 2015年 Qingning Science & Technology Development Co.,Ltd. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)


// 根据 字体 和 宽高 返回 字符串 宽高
- (CGSize)qn_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    if ([self length] > 0) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        NSDictionary *attrs = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName:style };
        return [self boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:attrs context:nil].size;
    } else {
        return CGSizeZero;
    }
}

// 根据 限定 宽度 和 字体大小 返回 宽高
- (CGSize)qn_sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize {
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return [self qn_sizeWithFont:font maxSize:maxSize];
}


// 根据 限定 宽度 和 字体 返回 宽高
- (CGSize)qn_sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    if ([self length] > 0) {
        return [self qn_sizeWithFont:font maxSize:CGSizeMake(maxW, MAXFLOAT)];
    }else{
        return CGSizeZero;
    }
}


// 根据 限定 高度 和 字体 返回 宽高
- (CGSize)qn_sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH {
    if ([self length] > 0) {
        NSDictionary *attrs = @{NSFontAttributeName : font};
        return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, maxH) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    }else{
        return CGSizeZero;
    }
}

// 根据 字体 大小 返回 宽高
- (CGSize)qn_sizeWithFontSize:(CGFloat)fontSize {
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return [self qn_sizeWithFont:font maxW:MAXFLOAT];
}

// 根据 字体 返回 宽高
- (CGSize)qn_sizeWithFont:(UIFont *)font {
    return [self qn_sizeWithFont:font maxW:MAXFLOAT];
}

@end

