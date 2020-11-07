//
//  XZZPaymentAddCardView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  添加信用卡   使用新卡
 */
@interface XZZPaymentAddCardView : UIView


/**
 * 信用卡
 */
@property (nonatomic, strong)UITextField * cardTextField;

/**
 * 有效期
 */
@property (nonatomic, strong)UITextField * dateTextField;
/**
 * 安全码
 */
@property (nonatomic, strong)UITextField * cvvTextField;
/**
 * firstName
 */
@property (nonatomic, strong)UITextField * firstNameTextField;
/**
 * lastName
 */
@property (nonatomic, strong)UITextField * lastNameTextField;

/**
 * a地址信息
 */
@property (nonatomic, strong)UILabel * addressLabel;

/**
 * 隐藏姓名信息
 */
@property (nonatomic, assign)BOOL hideNameInfor;

@end

NS_ASSUME_NONNULL_END
