//
//  XZZPaymentType.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/3.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  支付类型
 */
@interface XZZPaymentType : NSObject

/**
 * 支付类型 0PayPal  1stripe  2ipaylink
 */
@property (nonatomic, assign)NSInteger payType;
/**
 * 是否启用
 */
@property (nonatomic, assign)NSInteger isOpen;

/**
 * 商户号
 */
@property (nonatomic, strong)NSString * merchantNumber;
/**
 * 网关
 */
@property (nonatomic, strong)NSString * payModel;
/**
 * signKey
 */
@property (nonatomic, strong)NSString * signKey;
/**
 * returnUrl
 */
@property (nonatomic, strong)NSString * returnUrl;

@end

NS_ASSUME_NONNULL_END
