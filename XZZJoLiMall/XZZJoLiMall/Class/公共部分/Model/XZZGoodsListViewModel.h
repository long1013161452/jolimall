//
//  XZZGoodsListViewModel.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/2.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZGoodsListViewModel : NSObject<UITableViewDelegate, UITableViewDataSource, XZZMyDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * goodsArray;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * tableHeardArray;

/**
 * <#expression#>
 */
@property (nonatomic, assign)int goods_list_count;
/**
 * <#expression#>
 */
@property (nonatomic, weak)UIViewController * VC;

/**
 * 隐藏展示空
 */
@property (nonatomic, assign)BOOL hideEmpty;

/**
 * 用于刷新
 */
@property (nonatomic, strong)GeneralBlock reloadData;

/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL cartHidden;

/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL collectionHidden;
/**
 * 展示商品信息   优惠信息  活动信息   什么都不展示
 */
@property (nonatomic, assign)XZZGoodsViewDisplayAngle goodsViewDisplay;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIColor * cellBackColor;

@end

NS_ASSUME_NONNULL_END
