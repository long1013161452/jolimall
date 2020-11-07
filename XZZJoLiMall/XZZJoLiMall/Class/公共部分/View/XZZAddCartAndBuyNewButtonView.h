//
//  XZZAddCartAndBuyNewButtonView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/27.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, XZZAddCartAndBuyNewButtonType) {
    XZZAddCartAndBuyNewButtonTypeNone,//普通
    XZZAddCartAndBuyNewButtonTypeAddToCart, //只有加购
    XZZAddCartAndBuyNewButtonTypeBuyNow //只有购买
};




@interface XZZAddCartAndBuyNewButtonView : UIView


/**
 * 按钮类型
 */
@property (nonatomic, assign)XZZAddCartAndBuyNewButtonType buttonType;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock buyNew;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock addToCart;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock goShopingCart;



/**
 * 购物车数量
 */
@property (nonatomic, strong)UILabel * cartNumLabel;

/**
 * 购物车按钮
 */
@property (nonatomic, strong)UIButton * cartButton;

/**
 * 加购按钮
 */
@property (nonatomic, strong)UIButton * addToCartButton;
/**
 * 加购按钮   全部
 */
@property (nonatomic, strong)UIButton * addToCartTwoButton;

/**
 * 购买按钮
 */
@property (nonatomic, strong)UIButton * buyNewButton;
/**
 * 购买按钮  全部
 */
@property (nonatomic, strong)UIButton * buyNewTwoButton;

/**
 *  加购和购买  用于修改y按钮颜色
 */
- (void)whetherCanAddShoppingCartAndBuy:(BOOL)is;

@end

NS_ASSUME_NONNULL_END
