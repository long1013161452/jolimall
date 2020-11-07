//
//  XZZBasicData.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/9.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZBasicData.h"

@implementation XZZBasicData

+ (UIFont *)SellingPriceFont
{
    static UIFont * sellingPriceFont = nil;
    if (!sellingPriceFont) {
        if (ScreenWidth > 375) {
            sellingPriceFont = textFont_bold(16);
        }else{
            sellingPriceFont = textFont_bold(14);
        }
    }
    return sellingPriceFont;
}

/**
 * 字号22  粗体
 */
+ (UIFont *)fontBold22
{
    static UIFont * fontBold22 = nil;
    
    if (!fontBold22) {
        fontBold22 = textFont_bold(22);
    }
    
    return fontBold22;
}
/**
 * 字号20  粗体
 */
+ (UIFont *)fontBold20
{
    static UIFont * fontBold20 = nil;
    
    if (!fontBold20) {
        fontBold20 = textFont_bold(20);
    }
    
    return fontBold20;
}
/**
 * 字号16  粗体
 */
+ (UIFont *)fontBold16
{
    static UIFont * fontBold16 = nil;
    
    if (!fontBold16) {
        fontBold16 = textFont_bold(16);
    }
    
    return fontBold16;
}
/**
 * 字号16
 */
+ (UIFont *)font16
{
    static UIFont * font16 = nil;
    
    if (!font16) {
        font16 = textFont(16);
    }
    
    return font16;
}
/**
 * 字号14  粗体
 */
+ (UIFont *)fontBold14
{
    static UIFont * fontBold14 = nil;
    
    if (!fontBold14) {
        fontBold14 = textFont_bold(14);
    }
    
    return fontBold14;
}
/**
 * 字号14
 */
+ (UIFont *)font14
{
    static UIFont * font14 = nil;
    
    if (!font14) {
        font14 = textFont(14);
    }
    
    return font14;
}
/**
 * 字号12
 */
+ (UIFont *)font12
{
    static UIFont * font12 = nil;
    
    if (!font12) {
        font12 = textFont(12);
    }
    
    return font12;
}
/**
 * 字号10
 */
+ (UIFont *)font10
{
    static UIFont * font10 = nil;
    
    if (!font10) {
        font10 = textFont(10);
    }
    
    return font10;
}
/**
 * 字号8
 */
+ (UIFont *)font8
{
    static UIFont * font8 = nil;
    
    if (!font8) {
        font8 = textFont(8);
    }
    
    return font8;
}


/**
 * 主色  100
 */
+ (UIColor *)mainColor100
{
    static UIColor * mainColor100 = nil;
    
    if (!mainColor100) {
        mainColor100 = kColorWithRGB(215, 62, 62, 1);
    }
    
    return mainColor100;
}
/**
 * 主色  90
 */
+ (UIColor *)mainColor90
{
    static UIColor * mainColor90 = nil;
    
    if (!mainColor90) {
        mainColor90 = kColorWithRGB(215, 62, 62, .9);
    }
    
    return mainColor90;
}
/**
 * 主色  80
 */
+ (UIColor *)mainColor80
{
    static UIColor * mainColor80 = nil;
    
    if (!mainColor80) {
        mainColor80 = kColorWithRGB(215, 62, 62, .8);
    }
    
    return mainColor80;
}
/**
 * 主色  70
 */
+ (UIColor *)mainColor70
{
    static UIColor * mainColor70 = nil;
    
    if (!mainColor70) {
        mainColor70 = kColorWithRGB(215, 62, 62, .7);
    }
    
    return mainColor70;
}
/**
 * 主色  60
 */
+ (UIColor *)mainColor60
{
    static UIColor * mainColor60 = nil;
    
    if (!mainColor60) {
        mainColor60 = kColorWithRGB(215, 62, 62, .6);
    }
    
    return mainColor60;
}
/**
 * 主色  50
 */
+ (UIColor *)mainColor50
{
    static UIColor * mainColor50 = nil;
    
    if (!mainColor50) {
        mainColor50 = kColorWithRGB(215, 62, 62, .5);
    }
    
    return mainColor50;
}
/**
 * 主色  40
 */
+ (UIColor *)mainColor40
{
    static UIColor * mainColor40 = nil;
    
    if (!mainColor40) {
        mainColor40 = kColorWithRGB(215, 62, 62, .4);
    }
    
    return mainColor40;
}
/**
 * 主色  30
 */
+ (UIColor *)mainColor30
{
    static UIColor * mainColor30 = nil;
    
    if (!mainColor30) {
        mainColor30 = kColorWithRGB(215, 62, 62, .3);
    }
    
    return mainColor30;
}
/**
 * 主色  20
 */
+ (UIColor *)mainColor20
{
    static UIColor * mainColor20 = nil;
    
    if (!mainColor20) {
        mainColor20 = kColorWithRGB(215, 62, 62, .2);
    }
    
    return mainColor20;
}
/**
 * 主色  10
 */
+ (UIColor *)mainColor10
{
    static UIColor * mainColor10 = nil;
    
    if (!mainColor10) {
        mainColor10 = kColorWithRGB(215, 62, 62, .1);
    }
    
    return mainColor10;
}
/**
 * 辅色
 */
+ (UIColor *)complementaryColor
{
    static UIColor * complementaryColor = nil;
    
    if (!complementaryColor) {
        complementaryColor = kColor(0xff8a44);
    }
    
    return complementaryColor;
}
/**
 * 重要色
 */
+ (UIColor *)importantColor
{
    static UIColor * importantColor = nil;
    
    if (!importantColor) {
        importantColor = kColor(0x191919);
    }
    
    return importantColor;
}
/**
 * 一般色  666666
 */
+ (UIColor *)generalColor666666
{
    static UIColor * generalColor666666 = nil;
    
    if (!generalColor666666) {
        generalColor666666 = kColor(0x666666);
    }
    
    return generalColor666666;
}
/**
 * 一般色  999999
 */
+ (UIColor *)generalColor999999
{
    static UIColor * generalColor999999 = nil;
    
    if (!generalColor999999) {
        generalColor999999 = kColor(0x999999);
    }
    
    return generalColor999999;
}
/**
 * 一般色  cccccc
 */
+ (UIColor *)generalColorCCCCCC
{
    static UIColor * generalColorCCCCCC = nil;
    
    if (!generalColorCCCCCC) {
        generalColorCCCCCC = kColor(0xcccccc);
    }
    
    return generalColorCCCCCC;
}
/**
 * 其他色  f8f8f8
 */
+ (UIColor *)otherColorF8F8F8
{
    static UIColor * otherColorF8F8F8 = nil;
    
    if (!otherColorF8F8F8) {
        otherColorF8F8F8 = kColor(0xf8f8f8);
    }
    
    return otherColorF8F8F8;
}
/**
 * 其他色  ffffff
 */
+ (UIColor *)otherColorFFFFFF
{
    static UIColor * otherColorFFFFFF = nil;
    
    if (!otherColorFFFFFF) {
        otherColorFFFFFF = kColor(0xffffff);
    }
    
    return otherColorFFFFFF;
}

@end
