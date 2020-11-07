//
//  XZZHomeViewModel.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/8.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZHomeViewModel.h"
#import "XZZHomeTemplateView.h"

#import "XZZCountdownView.h"
#import "XZZCountdownChellysunView.h"
#import "XZZActivitiesGoodsView.h"
#import "XZZHomeRecommendedCategoryView.h"
#import "XZZRecommendForYouView.h"
#import "XZZHomeAdaptiveImageView.h"
#import "XZZHomeSecondsKillView.h"

#import "XZZGoodsListViewController.h"
#import "XZZCouponGoodsListViewController.h"
#import "XZZSecondsKillGoodsListViewController.h"

#import "XZZSecondsKillSession.h"

/***  列表一排几个商品 */
#define goods_list_count 2

@interface XZZHomeViewModel ()<XZZMyDelegate>

/**
 * 页码
 */
@property (nonatomic, assign)int page;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZHomeTemplate * homeTemplate;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZHomeRecommendedCategoryView * recommendedCategoryView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZSecondsKillSession * secKill;
/**
 * 弹出加购框
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewViewModel * addToCartBuyNewViewModel;

/**
 * 底部商品展示的    goodsDic  key是id信息
 */
@property (nonatomic, strong)NSMutableDictionary * goodsDic;

@end


@implementation XZZHomeViewModel

- (NSMutableArray *)tableHeardArray
{
    if (!_tableHeardArray) {
        self.tableHeardArray = @[].mutableCopy;
    }
    return _tableHeardArray;
}

- (NSMutableDictionary *)goodsDic
{
    if (!_goodsDic) {
        self.goodsDic = [NSMutableDictionary dictionary];
    }
    return _goodsDic;
}

