//
//  XZZCouponsInfor.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/1.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@class XZZCouponsInfor, XZZGoodsList;
@interface XZZGoodsDetailCoupon : NSObject


/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray<XZZCouponsInfor *> * couponVos;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * couponId;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * prompt;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * recommendType;

@end








@interface XZZCouponsInfor : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * ID;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * couponId;
/**
 * 优惠金额
 */
@property (nonatomic, assign)CGFloat couponDiscount;
/**
 * code
 */
@property (nonatomic, strong)NSString * code ;//   string
/**
 * 折扣金额
 */
@property (nonatomic, strong)NSString * discountMoney ;//   string
/**
 * 折扣比例
 */
@property (nonatomic, strong)NSString * discountPercent ;//   string
/**
 * 结束时间
 */
@property (nonatomic, strong)NSString * endTime ;//   string($date-time)
/**
 * 结束天数
 */
@property (nonatomic, strong)NSString * expireDays ;//   integer($int32)
/**
 * 0表示不可使用 1表示可以使用
 */
@property (nonatomic, assign)BOOL orderCanUse;
/**
 * 用户是否拥有
 */
@property (nonatomic, assign)BOOL isReceived;
/**
 * 是否是全场可用  x
 */
@property (nonatomic, assign)BOOL limitIsAll;
/**
 * 是否是全场可用  y
 */
@property (nonatomic, assign)BOOL recommendIsAll;
/**
 * 参数
 */
@property (nonatomic, strong)NSString * param;//    string
/**
 * 提示
 */
@property (nonatomic, strong)NSString * prompt  ;//  string
/**
 * 开始时间
 */
@property (nonatomic, strong)NSString * startTime ;//   string($date-time)
/**
 * 状态
 */
@property (nonatomic, assign)int status ;//   integer($int32)
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * giftCopyWriting;
/**
 * 商品id
 */
@property (nonatomic, strong)NSString * giftGoodsId;
/**
 * sku 
 */
@property (nonatomic, strong)XZZSku * goodsSku;
/**
 * 赠送商品是否计算邮费
 */
@property (nonatomic, assign)BOOL isCalPostage;
/**
 * <#expression#>
 */
@property (nonatomic, assign)int weight;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray<NSNumber *> * limitGoodsIdList;
/**
 * x  标题
 */
@property (nonatomic, strong)NSString * limitTitle;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray<NSNumber *> * recommendGoodsIdList;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * recommendTitle;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * bannerImage;

/**
 * <#expression#>
 */
@property (nonatomic, assign)NSInteger couponType;


/**
 * 类型  X是只有x    Y是有x y
 */
@property (nonatomic, strong)NSString * recommendType;
/**
 * 标题
 */
@property (nonatomic, strong)NSString * seoTitle;

@end

NS_ASSUME_NONNULL_END
