//
//  XZZEquipmentInfor.h
//  测试缓存
//
//  Created by 龙少 on 2018/12/12.
//  Copyright © 2018年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>



@interface XZZEquipmentInfor : NSObject<CLLocationManagerDelegate>

// 判断设备是否是手机
+ (BOOL)deviceIsPhone;



+ (XZZEquipmentInfor *)shareEquipmentInfor;

/**
 * //当前国家
 */
@property (nonatomic, strong) NSString *currentCountries;

/**
 * //当前区
 */
@property (nonatomic, strong) NSString *currentArea;
/**
 * 当前省
 */
@property (nonatomic, strong) NSString *currentProvince;
/**
 * //当前城市
 */
@property (nonatomic, strong) NSString *currentCity;
/**
 * //经度
 */
@property (nonatomic, strong) NSString *strlatitude;
/**
 * //纬度
 */
@property (nonatomic, strong)  NSString *strlongitude;
/**
 * 地理位置信息
 */
@property (nonatomic, strong)NSString * currentAddressInfor;

/**
 * 系统版本
 */
@property (nonatomic, strong)NSString * systemVersion;
/**
 * APP版本
 */
@property (nonatomic, strong)NSString * app_Version;
/**
 * 设备型号
 */
@property (nonatomic, strong)NSString * equipmentModel;
/**
 * 设备唯一标识
 */
@property (nonatomic, strong)NSString * uuid;

/**
 * IP信息
 */
@property (nonatomic, strong)NSString * ip;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * AppName;


//- (void)getLocation;


@end


