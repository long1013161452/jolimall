//
//  XZZFilterView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZZFilterModel.h"


NS_ASSUME_NONNULL_BEGIN



typedef void(^SelectSizeAndColorInformation)(NSArray * sizeArray, NSArray * colorArray);


/**
 *  筛选
 */
@interface XZZFilterView : UIView

/**
 * 尺码信息
 */
@property (nonatomic, strong)NSArray * sizeArray;

/**
 * 颜色信息
 */
@property (nonatomic, strong)NSArray * colorArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)SelectSizeAndColorInformation selectSizeAndColorInfor;


/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView;

/**
 * 移除视图
 */
- (void)removeView;

@end

NS_ASSUME_NONNULL_END
