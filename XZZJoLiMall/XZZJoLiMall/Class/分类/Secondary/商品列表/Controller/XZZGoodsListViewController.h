//
//  XZZGoodsListViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZMainViewController.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  商品列表
 */
@interface XZZGoodsListViewController : XZZMainViewController

/**
 * 分类
 */
@property (nonatomic, strong)XZZRequestCategoryGoods * categoryGoods;



/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * activityId;
/**
 * 是否是首页进入
 */
@property (nonatomic, assign)BOOL isHomePage;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * couponsId;


@end

NS_ASSUME_NONNULL_END
