//
//  XZZGoodsList.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/21.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  列表 商品
 */
@interface XZZGoodsList : NSObject

/**
 * 活动信息
 */
@property (nonatomic, strong)XZZActivityInfor * activityVo;
/**
 * 商品code
 */
@property (nonatomic, strong)NSString * code;
/**
 * 售价
 */
@property (nonatomic, assign)CGFloat currentPrice;
/**
 * 折扣价格
 */
@property (nonatomic, assign)CGFloat discountPrice;
/**
 * 折扣
 */
@property (nonatomic, assign)CGFloat discountPercent;

/**
 * 虚价
 */
@property (nonatomic, assign)CGFloat nominalPrice;
/**
 * 商品id
 */
@property (nonatomic, strong)NSString * goodsId;
/**
 * s销售数量
 */
@property (nonatomic, assign)NSInteger salesNum;
/**
 * 商品主图
 */
@property (nonatomic, strong)NSString * pictureUrl;


/**
 * 商品标题
 */
@property (nonatomic, strong)NSString * title;

/**
 * 状态
 */
@property (nonatomic, strong)NSString * status;
/**
 * 是否有库存
 */
@property (nonatomic, strong)NSString * isExistStock;

/**
 * 展示折扣信息   NO隐藏   yes展示
 */
@property (nonatomic, assign)BOOL cornerMark;
/**
 * 展示折扣比例
 */
@property (nonatomic, assign)int cornerMarkValue;

@end

NS_ASSUME_NONNULL_END
