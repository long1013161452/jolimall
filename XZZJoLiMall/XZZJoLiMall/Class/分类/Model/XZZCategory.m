//
//  XZZCategory.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCategory.h"

@implementation XZZCategory

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id",};
}
/**
 *  属性所对应的对象
 */
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"children" : [XZZCategory class]};
}

@end
