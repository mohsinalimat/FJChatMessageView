//
//  FJPictureBrowserMacro.h
//  FJPhotoBrowserDemo
//
//  Created by fjf on 2017/5/19.
//  Copyright © 2017年 fjf. All rights reserved.
//

#ifndef FJPictureBrowserMacro_h
#define FJPictureBrowserMacro_h


#import <UIKit/UIKit.h>


// 浏览器 图片 间隔
#define kFJPhotoBrowserCellHorizotolSpacing  20.0f

// 默认 图片
#define KFJPhotoBrowserDefaultImage @"default_avatar_geren_134.png"

// 页码 默认 颜色
#define kFJPageControlIndicatorTintColor [UIColor darkGrayColor]

// 页码 选中 颜色
#define kFJPageControlCurrentPageIndicatorTintColor [UIColor whiteColor]

#define currentLanguage [NSLocale preferredLanguages].firstObject
#define LanguagePath    [[NSBundle mainBundle] pathForResource:currentLanguage ofType:@"lproj"]
#define Localized(key)  [[NSBundle bundleWithPath:LanguagePath] localizedStringForKey:(key) value:nil table:@"FJPictureBrowserLocalizable"]

// 显示 模式
typedef NS_ENUM(NSInteger, FJPictureViewShowType){
    // 模仿微博显示
    FJPictureViewShowTypeWeiBo = 0,
    // 模仿微信显示
    FJPictureViewShowTypeWeiXin = 1,
};



#endif /* FJPictureBrowserMacro_h */
