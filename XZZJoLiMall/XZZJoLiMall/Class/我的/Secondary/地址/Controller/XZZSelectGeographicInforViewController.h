//
//  XZZSelectGeographicInforViewController.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/22.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZMainViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectGeographicInfor)(id data);

/**
 *  选择地理位置信息    国家、州、城市
 */
@interface XZZSelectGeographicInforViewController : XZZMainViewController

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * inforArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)SelectGeographicInfor selectInfor;

@end

NS_ASSUME_NONNULL_END