- (NSMutableArray *)goodsArray
{
    if (!_goodsArray) {
        self.goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}


/**
 *  更新数据
 */
- (void)updateData
{
    self.page = 0;
    [self.goodsDic removeAllObjects];
    [self downloadHomepageConfiguration];
}
/**
 *  数据下载   用于下拉加载
 */
- (void)dataDownload
{
    if (!self.homeTemplate) {
        !self.reloadData?:self.reloadData();
        return;
    }
    self.page++;
    WS(wSelf)
    if (self.homeTemplate.assoType == 4) {
        NSString * activityId = [NSString stringWithFormat:@"activity_%@", self.homeTemplate.assoContent];
        
        [self downloadActivityGoods:self.homeTemplate page:self.page httpBlock:^(id data, BOOL successful, NSError *error) {
            if (wSelf.page == 1) {
                if (successful) {
                    [wSelf.goodsDic setObject:data forKey:activityId];
                }else{
                    wSelf.page--;
                }
                [wSelf.goodsArray removeAllObjects];
            }
            
            [wSelf.goodsArray addObjectsFromArray:data];
            !wSelf.reloadData?:wSelf.reloadData();
        }];
    }else if(self.homeTemplate.assoType == 7){
        NSString * couponId = [NSString stringWithFormat:@"coupon_%@_%d", self.homeTemplate.assoContent, self.homeTemplate.sortType];
        
        [self downloadCouponGoods:self.homeTemplate page:self.page httpBlock:^(id data, BOOL successful, NSError *error) {
            if (wSelf.page == 1) {
            [wSelf.goodsArray removeAllObjects];
                if (successful) {
                    [wSelf.goodsDic setObject:data forKey:couponId];
                }
            }
            [wSelf.goodsArray addObjectsFromArray:data];
            !wSelf.reloadData?:wSelf.reloadData();
        }];
    }else if (self.homeTemplate.assoType != 5){
        NSString * activityId = [NSString stringWithFormat:@"category_%@_%d", self.homeTemplate.assoContent, self.homeTemplate.sortType];
        
        [self downloadCategoryGoods:self.homeTemplate page:self.page httpBlock:^(id data, BOOL successful, NSError *error) {
            if (wSelf.page == 1) {
                if (successful) {
                    [wSelf.goodsDic setObject:data forKey:activityId];
                }else{
                    wSelf.page--;
                }
                [wSelf.goodsArray removeAllObjects];
            }
            
            [wSelf.goodsArray addObjectsFromArray:data];
            !wSelf.reloadData?:wSelf.reloadData();
        }];
    }
    
}
/**
 *  下载首页配置
 */
- (void)downloadHomepageConfiguration
{
    WS(wSelf)
    [XZZDataDownload goodsGetHomePageTemplateHttpBlock:^(id data, BOOL successful, NSError *error) {
        NSLog(@"%@", data);
        
        if (successful) {
            wSelf.homeTemplate = nil;
            [wSelf processHomepageTemplateData:data];
            [wSelf.goodsArray removeAllObjects];
        }
        !wSelf.reloadData?:wSelf.reloadData();
    }];
}

- (void)processHomepageTemplateData:(NSArray *)templateArray
{
    [self.tableHeardArray removeAllObjects];
    for (XZZHomeTemplate * homeTemplate in templateArray) {
        if (homeTemplate.styleType != 1) {
            XZZHomeTemplateView * templateView = nil;
            if (homeTemplate.styleType != 2) {
                WS(wSelf)
                templateView = [XZZHomeTemplateView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 0) homeTemplate:homeTemplate delegate:self];
                    templateView.delegate = self;
                if ([templateView isKindOfClass:[XZZCountdownView class]] || [templateView isKindOfClass:[XZZCountdownChellysunView class]] || [templateView isKindOfClass:[XZZActivitiesGoodsView class]] || [templateView isKindOfClass:[XZZRecommendForYouView class]] || [templateView isKindOfClass:[XZZHomeSecondsKillView class]]) {
                    [self getGoodsInforHomepageTemplateView:templateView];
                }
                if ([templateView isKindOfClass:[XZZHomeAdaptiveImageView class]]) {
                    XZZHomeAdaptiveImageView * view = (XZZHomeAdaptiveImageView *)templateView;
                    [view setRefresh:^{
                        !wSelf.reloadData?:wSelf.reloadData();
                    }];
                }
            }else{
                if (!self.recommendedCategoryView) {
                    templateView = [XZZHomeTemplateView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 0) homeTemplate:homeTemplate delegate:self];
                    self.recommendedCategoryView = (XZZHomeRecommendedCategoryView *)templateView;
                }else{
                    templateView = self.recommendedCategoryView;
                    templateView.homeTemplateArray = homeTemplate.cardList;
                }
            }
            if (templateView) {
                [self.tableHeardArray addObject:templateView];
            }
        }
        
    }
    if (self.recommendedCategoryView && [self.tableHeardArray containsObject:self.recommendedCategoryView]) {
        [self.tableHeardArray removeObject:self.recommendedCategoryView];
        [self.tableHeardArray addObject:self.recommendedCategoryView];
    }
}
#pragma mark ----  *  获取商品信息
/**
 *  获取商品信息
 */
