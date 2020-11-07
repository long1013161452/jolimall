//
//  XZZAddressInfor.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  地址信息
 */
@interface XZZAddressInfor : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * ID;

/**
 * firstName
 */
@property (nonatomic, strong)NSString * firstName;
/**
 * lastName
 */
@property (nonatomic, strong)NSString * lastName;
/**
 * detailAddress1 地址1
 */
@property (nonatomic, strong)NSString * detailAddress1;
/**
 * detailAddress2 地址2
 */
@property (nonatomic, strong)NSString * detailAddress2;
/**
 * 国家ID
 */
@property (nonatomic, strong)NSString * countryId;
/**
 * country 国家
 */
@property (nonatomic, strong)NSString * countryName;
/**
 * 国家 code
 */
@property (nonatomic, strong)NSString * countryCode;
/**
 * 省份ID
 */
@property (nonatomic, strong)NSString * provinceId;
/**
 * province 省
 */
@property (nonatomic, strong)NSString * provinceName;
/**
 * 省份code
 */
@property (nonatomic, strong)NSString * provinceCode;
/**
 * 城市ID
 */
@property (nonatomic, strong)NSString * cityId;
/**
 * city 城市
 */
@property (nonatomic, strong)NSString * cityName;
/**
 * zipCode 邮编
 */
@property (nonatomic, strong)NSString * zipCode;
/**
 * phone
 */
@property (nonatomic, strong)NSString * phone;
/**
 * status 状态  1是默认  0是普通
 */
@property (nonatomic, assign)int status;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * userId;


- (BOOL)isContrastSame:(XZZAddressInfor *)addressInfor;

@end


