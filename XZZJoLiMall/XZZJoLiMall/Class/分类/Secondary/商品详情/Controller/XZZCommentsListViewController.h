//
//  XZZCommentsListViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/21.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZGoodsScore.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZZCommentsListViewController : XZZMainViewController

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * goodsId;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZGoodsScore * goodsScore;

@end

NS_ASSUME_NONNULL_END
