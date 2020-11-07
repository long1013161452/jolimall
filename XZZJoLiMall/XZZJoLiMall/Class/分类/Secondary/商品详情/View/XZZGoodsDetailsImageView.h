//
//  XZZGoodsDetailsImageView.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/25.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^imageClick)(NSInteger imageIndex, FLAnimatedImageView * imageView);

typedef void(^refresh)(void);

/**
 * 右侧视图露出宽度
 */
#define right_View_Exposing_Width 50
/**
 *  图片之间的间隔
 */
#define Image_interval 10

/**
 * 商品大图展示
 */
@interface XZZGoodsDetailsImageView : UIView


+ (id)allocInitWithFrame:(CGRect)frame imageUrl:(NSArray *)imageUrlArray imageClick:(imageClick)imgClick;
@property(nonatomic,copy)refresh refresh;
/**
 * 展示第几个位置的label
 */
@property (nonatomic, strong)UILabel * countLabel;

/**
 * 滚动视图
 */
@property (nonatomic, strong)UIScrollView * scrollView;
/**
 * 图片url
 */
@property (nonatomic, strong)NSArray * imageURLArray;
/**
 * 重新创建imageview视图  根据 图片URL
 */
- (void)recreateImageviewAccordingToImageUrl:(NSArray *)imageUrlArray;

/**
 *  移动到atIndex位置
 */
- (void)mobileLocationAtIndex:(NSInteger)atIndex;
@end

NS_ASSUME_NONNULL_END
