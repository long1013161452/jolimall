//
//  XZZAddressInfor.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZAddressInfor.h"

@implementation XZZAddressInfor

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id",};
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    return [self yy_modelInitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder*)aCoder {
    
    [self yy_modelEncodeWithCoder:aCoder];
    
}

- (NSString *)cityId
{
    if (_cityId.length == 0) {
        self.cityId = @"0";
    }
    return _cityId;
}

- (NSString *)provinceId
{
    if (_provinceId.length == 0) {
        self.provinceId = @"0";
    }
    return _provinceId;
}

- (BOOL)isContrastSame:(XZZAddressInfor *)addressInfor
{
    if (![self.firstName isEqualToString:addressInfor.firstName]) {
        return NO;
    }
    
    if (![self.lastName isEqualToString:addressInfor.lastName]) {
        return NO;
    }
    if (![self.detailAddress1 isEqualToString:addressInfor.detailAddress1]) {
        return NO;
    }
    if (![self.detailAddress2 isEqualToString:addressInfor.detailAddress2]) {
        return NO;
    }
    if (![self.countryName isEqualToString:addressInfor.countryName]) {
        return NO;
    }
    if (![self.countryId isEqualToString:addressInfor.countryId]) {
        return NO;
    }
    if (![self.countryCode isEqualToString:addressInfor.countryCode]) {
        return NO;
    }
    if (![self.provinceName isEqualToString:addressInfor.provinceName]) {
        return NO;
    }
    if (![self.provinceId isEqualToString:addressInfor.provinceId]) {
        return NO;
    }

    if (![self.cityName isEqualToString:addressInfor.cityName]) {
        return NO;
    }
    if (![self.cityId isEqualToString:addressInfor.cityId]) {
        return NO;
    }
    if (![self.zipCode isEqualToString:addressInfor.zipCode]) {
        return NO;
    }
    if (![self.phone isEqualToString:addressInfor.phone]) {
        return NO;
    }
    
    
    
    return YES;
}

@end
