//
//  XZZHomeTemplate.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZHomeTemplate.h"

@implementation XZZHomeTemplate

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id",};
}

/**
 *  属性所对应的对象
 */
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"cardList" : [XZZHomeTemplate class], @"goodsIdList" : [NSNumber class], @"toppingGoodsIdList" : [NSNumber class]};
}

- (int)sortType
{
    if (_sortType <= 0) {
            self.sortType = 2;
    }
    return _sortType;
}


@end
