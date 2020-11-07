//
//  XZZCartViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCartViewController.h"

#import "XZZCartListTableViewCell.h"
#import "XZZCartIsEmptyTableViewCell.h"
#import "XZZCartCheckOutButtonView.h"
#import "XZZCartPromptSoldOutGoodsInforView.h"
#import "XZZCartActivityCountdownHeaderView.h"

#import "XZZCartListCouponsView.h"

#import "XZZCheckOutViewController.h"
#import "XZZAddAddressViewController.h"
#import "XZZCheckOutAddressViewController.h"
#import "XZZSecondsKillGoodsListViewController.h"

#import "XZZGoodsListViewController.h"


#define goods_list_count 3

@interface XZZCartViewController ()<UITableViewDelegate, UITableViewDataSource, XZZMyDelegate>
/**
 * <#expression#>
 */
@property (nonatomic, assign)int count;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UITableView * tableView;

/**
 * 下架商品
 */
@property (nonatomic, strong)NSMutableArray * shelvesArray;

/**
 * 活动信息
 */
@property (nonatomic, strong)NSMutableArray * activityArray;

/**
 * 活动商品
 */
@property (nonatomic, strong)NSMutableDictionary * activityDic;

/**
 * 未下架商品
 */
@property (nonatomic, strong)NSMutableArray * noShelvesArray;
/**
 * 关联商品信息
 */
@property (nonatomic, strong)NSMutableArray * recommendedGoodsArray;

/**
 * 按钮
 */
@property (nonatomic, strong)XZZCartCheckOutButtonView * checkOutButtonView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCartListCouponsView * remindView;

/**
 * 弹框 加购
 */
@property (nonatomic, strong)XZZAddCartAndBuyNewViewModel * addCartAndBuyNewViewModel;


/**
 * 是否刷新数据  yes 不刷新  no 刷新
 */
@property (nonatomic, assign)BOOL isNoRefresh;

@end

@implementation XZZCartViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.count = 0;
    [XZZBuriedPoint cartPage];
    if (self.navigationController.viewControllers.count > 1) {
        UIButton * leftButton = [UIButton allocInitWithFrame:CGRectMake(0, 0, 50, 40)];
        [leftButton setImage:imageName(@"nav_back") forState:(UIControlStateNormal)];
        [leftButton setImage:imageName(@"nav_back") forState:(UIControlStateHighlighted)];
        [leftButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        [leftButton setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
        leftButton.titleLabel.font = textFont(14);
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);//
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    }
    [self shoppingCartDataProcessing];
    if (!self.isNoRefresh) {
        [self dataDownload];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartDataProcessing) name:@"numberShoppingCartsHasChanged" object:nil];
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dataDownload
{
    WS(wSelf)
    [all_cart getAllCartHttpBlock:^(id data, BOOL successful, NSError *error) {
        [wSelf shoppingCartDataProcessing];
    }];
}

