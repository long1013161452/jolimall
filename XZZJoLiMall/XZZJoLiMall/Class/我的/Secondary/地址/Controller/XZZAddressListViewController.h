//
//  XZZAddressListViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZMainViewController.h"


typedef void(^SelectedAddressInfor)(XZZAddressInfor * address);

/**
 *  地址列表
 */
@interface XZZAddressListViewController : XZZMainViewController

/**
 * <#expression#>
 */
@property (nonatomic, strong)SelectedAddressInfor selectedAddress;

/**
 * 选择地址
 */
@property (nonatomic, assign)BOOL isSelectAddress;

/**
 * 选中的地址
 */
@property (nonatomic, strong)XZZAddressInfor * address;


@end


