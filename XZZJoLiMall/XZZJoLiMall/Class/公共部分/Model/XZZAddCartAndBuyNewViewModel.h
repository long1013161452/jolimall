//
//  XZZAddCartAndBuyNewViewModel.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/9.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZZAddCartAndBuyNewView.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  弹出加购框的逻辑处理
 */
@interface XZZAddCartAndBuyNewViewModel : NSObject

/**
 * 商品id
 */
@property (nonatomic, strong)NSString * goodsId;

/**
 * <#expression#>
 */
@property (nonatomic, weak)UIViewController * VC;


///**
// * <#expression#>
// */
//@property (nonatomic, strong)GeneralBlock addToCart;
///**
// * <#expression#>
// */
//@property (nonatomic, strong)GeneralBlock goToCart;
///**
// * <#expression#>
// */
//@property (nonatomic, strong)GeneralBlock collectResults;
/**
 * 弹出视图
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewView * addCartAndBuyNewView;

@end

NS_ASSUME_NONNULL_END
