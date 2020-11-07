//
//  XZZOrderList.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/1.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZOrderList.h"

@implementation XZZOrderList

/**
 *  属性所对应的对象
 */
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"skus" : [XZZOrderSku class]};
}


- (int)itmes
{
    self.itmes = 0;
    for (XZZOrderSku * orderSku in self.skus) {
        self.itmes = [orderSku.quantity intValue];
    }
    return _itmes;
}

- (BOOL)isComment
{
    for (XZZOrderSku * sku in self.skus) {
        if (sku.isComment == 0) {
            return NO;
        }
    }
    return YES;
}


@end
