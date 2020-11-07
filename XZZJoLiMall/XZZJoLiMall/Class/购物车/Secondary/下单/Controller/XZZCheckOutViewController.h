//
//  XZZCheckOutViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZMainViewController.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  下单
 */
@interface XZZCheckOutViewController : XZZMainViewController<XZZMyDelegate>

/**
 * 要下单商品数组
 */
@property (nonatomic, strong)NSArray<XZZCartInfor *> * cartInforArray;


/**
 * 是否是立即购买
 */
@property (nonatomic, assign)BOOL isBuyNow;

@end

NS_ASSUME_NONNULL_END
