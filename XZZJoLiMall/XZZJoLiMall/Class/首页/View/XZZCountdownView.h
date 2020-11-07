//
//  XZZCountdownView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZZHomeTemplateView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  倒计时   两排商品
 */
@interface XZZCountdownView : XZZHomeTemplateView

/**
 * 商品信息
 */
@property (nonatomic, strong)NSArray * goodsArray;

@end

NS_ASSUME_NONNULL_END