- (void)shoppingCartDataProcessing
{
    [self.shelvesArray removeAllObjects];
    [self.noShelvesArray removeAllObjects];
    [self.activityArray removeAllObjects];
    [self.activityDic removeAllObjects];
    self.isNoRefresh = NO;
    for (XZZCartInfor * cartInfor in all_cart.allCartArray) {
        if (cartInfor.status == 1) {
            if (cartInfor.activityVo.isShow) {
                NSMutableArray * array = self.activityDic[cartInfor.activityVo.activityId];
                if (!array) {
                    array = [NSMutableArray array];
                    [self.activityDic setValue:array forKey:cartInfor.activityVo.activityId];
                    [self.activityArray addObject:cartInfor.activityVo];
                }
                [array addObject:cartInfor];
            }else if(cartInfor.secKillVo){
                NSMutableArray * array = self.activityDic[@"secKillVo"];
                if (!array) {
                    array = [NSMutableArray array];
                    [self.activityDic setValue:array forKey:@"secKillVo"];
                    [self.activityArray addObject:cartInfor.secKillVo];
                }
                [array addObject:cartInfor];
            }else{
                [self.noShelvesArray addObject:cartInfor];
            }
        }else{
            cartInfor.secKillVo = nil;
            cartInfor.activityVo = nil;
            [self.shelvesArray addObject:cartInfor];
        }
    }
    if (User_Infor.isLogin) {
        [all_cart.allCartArray removeAllObjects];
        for (XZZActivityInfor * activityInfor in self.activityArray) {
            NSString * key = nil;
            if ([activityInfor isKindOfClass:[XZZSecKillVo class]]) {
                key = @"secKillVo";
            }else{
                key = activityInfor.activityId;
            }
            NSArray * array = self.activityDic[key];
            [all_cart.allCartArray addObjectsFromArray:array];
        }
        [all_cart.allCartArray addObjectsFromArray:self.noShelvesArray];
        [all_cart.allCartArray addObjectsFromArray:self.shelvesArray];
        
    }
    

    
    
    self.remindView.isAn = NO;
    self.myTitle = @"Cart";
    if (all_cart.allCartArray.count) {
        self.myTitle = [NSString stringWithFormat:@"Cart(%lu)", (unsigned long)all_cart.allCartArray.count];
        CGFloat buttonHight = 70;
        if (self.navigationController.viewControllers.count > 1 && StatusRect.size.height > 20) {
            buttonHight += bottomHeight;
        }
        self.myTitle = @"Shopping Bag";
        self.checkOutButtonView.hidden = NO;
        [self calculatePriceInfor];
        [self.checkOutButtonView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(buttonHight));
        }];
        self.remindView.hidden = NO;
        [self.remindView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
        }];
    }else{
        self.checkOutButtonView.hidden = YES;
        
        [self.checkOutButtonView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.remindView.hidden = YES;
        [self.remindView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
    
    [self.tableView reloadData];
}
#pragma mark ----计算价格信息
/**
 *  计算价格信息
 */
- (void)calculatePriceInfor
{
    self.checkOutButtonView.priceLabel.text = [NSString stringWithFormat:@"$%.2f", all_cart.allSelectedCartPrice];
    self.checkOutButtonView.selectAllButton.selected = [all_cart determinesWhetherAllAreSelected];
    self.myTitle = [NSString stringWithFormat:@"Cart(%lu)", (unsigned long)all_cart.allCartArray.count];
}


#pragma mark ----*  下载推荐商品
/**
 *  下载推荐商品
 */
- (void)downloadRelatedProducts
{
    WS(wSelf)
    
    XZZRequestCategoryGoods * categoryGoods = [XZZRequestCategoryGoods allocInit];
    categoryGoods.orderBy = 2;
    categoryGoods.pageSize = 60;
    categoryGoods.pageNum = 1;
    [XZZDataDownload goodsGetCategoryGoods:categoryGoods httpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            [wSelf.recommendedGoodsArray removeAllObjects];
            [wSelf.recommendedGoodsArray addObjectsFromArray:data];
            if (all_cart.allCartArray.count == 0) {
                [wSelf.tableView reloadData];
            }
        }else{
            
        }
    }];
}

