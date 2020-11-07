//
//  XZZGoodsColorAndSizeView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/22.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChooseColor)(XZZColor * color);

typedef void(^ChooseSize)(XZZSize * size);


@interface XZZGoodsColorAndSizeView : UIView

/**
 * 商品详情
 */
@property (nonatomic, strong)XZZGoodsDetails * goods;

/**
 * <#expression#>
 */
@property (nonatomic, strong)ChooseColor chooseColor;
/**
 * <#expression#>
 */
@property (nonatomic, strong)ChooseSize chooseSize;

/**
 * 刷新
 */
@property (nonatomic, strong)GeneralBlock refresh;

/**
 * 立即购买
 */
@property (nonatomic, strong)GeneralBlock buyNew;

/**
 * 加购
 */
@property (nonatomic, strong)GeneralBlock addToCart;

/**
 * size guide
 */
@property (nonatomic, strong)GeneralBlock sizeGuide;

/**
 * 选中优惠券
 */
@property (nonatomic, strong)GeneralBlock couponsBack;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * numLabel;

/**
 * 优惠券
 */
@property (nonatomic, strong)UIButton * couponsButton;
/**
 *  提示选中尺码或颜色
 */
- (void)promptsSelectColorOrSize;





@end

NS_ASSUME_NONNULL_END
