//
//  XZZActivityInfor.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/7.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 活动信息*/

@interface XZZActivityInfor : NSObject


/**
 * 是否展示
 */
@property (nonatomic, assign)int  isShow;//    integer($int32)

/**
 * 短标题
 */
@property (nonatomic, strong)NSString * shortTitle;//    string

/**
 * 长标题
 */
@property (nonatomic, strong)NSString *  longTitle;//    string

/**
 * icon链接  详情页  h购物车
 */
@property (nonatomic, strong)NSString *  iconPictureOne;//    string
/**
 * icon链接  列表页
 */
@property (nonatomic, strong)NSString *  iconPictureTwo;//    string

/**
 * 倒计时格式
 */
@property (nonatomic, assign)int timeFormat;//    integer($int32)

/**
 * 结束时间
 */
@property (nonatomic, strong)NSString *  endTime;//    string($date-time)

/**
 * t活动图片信息
 */
@property (nonatomic, strong)NSString * bannerPicture;//    string

/**
 * 活动id
 */
@property (nonatomic, strong)NSString * ID;// id    integer($int64)

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * activityId;



@end

NS_ASSUME_NONNULL_END
