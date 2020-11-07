//
//  XZZCountryInfor.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/22.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCountryInfor.h"

@implementation XZZCountryInfor

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end

@implementation XZZProvinceInfor

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end

@implementation XZZCityInfor

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end
