//
//  XZZChooseColorAndSizeView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/9.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XZZColor, XZZSize;


NS_ASSUME_NONNULL_BEGIN
/**
 *  选中商品颜色尺码信息
 */
@interface XZZChooseColorAndSizeView : UIView


/**
 * 颜色信息
 */
@property (nonatomic, strong)NSArray<XZZColor *> * colorArray;

/**
 * 尺码信息
 */
@property (nonatomic, strong)NSArray<XZZSize *> * sizeArray;
/**
 *  选中的颜色尺码
 */
- (void)selectedColor:(XZZColor *)color selectedSize:(XZZSize *)size;


@end

NS_ASSUME_NONNULL_END