- (void)getGoodsInforHomepageTemplateView:(XZZHomeTemplateView *)templateView
{
    XZZHomeTemplate * homeTemplate = [templateView.homeTemplateArray firstObject];
    weakView(WV, templateView)
    WS(wSelf)
    if (homeTemplate.assoType == 4) {
        [self downloadActivityGoods:homeTemplate page:1 httpBlock:^(id data, BOOL successful, NSError *error) {
            XZZCountdownView * view = (XZZCountdownView *)WV;
            if (successful) {
                view.goodsArray = data;
                !wSelf.reloadData?:wSelf.reloadData();
            }else{
                [wSelf.tableHeardArray removeObject:view];
                !wSelf.reloadData?:wSelf.reloadData();
            }
        }];
    }else if(homeTemplate.assoType == 7){
        [self downloadCouponGoods:homeTemplate page:1 httpBlock:^(id data, BOOL successful, NSError *error) {
            XZZCountdownView * view = (XZZCountdownView *)WV;
            if (successful) {
                view.goodsArray = data;
                !wSelf.reloadData?:wSelf.reloadData();
            }else{
                [wSelf.tableHeardArray removeObject:view];
                !wSelf.reloadData?:wSelf.reloadData();
            }
        }];
    }else if (homeTemplate.assoType == 9){
        [self downloadSecKillInforHttpBlock:^(id data, BOOL successful, NSError *error) {
            XZZHomeSecondsKillView * view = (XZZHomeSecondsKillView *)WV;
            if ([view isKindOfClass:[XZZHomeSecondsKillView class]]) {
                [view setRefresh:^{
                    [wSelf getGoodsInforHomepageTemplateView:WV];
                }];
                
                if (self.secKill.status == 3) {
                    view.endTime = self.secKill.endTime;
                    view.state = XZZSecondsKillStateOngoing;
                }else if (self.secKill.status == 4){
                    view.endTime = self.secKill.startTime;
                    view.state = XZZSecondsKillStateNot;
                }
                
            }
            if (successful) {
                view.goodsArray = data;
                !wSelf.reloadData?:wSelf.reloadData();
            }else{
                [wSelf.tableHeardArray removeObject:view];
                !wSelf.reloadData?:wSelf.reloadData();
            }
            
        }];
    }else if (homeTemplate.assoType != 5 ){
        [self downloadCategoryGoods:homeTemplate page:1 httpBlock:^(id data, BOOL successful, NSError *error) {
            XZZCountdownView * view = (XZZCountdownView *)WV;
            if (successful) {
                view.goodsArray = data;
                !wSelf.reloadData?:wSelf.reloadData();
            }else{
                [wSelf.tableHeardArray removeObject:view];
                !wSelf.reloadData?:wSelf.reloadData();
            }
        }];
    }
}

- (void)downloadSecKillInforHttpBlock:(HttpBlock)httpBlock
{
    WS(wSelf)
    [XZZDataDownload activityGetSeckillInforHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            [wSelf downloadSecKillGoods:data httpBlock:^(id data, BOOL successful, NSError *error) {
                if (successful) {
                    !httpBlock?:httpBlock(data, YES, nil);
                }else {
                    !httpBlock?:httpBlock(nil, NO, nil);
                }
            }];
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    }];
}

/**
 *  数据下载   秒杀商品
 */
- (void)downloadSecKillGoods:(XZZALLSecondsKillSession *)aLLSecondsKillSession httpBlock:(HttpBlock)httpBlock
{
    self.secKill = nil;
    XZZRequestSeckillGoods * requestSeckillGoods = [XZZRequestSeckillGoods allocInit];
    requestSeckillGoods.pageNum = 1;
    requestSeckillGoods.pageSize = 20;
    for (XZZSecondsKillSession * secKill in aLLSecondsKillSession.seckillDetailVoList) {
        if (secKill.status == 3 || secKill.status == 4) {
            self.secKill = secKill;
            requestSeckillGoods.seckillId = secKill.ID;
            break;
        }
    }
    if (!self.secKill) {
        !httpBlock?:httpBlock(nil, NO, nil);
        return;
    }
    [XZZDataDownload activityGetSeckillGoods:requestSeckillGoods httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            !httpBlock?:httpBlock(data, YES, nil);
        }else{
            [aLLSecondsKillSession.seckillDetailVoList removeObject:self.secKill];
            [self downloadSecKillGoods:aLLSecondsKillSession httpBlock:httpBlock];
//            !httpBlock?:httpBlock(nil, NO, nil);
        }
    }];
}

#pragma mark ---- 下载活动商品信息
/**
 * 下载活动商品信息
 */
- (void)downloadActivityGoods:(XZZHomeTemplate *)homeTemplate page:(int)page httpBlock:(HttpBlock)httpBlock
{
    XZZRequestActivityGoods * activityGoods = [XZZRequestActivityGoods allocInit];
    activityGoods.pageNum = page;
    
    activityGoods.pageSize = homeTemplate.showNum > 0 ? homeTemplate.showNum : 20;
    activityGoods.goodsIdList = homeTemplate.goodsIdList;
    activityGoods.activityId = homeTemplate.assoContent;
    activityGoods.orderBy = homeTemplate.sortType;
    activityGoods.toppingGoodsIdList = homeTemplate.toppingGoodsIdList;
    [XZZDataDownload goodsGetActivityGoods:activityGoods httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            !httpBlock?:httpBlock(data, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    }];
}
#pragma mark ---- 下载分类商品信息
/**
 * 下载分类商品信息
 */
