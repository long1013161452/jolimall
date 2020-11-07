//
//  XZZImageBigImageView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/15.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  商品大图
 */
@interface XZZImageBigImageView : UIView<UIScrollViewDelegate>

+ (XZZImageBigImageView *)shareImageBigImageView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)id imageInfor;

- (void)addSubView;

@end

NS_ASSUME_NONNULL_END
