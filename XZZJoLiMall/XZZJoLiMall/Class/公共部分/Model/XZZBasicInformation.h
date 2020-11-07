//
//  XZZBasicInformation.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/5/15.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>



#define My_Basic_Infor [XZZBasicInformation sharedBasicInformation]


NS_ASSUME_NONNULL_BEGIN

@interface XZZBasicInformation : NSObject

/**
 *  单利
 */
+ (XZZBasicInformation *)sharedBasicInformation;

/**
 * 详情页描述b信息1标题
 */
@property (nonatomic, strong)NSString * detailsPageInfo1Title;

/**
 * 详情页描述信息1内容
 */
@property (nonatomic, strong)NSString * detailsPageInfo1Desc;
/**
 * 详情页描述信息2t标题
 */
@property (nonatomic, strong)NSString * detailsPageInfo2Title;
/**
 * 详情页描述信息2内容
 */
@property (nonatomic, strong)NSString * detailsPageInfo2Desc;

/**
 * 详情页优惠码信息
 */
@property (nonatomic, strong)NSString * detailsPageOffer;

/**
 * 详情页优惠码信息
 */
@property (nonatomic, strong)NSArray * detailsPageOfferList;


/**
 * 确认订单页的u优惠码文案
 */
@property (nonatomic, strong)NSString * confirmPageCouponcodeCopywriting;
/**
 * 确认订单页的code信息
 */
@property (nonatomic, strong)NSString * confirmPageCouponcode;
/**
 * 购物车顶部文字
 */
@property (nonatomic, strong)NSString * cartTopRemind;
/**
 * 购物车顶部文字
 */
@property (nonatomic, strong)NSArray * cartTopRemindList;
/**
 * 优惠券顶部提示1
 */
@property (nonatomic, strong)NSString * cartDiscountDescriptionOne;
/**
 * 优惠券顶部提示2
 */
@property (nonatomic, strong)NSString * cartDiscountDescriptionTwo;
/**
 * 客服邮箱
 */
@property (nonatomic, strong)NSString * customerServiceEmail;

/**
 * kol
 */
@property (nonatomic, assign)BOOL isKol;

/**
 * 利润
 */
@property (nonatomic, assign)CGFloat kolProfit;



@end

NS_ASSUME_NONNULL_END
