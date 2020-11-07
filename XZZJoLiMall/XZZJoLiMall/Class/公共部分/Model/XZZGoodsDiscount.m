//
//  XZZGoodsDiscount.m
//  ZBYElectricity
//
//  Created by 龙少 on 2019/1/4.
//  Copyright © 2019年 long. All rights reserved.
//

#import "XZZGoodsDiscount.h"

@implementation XZZGoodsDiscount

static XZZGoodsDiscount * allGoodsdis;

+ (XZZGoodsDiscount *)sharedGoodsDiscount
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        
        allGoodsdis = [[XZZGoodsDiscount alloc]init];
        
    });
    return allGoodsdis;
}

- (NSMutableDictionary *)discountDict
{
    if (!_discountDict) {
        self.discountDict = @{}.mutableCopy;
    }
    return _discountDict;
}

/**
 *  获取折扣率
 */
- (CGFloat)getDiscountGoodsId:(NSString *)goodsId
{
    NSDictionary * dic = self.discountDict[goodsId];
    NSLog(@"%@~~~~~~~~~~~~~%@", dic[@"goodsId"], goodsId);
    if (!dic) {
        return 1;
    }
    NSString * discount = [NSString stringWithFormat:@"%@", dic[@"discount"]];
    NSDecimalNumber * decNumber = [NSDecimalNumber decimalNumberWithString:discount];
    return [decNumber floatValue];
}

@end
