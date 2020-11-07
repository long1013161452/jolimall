//
//  XZZOrderDetail.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/1.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZOrderDetail.h"

@implementation XZZOrderDetail

/**
 *  属性所对应的对象
 */
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"skus" : [XZZOrderSku class]};
}

- (NSString *)couponCode
{
    if (!_couponCode) {
        self.couponCode = @"";
    }
    return _couponCode;
}


- (XZZAddressInfor *)shippingAddress
{
    if (!_shippingAddress) {
        XZZAddressInfor * addressInfor = [XZZAddressInfor allocInit];
        self.shippingAddress = addressInfor;
        addressInfor.cityName = self.cityName;
        addressInfor.lastName = self.lastName;
        addressInfor.firstName = self.firstName;
        addressInfor.cityName = self.cityName;
        addressInfor.countryName = self.countryName;
        addressInfor.provinceName = self.provinceName;
        addressInfor.detailAddress1 = self.detailAddress1;
        addressInfor.detailAddress2 = self.detailAddress2;
        addressInfor.phone = self.phone;
        addressInfor.zipCode = self.zipCode;
        addressInfor.ID = self.shippingId;
    }
    return _shippingAddress;
}

@end
