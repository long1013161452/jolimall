//
//  XZZCountryInfor.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/22.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZCountryInfor : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * ID;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * countryEnName;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * countryCode;

@end

@interface XZZProvinceInfor : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * ID;
/**
 * <#expression#>
*/
@property (nonatomic, strong)NSString * provinceCode;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * provinceName;

@end

@interface XZZCityInfor : NSObject
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * ID;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * cityName;

@end

NS_ASSUME_NONNULL_END
