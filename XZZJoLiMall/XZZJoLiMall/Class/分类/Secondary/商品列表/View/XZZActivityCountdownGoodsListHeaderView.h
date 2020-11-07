//
//  XZZActivityCountdownGoodsListHeaderView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/6.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZZActivityInfor.h"

NS_ASSUME_NONNULL_BEGIN

/** 活动倒计时商品区头*/
@interface XZZActivityCountdownGoodsListHeaderView : UIView

//
///**
// * 刷新UI
// */
//@property (nonatomic, strong)GeneralBlock refreshUI;
/**
 * 刷新数据
 */
@property (nonatomic, strong)GeneralBlock refreshBlock;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZActivityInfor * activityInfor;

@end

NS_ASSUME_NONNULL_END
