//
//  XZZAddCartAndBuyNewView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/9.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZZChooseColorAndSizeView.h"
#import "XZZAddCartAndBuyNewButtonView.h"
#import "XZZGoodsDetails.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectedColor)(XZZColor * color);
typedef void(^SelectedSize)(XZZSize * size);

/**
 *  弹出加购框
 */
@interface XZZAddCartAndBuyNewView : UIView


/**
 * 数量
 */
@property (nonatomic, strong)UILabel * numLabel;

/**
 * 商品信息
 */
@property (nonatomic, weak)XZZGoodsDetails * goods;

/**
 * 选中的sku
 */
@property (nonatomic, strong)XZZSku * selectedSku;

/**
 * 选中颜色
 */
@property (nonatomic, strong)SelectedColor selectedColor;
/**
 * 选中尺寸
 */
@property (nonatomic, strong)SelectedSize selectedSize;
/**
 * 查看尺寸介绍
 */
@property (nonatomic, strong)GeneralBlock sizeGuide;

/**
 * 按钮类型
 */
@property (nonatomic, assign)XZZAddCartAndBuyNewButtonType buttonType;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewButtonView * addCartAndBuyButtonView;

/**
 * 加购
 */
@property (nonatomic, strong)GeneralBlock addToCart;
/**
 * 购买
 */
@property (nonatomic, strong)GeneralBlock  buyNew;
/**
 * 进入购物车
 */
@property (nonatomic, strong)GeneralBlock goCart;
/**
 *  选中的颜色尺码
 */
- (void)selectedColor:(XZZColor *)color size:(XZZSize *)size;
/**
 *  加购和购买  用于修改y按钮颜色
 */
- (void)whetherCanAddShoppingCartAndBuy:(BOOL)is;

/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView;

/**
 * 移除视图
 */
- (void)removeView;

@end



NS_ASSUME_NONNULL_END
