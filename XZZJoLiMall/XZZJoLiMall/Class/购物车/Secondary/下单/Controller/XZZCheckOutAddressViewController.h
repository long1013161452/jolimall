//
//  XZZCheckOutAddressViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/19.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  填写地址信息  下单
 */
@interface XZZCheckOutAddressViewController : XZZMainViewController

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
