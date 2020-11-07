//
//  XZZOrderSku.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/1.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZOrderSku : NSObject

/**
 *  integer($int64)颜色
 */
@property (nonatomic, strong)NSString * color;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * colorName;
/**
 *   integer($int64)商品名称
 */
@property (nonatomic, strong)NSString * goodsTitle ;
/**
 * goodsCode
 */
@property (nonatomic, strong)NSString * goodsCode;
/**
 *  integer($int64)图片
 */
@property (nonatomic, strong)NSString * image;

/**
 *  integer($int64)图片
 */
@property (nonatomic, strong)NSString * imageTwo;

/**
 *  integer($int64)订单号
 */
@property (nonatomic, strong)NSString * orderId ;

/**
 *  integer($int64)折后价
 */
@property (nonatomic, assign)CGFloat price ;
/**
 * 是否评论 0 : 未评论； 1 已评论
 */
@property (nonatomic, assign)int isComment;

/**
 *  integer($int32)sku数量
 */
@property (nonatomic, strong)NSString * quantity ;

/**
 *  integer($int64)尺码
 */
@property (nonatomic, strong)NSString * size ;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * shortSizeCode;

/**
 *  integer($int64)skuId
 */
@property (nonatomic, strong)NSString * skuId ;
/**
 * integer($int32)订单状态 0:下架 1：上架
 */
@property (nonatomic, strong)NSString * status ;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * goodsId;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * commentId;

/**
 * 是不是赠送商品
 */
@property (nonatomic, assign)BOOL isGiftGoods;

@end

NS_ASSUME_NONNULL_END
