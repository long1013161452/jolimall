//
//  XZZAddAddressViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZMainViewController.h"


/**
 *  d添加地址
 */
@interface XZZAddAddressViewController : XZZMainViewController


/**
 * 地址信息
 */
@property (nonatomic, strong)XZZAddressInfor * addressInfor;

/**
 * 代理
 */
@property (nonatomic, weak)id<XZZMyDelegate> delegate;

@end