- (XZZAddCartAndBuyNewViewModel *)addCartAndBuyNewViewModel
{
    if (!_addCartAndBuyNewViewModel) {
        XZZAddCartAndBuyNewViewModel * addCartAndBuyNewViewModel = [XZZAddCartAndBuyNewViewModel allocInit];
        addCartAndBuyNewViewModel.VC = self;
        self.addCartAndBuyNewViewModel = addCartAndBuyNewViewModel;
    }
    return _addCartAndBuyNewViewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myTitle = @"Cart";
    self.nameVC = @"购物车";
    
    self.shelvesArray = @[].mutableCopy;
    self.noShelvesArray = @[].mutableCopy;
    self.activityArray = @[].mutableCopy;
    self.activityDic = @{}.mutableCopy;
    self.recommendedGoodsArray = @[].mutableCopy;
    
    WS(wSelf)
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStyleGrouped)];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = YES;
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //    self.tableView.estimatedRowHeight = 100;
    //    self.tableView.estimatedSectionHeaderHeight = 0;
    //    self.tableView.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.view);
    }];
    if (My_Basic_Infor.cartTopRemindList.count > 0) {
        XZZCartListCouponsView * remindView = [XZZCartListCouponsView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
        remindView.backgroundColor = BACK_COLOR;
        [self.view addSubview:remindView];
        self.remindView = remindView;
        [remindView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@0);
            make.width.equalTo(@(ScreenWidth));
            make.height.equalTo(@45);
            make.bottom.equalTo(wSelf.tableView.mas_top);
        }];
    }else{
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
        }];
    }
    
    
    
    CGFloat buttonHight = 45;
    if (self.navigationController.viewControllers.count > 1 && StatusRect.size.height > 20) {
        buttonHight += bottomHeight;
    }
    
    self.checkOutButtonView = [XZZCartCheckOutButtonView allocInit];
    [self.checkOutButtonView setCheckOnt:^{
        NSLog(@"%s %d 行", __func__, __LINE__);
        [wSelf checkOut];
    }];
    [self.checkOutButtonView setSelectAll:^{
        NSLog(@"%s %d 行", __func__, __LINE__);
        [wSelf selectAllCartInfor];
    }];
    [self.view addSubview:self.checkOutButtonView];
    [self.checkOutButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(wSelf.view);
        make.top.equalTo(wSelf.tableView.mas_bottom);
        //        make.height.equalTo(@(0));
    }];
    
    
    [self downloadRelatedProducts];
    
    [self addChatAndActivityFloatWindow];
}

#pragma mark ----*  下单
/**
 *  下单
 */
- (void)checkOut{
    
    NSArray * cartArray = all_cart.getSelectedCartArray;
    if (cartArray.count <= 0) {
        SVProgressError(@"Please select one item")
        return;
    }
    [XZZBuriedPoint clickCheckout];
    if (!User_Infor.isLogin) {
        logInVC(self);
        self.isNoRefresh = YES;
        return;
    }
    
    
    NSMutableArray * array = @[].mutableCopy;
    NSMutableDictionary * cartDic = @{}.mutableCopy;
    for (XZZCartInfor * cartInfor in all_cart.getSelectedCartArray) {
        [cartDic setObject:cartInfor forKey:cartInfor.ID];
        [array addObject:cartInfor.ID];
    }
    WS(wSelf)
    
    loadView(self.view)
    [XZZDataDownload cartGetSkuInforSkuIDs:array httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {

            [wSelf processSkuInformation:data];
            
        }else{
            SVProgressError(@"Try again later");
        }
    }];
}

#pragma mark ---- 处理sku信息
/**
 * #pragma mark ---- 处理sku信息
 */
- (void)processSkuInformation:(NSArray *)skuList
{
//    NSArray * skus = [all_cart skuSorting:skuList];
    NSArray * skus = skuList;
    NSMutableArray * soldOutArray = @[].mutableCopy;
    NSMutableArray<XZZCartInfor *> * cartList = @[].mutableCopy;
    NSMutableDictionary * cartDic = @{}.mutableCopy;
    NSMutableArray * cartChangeArray = @[].mutableCopy;
    for (XZZCartInfor * cartInfor in all_cart.getSelectedCartArray) {
        [cartDic setObject:cartInfor forKey:cartInfor.ID];
    }
    for (XZZSku * sku in skus) {
        if (sku.status == 0) {
            [soldOutArray addObject:sku];
        }else{
            XZZCartInfor * cartInfor = cartDic[sku.ID];
            XZZCartInfor * cartInforTwo = [XZZCartInfor cartInforWithSku:sku num:cartInfor.skuNum];
            [cartList addObject:cartInforTwo];
            if (![[NSString stringWithFormat:@"%.2f", cartInfor.skuPrice] isEqualToString:[NSString stringWithFormat:@"%.2f",  cartInforTwo.skuPrice]]) {
                [cartChangeArray addObject:cartInforTwo];
            }
        }
    }
    if (soldOutArray.count == 0) {
        if (cartChangeArray.count) {
            [self dataDownload];
            SVProgressError(@"Please confirm your order before checkout as the price has changed.")
        }else{
            [self enterCheckOutPage:cartList];
        }
    }else{
        [self remindGodosSoldOut:soldOutArray];
    }
}