- (void)downloadCategoryGoods:(XZZHomeTemplate *)homeTemplate page:(int)page httpBlock:(HttpBlock)httpBlock
{
    XZZRequestCategoryGoods * categoryGoods = [XZZRequestCategoryGoods allocInit];
    categoryGoods.orderBy = homeTemplate.sortType;
    categoryGoods.pageSize = 20;
    categoryGoods.pageNum = page;
    categoryGoods.categoryId = homeTemplate.assoContent;
    categoryGoods.toppingGoodsIdList = homeTemplate.toppingGoodsIdList;
    
    [XZZDataDownload goodsGetCategoryGoods:categoryGoods httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            !httpBlock?:httpBlock(data, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    }];
    
}
#pragma mark ---- 下载优惠券商品信息
/**
 *  下载优惠券商品信息
 */
- (void)downloadCouponGoods:(XZZHomeTemplate *)homeTemplate page:(int)page httpBlock:(HttpBlock)httpBlock
{
    XZZRequestCouponGoods * couponGoods = [XZZRequestCouponGoods allocInit];
    couponGoods.goodsIdList = homeTemplate.goodsIdList;
    couponGoods.toppingGoodsIdList = homeTemplate.toppingGoodsIdList;
    couponGoods.pageSize = 20;
    couponGoods.pageNum = page;
    couponGoods.orderBy = homeTemplate.sortType;
    couponGoods.couponId = homeTemplate.assoContent;
    [XZZDataDownload goodsGetCouponGoods:couponGoods httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            !httpBlock?:httpBlock(data, YES, nil);
        }else{
            !httpBlock?:httpBlock(nil, NO, nil);
        }
    }];
}


#pragma mark ----*  点击商品    进入商品详情使用
/**
 *  点击商品    进入商品详情使用
 */
- (void)clickOnGoodsAccordingId:(NSString *)goodsId state:(BOOL)state
{
    if (!state) {
        SVProgressError(@"Out of stock");
        return;
    }
    NSLog(@"%s %d 行", __func__, __LINE__);
    GoodsDetails(goodsId, self.VC)
}
#pragma mark ---- *  点击首页模板
/**
 *  点击首页模板
 */
