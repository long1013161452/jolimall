//
//  XZZGoodsScoreView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZZGoodsScore.h"
NS_ASSUME_NONNULL_BEGIN

/**
 *  商品评分信息
 */
@interface XZZGoodsScoreView : UIView

/**
 * 评分
 */
@property (nonatomic, strong)XZZGoodsScore * score;

/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL hiddenViewAll;

/**
 * 代理
 */
@property (nonatomic, strong)GeneralBlock viewAll;

@end

NS_ASSUME_NONNULL_END