#pragma mark ---- 提醒商品下架
/**
 * #pragma mark ---- 提醒商品下架
 */
- (void)remindGodosSoldOut:(NSArray *)soldOutArray
{
    WS(wSelf)
    XZZCartPromptSoldOutGoodsInforView * view = [XZZCartPromptSoldOutGoodsInforView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [view setBlock:^{
        [wSelf dataDownload];
    }];
    view.soldOutSkuArray = soldOutArray;
    [view addSuperviewView];
}

#pragma mark ---- 进入下单页面
/**
 * #pragma mark ---- 进入下单页面
 */
- (void)enterCheckOutPage:(NSArray<XZZCartInfor *>*)cartInforList
{
    XZZCheckOutViewController * checkOutVC = [XZZCheckOutViewController allocInit];
    checkOutVC.cartInforArray = cartInforList;
    checkOutVC.isBuyNow = NO;
    [checkOutVC setHidesBottomBarWhenPushed:YES];
    
    if (User_Infor.addressArray.count <= 0) {
        XZZAddAddressViewController * addAddressVC = [XZZAddAddressViewController allocInit];
        addAddressVC.delegate = checkOutVC;
        [self pushViewController:addAddressVC animated:YES];
        
        NSMutableArray*tempMarr =[NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        
        [tempMarr insertObject:checkOutVC atIndex:tempMarr.count- 1];
        
        [self.navigationController setViewControllers:tempMarr animated:YES];
    }else{
        [self pushViewController:checkOutVC animated:YES];
    }
}

#pragma mark ----*  全选
/**
 *  全选
 */
- (void)selectAllCartInfor
{
    self.checkOutButtonView.selectAllButton.selected = [all_cart allSelectedOrCancel];
    [self.tableView reloadData];
    [self calculatePriceInfor];
}

#pragma mark ---- *  删除购物车
/**
 *  删除购物车
 */
- (void)deleteCartInfor:(XZZCartInfor *)cartInfor
{
    WS(wSelf)
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure to delete this item?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    //确定
    [alert addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%s %d 行", __func__, __LINE__);
        loadView(wSelf.view)
        [all_cart deleteCart:cartInfor httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (successful) {
                SVProgressSuccess(data);
            }else{
                SVProgressError(data);
            }
            //            [wSelf shoppingCartDataProcessing];
        }];
    }]];
    
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
#pragma mark ---- *  选中购物车
/**
 *  选中购物车
 */
- (BOOL)SelectCartInfor:(XZZCartInfor *)cartInfor
{
    BOOL state = [all_cart selectedOrCancelCart:cartInfor];
    [self calculatePriceInfor];
    return state;
}
#pragma mark ---- *  编辑购物车信息
/**
 *  编辑购物车信息
 */
- (void)editCartInfor:(XZZCartInfor *)cartInfor count:(BOOL)count
{
    WS(wSelf)
    [all_cart modifyCart:cartInfor count:count httpBlock:^(id data, BOOL successful, NSError *error) {
        [wSelf calculatePriceInfor];
        if (successful) {
            SVProgressSuccess(data)
        }else{
            SVProgressError(data)
        }
    }];
}
#pragma mark ---- *  对商品进行收藏
/**
 *  对商品进行收藏
 */
- (void)collectGoodsAccordingId:(NSString *)goodsId
{
    WS(wSelf)
    [XZZCommonLogicalInfor goodsCollectionAccordingId:goodsId source:1 VC:self reloadData:^{
        
        [wSelf.tableView reloadData];
    }];
}
#pragma mark ----*  点击商品    进入商品详情使用   State为商品状态  yes为上架  no为下架
/**
 *  点击商品    进入商品详情使用   State为商品状态  yes为上架  no为下架
 */
