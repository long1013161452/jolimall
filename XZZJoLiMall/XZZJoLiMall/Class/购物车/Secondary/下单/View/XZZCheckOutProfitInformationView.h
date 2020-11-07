//
//  XZZCheckOutProfitInformationView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/7/11.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  利润信息
 */
@interface XZZCheckOutProfitInformationView : UIView

/**
 * <#expression#>
 */
@property (nonatomic, assign)BOOL selected;

/**
 * <#expression#>
 */
@property (nonatomic, strong)GeneralBlock generalBlock;

- (void)editProfitInfor;

@end

NS_ASSUME_NONNULL_END
