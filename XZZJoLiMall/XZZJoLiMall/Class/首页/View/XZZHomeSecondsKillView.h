//
//  XZZHomeSecondsKillView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/25.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZHomeTemplateView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 首页   秒杀
 */
@interface XZZHomeSecondsKillView : XZZHomeTemplateView

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * endTime;

/**
 * <#expression#>
 */
@property (nonatomic, assign)XZZSecondsKillState state;

/**
 * 商品信息
 */
@property (nonatomic, strong)NSArray * goodsArray;

@end

NS_ASSUME_NONNULL_END
