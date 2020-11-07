//
//  XZZGoodsNameAndPriceView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  商品价格和名字
 */
@interface XZZGoodsNameAndPriceView : UIView


/**
 * 商品详情
 */
@property (nonatomic, strong)XZZGoodsDetails * goods;
/**
 * 评分
 */
@property (nonatomic, strong)XZZGoodsScore * score;

/**
 * 刷新页面
 */
@property (nonatomic, strong)GeneralBlock refresh;

/**
 * 刷新数据
 */
@property (nonatomic, strong)GeneralBlock refreshData;

/**
 * 进入活动商品列表
 */
@property (nonatomic, strong)GeneralBlock activityGoodsList;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * priceLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * msrpPriceLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong) UIButton * collectionButton;

@end

NS_ASSUME_NONNULL_END
