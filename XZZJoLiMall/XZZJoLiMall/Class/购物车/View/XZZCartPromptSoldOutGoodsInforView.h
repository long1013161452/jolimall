//
//  XZZCartPromptSoldOutGoodsInforView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/7.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^RemoveSoldOutSku)(NSArray * list);

@interface XZZCartPromptSoldOutGoodsInforView : UIView


/**
 * 下架商品集合
 */
@property (nonatomic, strong)NSArray * soldOutSkuArray;

/**
 * 移除视图
 */
@property (nonatomic, strong)GeneralBlock block;

/**
 * 是否显示下发按钮
 */
@property (nonatomic, assign)BOOL showButton;

/**
 * 删除下架商品信息
 */
@property (nonatomic, strong)RemoveSoldOutSku removeSoldOutSku;

/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView;

/**
 * 移除视图
 */
- (void)removeView;


@end

NS_ASSUME_NONNULL_END