- (void)clickOnGoodsAccordingId:(NSString *)goodsId state:(BOOL)state
{
    if (!state) {
        SVProgressError(@"Out of stock");
        return;
    }
    NSLog(@"%s %d 行", __func__, __LINE__);
    GoodsDetails(goodsId, self)
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
#pragma mark ----*  进入首页
/**
 *  进入首页
 */
- (void)enterHomePage
{
    self.navigationController.tabBarController.selectedIndex = 0;
    
    [self popToRootViewControllerAnimated:YES];
}

#pragma mark ----- tableView代理方法
#pragma mark ----删除cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[XZZCartListTableViewCell class]]) {
        return YES;
    }
    
    return NO;
}

#pragma mark ---- 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

#pragma mark ---- 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[XZZCartListTableViewCell class]]) {
            XZZCartListTableViewCell * cellTwo = cell;
            [self deleteCartInfor:cellTwo.cartInfor];
        }
    }
}
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (all_cart.allCartArray.count > 0) {
        NSInteger count = self.activityArray.count;
        if (self.shelvesArray.count) {
            count++;
        }
        if (self.noShelvesArray.count) {
            count++;
        }
        return count;
    }
    return 2;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (all_cart.allCartArray.count > 0) {
        if (section < self.activityArray.count) {
            XZZActivityInfor * activityInfor = self.activityArray[section];
            NSString * key = nil;
            if ([activityInfor isKindOfClass:[XZZSecKillVo class]]) {
                key = @"secKillVo";
            }else{
                key = activityInfor.activityId;
            }
            NSArray * array = self.activityDic[key];
            return array.count;
        }
        if (self.noShelvesArray.count > 0 && section == self.activityArray.count) {
            return self.noShelvesArray.count;
        }
        return self.shelvesArray.count;
    }
    if (section == 0) {
        return 1;
    }
    return (self.recommendedGoodsArray.count + 2) / 3;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (all_cart.allCartArray.count > 0) {
        XZZCartListTableViewCell * cell = [XZZCartListTableViewCell codeCellWithTableView:tableView];
        if (indexPath.section < self.activityArray.count) {
            XZZActivityInfor * activityInfor = self.activityArray[indexPath.section];
            NSString * key = nil;
            if ([activityInfor isKindOfClass:[XZZSecKillVo class]]) {
                key = @"secKillVo";
            }else{
                key = activityInfor.activityId;
            }
            NSArray * array = self.activityDic[key];
            cell.cartInfor = array[indexPath.row];
        }else if (self.noShelvesArray.count > indexPath.row && indexPath.section == self.activityArray.count) {
            cell.cartInfor = self.noShelvesArray[indexPath.row];
        }else{
            if (self.shelvesArray.count > indexPath.row) {
                cell.cartInfor = self.shelvesArray[indexPath.row];
            }
        }
        cell.delegate = self;
        return cell;
    }
    
    if (indexPath.section == 0) {
        XZZCartIsEmptyTableViewCell * cell = [XZZCartIsEmptyTableViewCell codeCellWithTableView:tableView];
        [cell addView];
        cell.delegate = self;
        return cell;
    }
    
    XZZGoodsListCell * cell = [XZZGoodsListCell codeCellWithTableView:tableView];
    cell.goodsViewDisplay = XZZGoodsViewDisplayRecommendedGoodsList;
    cell.count = goods_list_count;
    cell.delegate = self;
    cell.cartHidden = YES;
    cell.collectionHidden = YES;
    static NSMutableArray * array = nil;
    if (!array) {
        array = @[].mutableCopy;
    }
    [array removeAllObjects];
    NSInteger count = indexPath.row * goods_list_count;
    for (int i = 0; i < goods_list_count; i++) {
        if (count < self.recommendedGoodsArray.count) {
            [array addObject:self.recommendedGoodsArray[count]];
        }else{
            break;
        }
        count++;
    }
    cell.goodsArray = array.mutableCopy;
    //    cell.backgroundColor = BACK_COLOR;
    return cell;
}

