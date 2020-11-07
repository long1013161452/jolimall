//
//  XZZCountdownGoodsView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/8.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZCountdownGoodsView : UIView

/**
 *  计算高度信息
 */
+ (CGFloat)getHeight:(CGFloat)width;
/**
 *  计算宽度信息
 */
+ (CGFloat)getWidth:(CGFloat)height;

/**
 * 商品信息
 */
@property (nonatomic, strong)id goods;

/**
 * 售价
 */
@property (nonatomic, strong)UILabel * priceLabel;

@end

/**
 * 秒杀
 */
@interface XZZSecKillGoodsView : UIView

/**
 *  计算高度信息
 */
+ (CGFloat)getHeight:(CGFloat)width;
/**
 *  计算宽度信息
 */
+ (CGFloat)getWidth:(CGFloat)height;

/**
 * 商品信息
 */
@property (nonatomic, strong)id goods;

/**
 * 售价
 */
@property (nonatomic, strong)UILabel * priceLabel;

@end





NS_ASSUME_NONNULL_END
