//
//  XZZCouponsInfor.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/1.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCouponsInfor.h"

@implementation XZZGoodsDetailCoupon

/**
 *  属性所对应的对象
 */
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"couponVos" : [XZZCouponsInfor class]};
}

@end

@implementation XZZCouponsInfor

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id",};
}


/**
 *  属性所对应的对象
 */
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"limitGoodsIdList" : [NSNumber class], @"recommendGoodsIdList" : [NSNumber class]};
}


@end
