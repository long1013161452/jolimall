//
//  XZZCheckOutPaymentView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZZPaymentType.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReturnPaymentType)(NSInteger payType);

/**
 *  展示支付方式视图
 */
@interface XZZCheckOutPaymentView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * paymentTypeArr;

/**
 * <#expression#>
 */
@property (nonatomic, strong)ReturnPaymentType paymentType;


/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock refreshBlock;

@end

NS_ASSUME_NONNULL_END