#pragma mark ----- 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (all_cart.allCartArray.count > 0) {
        return 153;
    }
    if (indexPath.section == 0) {
        return 300;
    }
    return [XZZGoodsListCell calculateCellHeight:goods_list_count];
}

#pragma mark ---- 设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (all_cart.allCartArray.count > 0) {
        if (section < self.activityArray.count) {
            return 45;
        }else if (section == self.activityArray.count && self.noShelvesArray.count > 0){
            return 1;
        }
        return 30;
    }
    if (section == 1) {
        if (all_cart.allCartArray.count > 0) {
            return 30;
        }
        return 40;
    }
    return 1;
}
#pragma mark ---- 设置区头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (all_cart.allCartArray.count > 0) {
        if (section < self.activityArray.count) {
            WS(wSelf)
            XZZCartActivityCountdownHeaderView * view = [XZZCartActivityCountdownHeaderView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
            view.activityOrSecKillInfor = self.activityArray[section];
            [view setRefreshBlock:^{
                if (wSelf.count < 5) {
                    wSelf.count++;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [wSelf dataDownload];
                    });
                }
            }];
            [view setViewActivityGoodsInfor:^(XZZActivityInfor * activity) {
                [wSelf viewActivityGoodsListAccordingActivityId:activity];
            }];
            return view;
        }else if (section == self.activityArray.count && self.noShelvesArray.count > 0){
            UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
            view.backgroundColor = [UIColor whiteColor];
            return view;
        }
    }else if(section == 0){
        UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    
    
    
    
    
    UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(40,0,200,view.height);
    label.numberOfLines = 0;
    [view addSubview:label];
    
    if (all_cart.allCartArray.count > 0) {
        view.height = 30;
        label.height = view.height;
        label.text = @"Unavailable Items";
        label.textColor = kColor(0x999999);
        UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, view.height - .5, ScreenWidth, .5)];
        dividerView.backgroundColor = DIVIDER_COLOR;
        //            [view addSubview:dividerView];
    }else{
        label.textColor = kColor(0x000000);
        label.left = 15;
        label.text = @"You might Also Like";
    }
    return view;
    
}
#pragma mark ---- 设置区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (all_cart.allCartArray.count > 0) {
        if (section == self.activityArray.count - 1) {
            return 20;
        }else{
            return 10;
        }
    }
    
    if (section == 1) {
        return 1;
    }
    return 10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (all_cart.allCartArray.count > 0) {
        UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 10 )];
        view.backgroundColor = BACK_COLOR;
        
        
        if (section == self.activityArray.count - 1) {
            view.height = 20;
        }else{
            view.height = 10;
        }
        return view;
    }
    
    
    if (section == 1) {
        UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 1 )];
        view.backgroundColor = BACK_COLOR;
        return view;
        
    }
    
    UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 10 )];
    view.backgroundColor = BACK_COLOR;
    return view;
    
}
#pragma mark ----- 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[XZZCartListTableViewCell class]]) {
        XZZCartListTableViewCell * cellTwo = cell;
        if (cellTwo.cartInfor.status == 1) {
            GoodsDetails(cellTwo.cartInfor.goodsId, self)
        }else{
            SVProgressError(@"Out of stock");
        }
        
    }
    
    
    
    
}
#pragma mark ----- tableView代理结束


- (void)viewActivityGoodsListAccordingActivityId:(XZZActivityInfor *)activity
{
    
    if ([activity isKindOfClass:[XZZSecKillVo class]]) {
        XZZSecondsKillGoodsListViewController * secKillGoodsListVC = [XZZSecondsKillGoodsListViewController allocInit];
        secKillGoodsListVC.myTitle = @"Flash Deals";
        [self pushViewController:secKillGoodsListVC animated:YES];
    }else{
        XZZGoodsListViewController * goodsListVC = [XZZGoodsListViewController allocInit];
        goodsListVC.myTitle = @"Jolimall";
        goodsListVC.activityId = activity.activityId;
        [self pushViewController:goodsListVC animated:YES];
    }
}

@end
