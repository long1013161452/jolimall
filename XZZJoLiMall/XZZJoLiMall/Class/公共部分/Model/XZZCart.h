//
//  XZZCart.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZZActivityInfor.h"

/**
 *  购物车信息
 */
@interface XZZCartInfor : NSObject

/**
 * 活动信息
 */
@property (nonatomic, strong)XZZActivityInfor * activityVo;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZSecKillVo * secKillVo;
/**
 * 商品code
 */
@property (nonatomic, strong)NSString * goodsCode;
/**
 * sku code
 */
@property (nonatomic, strong)NSString * code;//    string
/**
 * 颜色code
 */
@property (nonatomic, strong)NSString * colorCode;//    string

/**
 *
 颜色名称
 */
@property (nonatomic, strong)NSString * colorName;//    string



/**
 * 商品标题
 */
@property (nonatomic, strong)NSString * goodsTitle;//    string


/**
 * sku主键Id
 */
@property (nonatomic, strong)NSString * ID ;//   integer($int64)


/**
 * sku颜色主图
 */
@property (nonatomic, strong)NSString * mainPicture;//    string


/**
 * 尺码code，即前台展示尺码
 */
@property (nonatomic, strong)NSString * sizeCode  ;//  string

/**
 * shortSizeCode  展示的缩减尺码
 */
@property (nonatomic, strong)NSString * shortSizeCode;
/**
 * 尺码名称，即后台展示尺码
 */
@property (nonatomic, strong)NSString * sizeName ;//   string


/**
 * SKU数量
 */
@property (nonatomic, assign)NSInteger skuNum ;//   integer($int32)


/**
 * sku价格
 */
@property (nonatomic, assign)CGFloat skuPrice ;//   number
/**
 * 原价
 */
@property (nonatomic, assign)CGFloat skuNominalPrice;

/**
 * sku上下架状态 0:下架 1：上架
 */
@property (nonatomic, assign)NSInteger status;//    integer($int32)
/**
 * 库存信息
 */
@property (nonatomic, strong)NSNumber * stock;
/**
 * sku颜色副图，用英文的 ; 分开
 */
@property (nonatomic, strong)NSString * subPictures;//   string
/**
 * 商品id
 */
@property (nonatomic, strong)NSString * goodsId;

/**
 * 重量
 */
@property (nonatomic, assign)int weight;


+ (id)cartInforWithSku:(XZZSku *)sku  num:(NSInteger)num;

@end



