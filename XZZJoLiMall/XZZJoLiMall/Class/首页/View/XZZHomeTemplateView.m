//
//  XZZHomeTemplateView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZHomeTemplateView.h"
#import "XZZHomeShufflingFigureView.h"
#import "XZZCountdownView.h"
#import "XZZCountdownChellysunView.h"
#import "XZZTwoAdvertisingView.h"
#import "XZZTwoAdvertisingChellysunView.h"
#import "XZZTwoAdvertisingChellysunTwoView.h"
#import "XZZThreeAdvertisingView.h"
#import "XZZClassificationView.h"
#import "XZZClassificationChellysunView.h"
#import "XZZSinglePictureView.h"
#import "XZZHomeRecommendedCategoryView.h"
#import "XZZActivitiesGoodsView.h"
#import "XZZRecommendForYouView.h"
#import "XZZHomeAdaptiveImageView.h"
#import "XZZHomeSecondsKillView.h"

@implementation XZZHomeTemplateView

/**
 *  创建视图信息
 */
+ (id)allocInitWithFrame:(CGRect)frame homeTemplate:(XZZHomeTemplate *)homeTemplate delegate:(nonnull id<XZZMyDelegate>)delegate
{
    
    
    XZZHomeTemplateView * view = nil;
    
    switch (homeTemplate.styleType) {
        case 4://轮播
        {
            view = [XZZHomeShufflingFigureView allocInitWithFrame:frame];
        }
            break;
        case 2://推荐活动   首页下部
        {
            view = [XZZHomeRecommendedCategoryView allocInitWithFrame:frame];
        }
            break;
        case 14://分类  四张
        {
            view = [XZZClassificationView allocInitWithFrame:frame];
        }
            break;
        case 11://倒计时  两排商品的
        {
            view = [XZZCountdownView allocInitWithFrame:frame];
        }
            break;
        case 13://两个广告  高的  一排一个
        {
            view = [XZZTwoAdvertisingView allocInitWithFrame:frame];
        }
            break;
        case 6://三个广告  chellysun的
        {
            view = [XZZThreeAdvertisingView allocInitWithFrame:frame];
        }
            break;
        case 12://活动  一排一张 x矮
        {
            view = [XZZSinglePictureView allocInitWithFrame:frame];
        }
            break;
        case 10://分类 chellysun  8张的
        {
            view = [XZZClassificationChellysunView allocInitWithFrame:frame];
        }
            break;
        case 3://倒计时  chellysun  一排商品可以左右滑动的
        {
            view = [XZZCountdownChellysunView allocInitWithFrame:frame];
        }
            break;
        case 7://两个广告  chellysun 一排一个
        {
            view = [XZZTwoAdvertisingChellysunView allocInitWithFrame:frame];
        }
            break;
        case 5://两个广告  一排两个
        {
            view = [XZZTwoAdvertisingChellysunTwoView allocInitWithFrame:frame];
        }
            break;
        case 15:{//纯商品
            view = [XZZActivitiesGoodsView allocInitWithFrame:frame];
        }
            break;
        case 16:{//自适应商品排数
            view = [XZZRecommendForYouView allocInitWithFrame:frame];
        }
            break;
        case 17:{//自适高度的图片
            view = [XZZHomeAdaptiveImageView allocInitWithFrame:frame];
        }
            break;
        case 18:{//秒杀  模块  需要下载商品
            view = [XZZHomeSecondsKillView allocInitWithFrame:frame];
        }
            break;
        default:
            break;
    }
//    view.backgroundColor = BACK_COLOR;
    view.backgroundColor = [UIColor whiteColor];
    view.delegate = delegate;
    view.homeTemplateArray = homeTemplate.cardList;
    return view;
}

- (void)setHomeTemplateArray:(NSArray<XZZHomeTemplate *> *)homeTemplateArray
{
    _homeTemplateArray = homeTemplateArray;
    [self removeAllSubviews];
    if (homeTemplateArray.count) {
        [self addView];
    }else{
        self.height = 0;
    }
}

- (void)addView
{
    
}





@end
