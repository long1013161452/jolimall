//
//  XZZGoodsListViewModel.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/2.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZGoodsListViewModel.h"

#import "XZZCollectionIsEmptyTableViewCell.h"

@interface XZZGoodsListViewModel ()<XZZMyDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewViewModel * addCartAndBuyNewViewModel;

@end

@implementation XZZGoodsListViewModel

+ (instancetype)allocInit
{
    XZZGoodsListViewModel * model = [super allocInit];
    model.collectionHidden = YES;
    model.goodsViewDisplay = XZZGoodsViewDisplayGoodsList;
    return model;
}

- (XZZAddCartAndBuyNewViewModel *)addCartAndBuyNewViewModel
{
    if (!_addCartAndBuyNewViewModel) {
        XZZAddCartAndBuyNewViewModel * addCartAndBuyNewViewModel = [XZZAddCartAndBuyNewViewModel allocInit];
        addCartAndBuyNewViewModel.VC = self.VC;
        self.addCartAndBuyNewViewModel = addCartAndBuyNewViewModel;
    }
    return _addCartAndBuyNewViewModel;
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
    self.addCartAndBuyNewViewModel.goodsId = goodsId;
}
#pragma mark ---- *  点击商品    进入商品详情使用
/**
 *  点击商品    进入商品详情使用
 */
- (void)clickOnGoodsAccordingId:(NSString *)goodsId state:(BOOL)state
{
    if (!state) {
        SVProgressError(@"Out of stock");
        return;
    }
    GoodsDetails(goodsId, self.VC)
}

#pragma mark ----自定义代理结束
#pragma mark ----- tableView代理方法
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableHeardArray.count > 0 ? self.tableHeardArray.count : 1;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == self.tableHeardArray.count - 1 || self.tableHeardArray.count == 0) {
        if (self.goodsArray.count <= 0) {
            if (self.hideEmpty) {
                return 0;
            }
            return 1;
        }
        return (self.goodsArray.count + self.goods_list_count - 1) / self.goods_list_count;
    }
    return 0;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.goodsArray.count <= 0) {
        XZZCollectionIsEmptyTableViewCell * cell = [XZZCollectionIsEmptyTableViewCell codeCellWithTableView:tableView];
//        [cell addView];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    XZZGoodsListCell * cell = [XZZGoodsListCell codeCellWithTableView:tableView];
    cell.goodsViewDisplay = self.goodsViewDisplay;
    cell.count = self.goods_list_count;
    cell.delegate = self;
    cell.cartHidden = self.cartHidden;
    cell.collectionHidden = self.collectionHidden;
    static NSMutableArray * array = nil;
    if (!array) {
        array = @[].mutableCopy;
    }
    [array removeAllObjects];
    NSInteger count = indexPath.row * self.goods_list_count;
    for (int i = 0; i < self.goods_list_count; i++) {
        if (count < self.goodsArray.count) {
            [array addObject:self.goodsArray[count]];
        }else{
            break;
        }
        count++;
    }
    cell.goodsArray = array.mutableCopy;
    cell.backgroundColor = self.cellBackColor ? self.cellBackColor : BACK_COLOR;
    return cell;
}
#pragma mark ----- 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XZZGoodsListCell calculateCellHeight:self.goods_list_count];
}
#pragma mark ---- 设置区头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.tableHeardArray.count == 0) {
        return nil;
    }
    return self.tableHeardArray[section];
}
#pragma mark ---- 设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.tableHeardArray.count == 0) {
        return 0.001;
    }
    UIView * view = self.tableHeardArray[section];
    return view.height;
}
#pragma mark ----- tableView代理结束












@end
