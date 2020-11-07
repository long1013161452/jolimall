//
//  XZZSecondsKillView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/26.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZSecondsKillSession.h"

NS_ASSUME_NONNULL_BEGIN

/** 秒杀*/
@interface XZZSecondsKillView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZSecondsKillSession * secondsKill;


/**
 * <#expression#>
 */
@property (nonatomic, assign)CGFloat indicatorcenterX;

/**
 * <#expression#>
 */
@property (nonatomic, assign)XZZSecondsKillState state;


@end

NS_ASSUME_NONNULL_END
