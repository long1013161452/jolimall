//
//  XZZGoodsScore.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZGoodsScore.h"

@implementation XZZGoodsScore

/**
 *  属性所对应的对象
 */
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"canCommentList" : [XZZCanCommentSku class]};
}

@end


@implementation XZZGoodsComments

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id",};
}

- (NSArray<NSString *> *)pictureList
{
    if (!_pictureList) {
        
        NSArray * urlArray = [self.pictureUrls componentsSeparatedByString:@";"];
        NSMutableArray * array = @[].mutableCopy;
        for (NSString * str in urlArray) {
            if (str.length) {
                [array addObject:str];
            }
        }
        self.pictureList = array;
    }
    return _pictureList;
}


@end


@implementation XZZCanCommentSku


+ (XZZCanCommentSku *)canCommentSku:(XZZOrderSku *)orderSku
{
    XZZCanCommentSku * canCommentSku = [self allocInit];
    canCommentSku.orderId = orderSku.orderId;
    canCommentSku.skuId = orderSku.skuId;
    canCommentSku.goodsTitle = orderSku.goodsTitle;
    canCommentSku.goodsCode = orderSku.goodsCode;
    canCommentSku.goodsId = orderSku.goodsId;
    canCommentSku.image = orderSku.image;
    canCommentSku.color = orderSku.colorName;
    canCommentSku.size = orderSku.shortSizeCode.length > 0 ? orderSku.shortSizeCode : orderSku.size;
    canCommentSku.quantity = orderSku.quantity;
    canCommentSku.price = orderSku.price;
    
    
    
    return canCommentSku;
}


@end
