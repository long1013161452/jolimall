//
//  XZZBuriedDataSource.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/19.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZBuriedDataSource : NSObject

/**
 * 时间   到毫秒
 */
@property (nonatomic, assign)NSInteger eventTimestamp;
/**
 * 事件名
 */
@property (nonatomic, strong)NSString * eventName;
/**
 * 时间类型  事件类型（normal/click/exposure）
 */
@property (nonatomic, strong)NSString * eventType;
/**
 * 端上自定义的唯一识别号，未登录时也有值，同一用户的值保持不变
 */
@property (nonatomic, strong)NSString * userUniqId;
/**
 * 系统中对应的uid，未登录为0
 */
@property (nonatomic, assign)NSInteger userUid;
/**
 * 用户的登录邮箱，未登录为空字符串
 */
@property (nonatomic, strong)NSString * userEmail;
/**
 * ipip地址；通过访问一次后台接口得到
 */
@property (nonatomic, strong)NSString * ip;
/**
 * 设备品牌，如Apple，取不到填空字符串
 */
@property (nonatomic, strong)NSString * deviceBrand;
/**
 * 设备型号，如iPhone8，取不到填空字符串
 */
@property (nonatomic, strong)NSString * deviceModel;
/**
 * 操作系统，如iOS
 */
@property (nonatomic, strong)NSString * deviceOS;
/**
 * 操作系统版本，如12.1
 */
@property (nonatomic, strong)NSString * deviceOSVersion;
/**
 * 哪一端：iOS，android，pc，h5
 */
@property (nonatomic, strong)NSString * platform;
/**
 * 应用的版本号，如1.8.2
 */
@property (nonatomic, strong)NSString * appVersion;








@end

NS_ASSUME_NONNULL_END
