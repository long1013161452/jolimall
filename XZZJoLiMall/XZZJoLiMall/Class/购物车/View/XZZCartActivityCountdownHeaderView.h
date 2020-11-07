//
//  XZZCartActivityCountdownHeaderView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/6.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

/** 查看活动商品信息*/
typedef void(^ViewActivityGoodsInforBlock)(XZZActivityInfor * activity);

/**
 * 购物车 活动倒计时
 */
@interface XZZCartActivityCountdownHeaderView : UIView


/**
 * 查看活动商品信息
 */
@property (nonatomic, strong)ViewActivityGoodsInforBlock viewActivityGoodsInfor;

/**
 * 活动或者秒杀信息
 */
@property (nonatomic, strong)id activityOrSecKillInfor;
/**
 * 刷新   倒计时结束时调用
 */
@property (nonatomic, strong)GeneralBlock refreshBlock;

@end

NS_ASSUME_NONNULL_END