- (void)clickOnHomepageTemplate:(XZZHomeTemplate *)homeTemplate
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    switch (homeTemplate.assoType) {
        case 1:{//分类 一级
            XZZGoodsListViewController * goodsListVC = [XZZGoodsListViewController allocInit];
            XZZRequestCategoryGoods * categoryGoods = [XZZRequestCategoryGoods allocInit];
            categoryGoods.categoryId = homeTemplate.assoContent;
            goodsListVC.myTitle = homeTemplate.name;
            goodsListVC.categoryGoods = categoryGoods;
            goodsListVC.isHomePage = YES;
            [self.VC pushViewController:goodsListVC animated:YES];
        }
            break;
        case 2:{//分类  二级
            XZZGoodsListViewController * goodsListVC = [XZZGoodsListViewController allocInit];
            XZZRequestCategoryGoods * categoryGoods = [XZZRequestCategoryGoods allocInit];
            categoryGoods.categoryId = homeTemplate.assoContent;
            goodsListVC.myTitle = homeTemplate.name;
            goodsListVC.categoryGoods = categoryGoods;
            goodsListVC.isHomePage = YES;
            [self.VC pushViewController:goodsListVC animated:YES];
        }
            break;
        case 3:{//分类 三级
            XZZGoodsListViewController * goodsListVC = [XZZGoodsListViewController allocInit];
            XZZRequestCategoryGoods * categoryGoods = [XZZRequestCategoryGoods allocInit];
            categoryGoods.categoryId = homeTemplate.assoContent;
            goodsListVC.myTitle = homeTemplate.name;
            goodsListVC.categoryGoods = categoryGoods;
            goodsListVC.isHomePage = YES;
            [self.VC pushViewController:goodsListVC animated:YES];
        }
            break;
        case 4:{//活动
            XZZGoodsListViewController * goodsListVC = [XZZGoodsListViewController allocInit];
            goodsListVC.myTitle = homeTemplate.name;
            goodsListVC.activityId = homeTemplate.assoContent;
            goodsListVC.isHomePage = YES;
            [self.VC pushViewController:goodsListVC animated:YES];
        }
            break;
        case 5:{//网页
            XZZWebViewController * webVC = [XZZWebViewController allocInit];
            webVC.urlStr = homeTemplate.assoContent;
            webVC.myTitle = homeTemplate.name;
            [self.VC pushViewController:webVC animated:YES];
        }
            break;
        case 6:{//分类 全部
            XZZGoodsListViewController * goodsListVC = [XZZGoodsListViewController allocInit];
            XZZRequestCategoryGoods * categoryGoods = [XZZRequestCategoryGoods allocInit];
            goodsListVC.myTitle = homeTemplate.name;
            goodsListVC.categoryGoods = categoryGoods;
            goodsListVC.isHomePage = YES;
            [self.VC pushViewController:goodsListVC animated:YES];
        }
            break;
        case 7:{//优惠券
            XZZCouponGoodsListViewController * goodsListVC = [XZZCouponGoodsListViewController allocInit];
            goodsListVC.couponsId = homeTemplate.assoContent;
            goodsListVC.myTitle = homeTemplate.name;
            [self.VC pushViewController:goodsListVC animated:YES];
        }
            break;
        case 8:{
            GoodsDetails(homeTemplate.assoContent, self.VC);
        }
            break;
        case 9:{
            XZZSecondsKillGoodsListViewController * secondsKillGoodsListVC = [XZZSecondsKillGoodsListViewController allocInit];
            secondsKillGoodsListVC.myTitle = @"Flash Deals";
            [self.VC pushViewController:secondsKillGoodsListVC animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark ----*  切换底部商品
/**
 *  切换底部商品
 */
- (void)clickOnHomepageTemplate:(XZZHomeTemplate *)homeTemplate selectedIndex:(NSInteger)selectedIndex
{
    self.homeTemplate = homeTemplate;
    
    NSString * key = @"";
    
    if (self.homeTemplate.assoType == 4) {
        key = [NSString stringWithFormat:@"activity_%@", self.homeTemplate.assoContent];
    }else if (self.homeTemplate.assoType == 7){
        key = [NSString stringWithFormat:@"coupon_%@_%d", self.homeTemplate.assoContent, self.homeTemplate.sortType];
    }else  if (self.homeTemplate.assoType != 5){
        key = [NSString stringWithFormat:@"category_%@_%d", self.homeTemplate.assoContent, self.homeTemplate.sortType];
    }
    NSArray * array = self.goodsDic[key];
    if (array.count > 0) {
        self.page = 1;
        [self.goodsArray removeAllObjects];
        [self.goodsArray addObjectsFromArray:array];
        !self.reloadData?:self.reloadData();
        return;
    }
    
    
    self.page = 0;
    [self dataDownload];
    
}






#pragma mark ----w自定义代理开始
#pragma mark ---- *  对商品进行收藏
/**
 *  对商品进行收藏
 */
- (void)collectGoodsAccordingId:(NSString *)goodsId
{
    WS(wSelf)
    [XZZCommonLogicalInfor goodsCollectionAccordingId:goodsId source:1 VC:self.VC reloadData:^{
        !wSelf.reloadData?:wSelf.reloadData();
    }];
    
}
#pragma mark ---- *  点击商品购物车  根据商品id
/**
 *  点击商品购物车  根据商品id
 */
- (void)goodsViewShopCartAccordingId:(NSString *)goodsId state:(BOOL)state
{
    if (!state) {
        SVProgressError(@"Out of stock");
        return;
    }
    self.addToCartBuyNewViewModel.goodsId = goodsId;
}



@end
