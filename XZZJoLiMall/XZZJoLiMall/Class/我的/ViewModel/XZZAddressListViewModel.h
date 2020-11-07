//
//  XZZAddressListViewModel.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZZAddressListViewModel : NSObject<UITableViewDelegate, UITableViewDataSource>

/**
 * 控制器
 */
@property (nonatomic, weak)UIViewController * VC;


/**
 * 用于刷新
 */
@property (nonatomic, strong)GeneralBlock reloadData;

@end

NS_ASSUME_NONNULL_END
