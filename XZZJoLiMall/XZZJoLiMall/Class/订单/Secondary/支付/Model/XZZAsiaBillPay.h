//
//  XZZAsiaBillPay.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XZZPaymentType.h"

NS_ASSUME_NONNULL_BEGIN


typedef void(^AsiaBillPay)(BOOL state, NSString * results);

@interface XZZAsiaBillPay : NSObject


/**
 *  交易返回地址
 */
@property(nonatomic, copy) NSString * returnUrl;

/**
 *  交易地址
 */
@property(nonatomic, copy) NSString * requestUrl;


//+ (XZZAsiaBillPay *)setupAsiaBillOrderNum:(NSString *)orderNum price:(CGFloat)price paymentType:(XZZPaymentType *)paymentType address:(XZZAddressInfor *)address;
//
//
//
//- (void)pay:(AsiaBillPay)asiaBillPay;

@end

NS_ASSUME_NONNULL_END
