//
//  XZZRequestOrder.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/12.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZRequestOrder.h"

/**
 *  下单
 */
@implementation XZZRequestCheckOut


//- (NSString *)couponCode
//{
//    if (!_couponCode) {
//        self.couponCode = @"";
//    }
//    return _couponCode;
//}

- (NSString *)clientType
{
    if (!_clientType) {
        self.clientType = @"1";
    }
    return _clientType;
}

- (NSString *)contact
{
    if (!_contact) {
        self.contact = self.email;
    }
    return _contact;
}


@end
/**
 *  支付
 */
@implementation XZZRequestOrderPay

- (NSString *)paySource
{
    if (!_paySource) {
        self.paySource = @"1";
    }
    return _paySource;
}

@end
