//
//  XZZAddCartAndBuyNewViewModel.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/9.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZAddCartAndBuyNewViewModel.h"

#import "XZZCartViewController.h"
#import "XZZAddAddressViewController.h"
#import "XZZCheckOutViewController.h"
#import "XZZCheckOutAddressViewController.h"

#import "XZZSizeTypeImageView.h"


@interface XZZAddCartAndBuyNewViewModel ()

/**
 * 商品信息
 */
@property (nonatomic, strong)XZZGoodsDetails * goodsInfor;
/**
 * 选中的颜色
 */
@property (nonatomic, weak)XZZColor * selectedColor;

/**
 * 选中的尺码
 */
@property (nonatomic, weak)XZZSize * selectedSize;
/**
 * 选中的sku
 */
@property (nonatomic, strong)XZZSku * selectedSku;


@end

@implementation XZZAddCartAndBuyNewViewModel


- (void)setGoodsId:(NSString *)goodsId
{
    _goodsId = goodsId;
    loadView(nil)
    WS(wSelf)
    /***  下载购物车信息 */
    [XZZDataDownload goodsGetGoodsDetails:goodsId entrance:@"list" httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        wSelf.goodsInfor = data;
        wSelf.addCartAndBuyNewView.goods = data;
//        XZZSize * size = wSelf.goodsInfor.skuVo.goodsSize;
//        XZZColor * color = wSelf.goodsInfor.skuVo.goodsColor;
//        [wSelf.addCartAndBuyNewView selectedColor:[wSelf.goodsInfor.colorInforArray firstObject] size:[wSelf.goodsInfor.sizeInforArray firstObject]];
        [wSelf.addCartAndBuyNewView addSuperviewView];
        
        [wSelf shoppingCartQuantity];
        
        if (!successful) {
            [wSelf.addCartAndBuyNewView whetherCanAddShoppingCartAndBuy:YES];
        }
    }];
}

- (void)shoppingCartQuantity
{
    if (all_cart.allCartArray.count == 0) {
        self.addCartAndBuyNewView.addCartAndBuyButtonView.cartNumLabel.hidden = YES;
    }else{
        self.addCartAndBuyNewView.addCartAndBuyButtonView.cartNumLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)all_cart.allCartArray.count];
        self.addCartAndBuyNewView.addCartAndBuyButtonView.cartNumLabel.hidden = NO;
    }
}

- (XZZAddCartAndBuyNewView *)addCartAndBuyNewView
{
    if (!_addCartAndBuyNewView) {
        WS(wSelf)
        self.addCartAndBuyNewView = [XZZAddCartAndBuyNewView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [_addCartAndBuyNewView setAddToCart:^{
            [wSelf addToCartNum:wSelf.addCartAndBuyNewView.numLabel.text.intValue whetherReadSku:YES];
        }];
        [_addCartAndBuyNewView setGoCart:^{
            [wSelf goToCartVC:wSelf.VC];
        }];
        [_addCartAndBuyNewView setBuyNew:^{
            [wSelf buyNewNum:wSelf.addCartAndBuyNewView.numLabel.text.intValue whetherReadSku:YES];
        }];
        [_addCartAndBuyNewView setSelectedSize:^(XZZSize * _Nonnull size) {
            wSelf.selectedSize = size;
        }];
        [_addCartAndBuyNewView setSelectedColor:^(XZZColor * _Nonnull color) {
            wSelf.selectedColor = color;
        }];
        [_addCartAndBuyNewView setSizeGuide:^{
            XZZSizeTypeImageView * sizeTypeView = [XZZSizeTypeImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            sizeTypeView.transparentLayerView.backgroundColor = [UIColor clearColor];
            sizeTypeView.imageUrl = wSelf.goodsInfor.goods.sizeTypeCodePicture;
            [sizeTypeView addSuperviewView];
        }];
    }
    return _addCartAndBuyNewView;
}

#pragma mark ----*  选中的颜色赋值
/**
 *  选中的颜色赋值
 */
- (void)setSelectedColor:(XZZColor *)selectedColor
{
    _selectedColor = selectedColor;
    [self getSkuInforHttpBlock:nil];
}
#pragma mark ----*  选中尺寸赋值
/**
 *  选中尺寸赋值
 */
- (void)setSelectedSize:(XZZSize *)selectedSize
{
    _selectedSize = selectedSize;
    
    [self getSkuInforHttpBlock:nil];
}
#pragma mark ----*  选中的sku赋值
/**
 *  选中的sku赋值
 */
- (void)setSelectedSku:(XZZSku *)selectedSku
{
    _selectedSku = selectedSku;
    self.addCartAndBuyNewView.selectedSku = selectedSku;
    [self.addCartAndBuyNewView whetherCanAddShoppingCartAndBuy:selectedSku.status];
}

#pragma mark ----*  获取sku信息
/**
 *  获取sku信息
 */
- (void)getSkuInforHttpBlock:(HttpBlock)httpBlock
{
    if (!self.selectedSize) {
        return;
    }
    if (!self.selectedColor) {
        return;
    }
    
    self.selectedSku = [self.goodsInfor accordingColor:self.selectedColor size:self.selectedSize];
    !httpBlock?:httpBlock(self.selectedSku, self.selectedSku, nil);
}
#pragma mark ----*  加载弹出框
/**
 *  加载弹出框
 */
- (void)handlePopupsButtonType:(XZZAddCartAndBuyNewButtonType)buttonType
{
//    if (!self.selectedColor) {
//        self.selectedColor = [self.goodsInfor.colorInforArray firstObject];
//    }
//    if (!self.selectedSize) {
//        self.selectedSize = [self.goodsInfor.sizeInforArray firstObject];
//    }
//    if (!self.selectedSku) {
//        [self getSkuInforHttpBlock:nil];
//    }
    
    self.addCartAndBuyNewView.buttonType = buttonType;
//    [self.addCartAndBuyNewView selectedColor:self.selectedColor size:self.selectedSize];
}


- (void)addToCartNum:(int)num whetherReadSku:(BOOL)whetherReadSku
{
    if (!self.selectedColor) {
        SVProgressError(@"Please choose color")
        return;
    }
    if (!self.selectedSize) {
        SVProgressError(@"Please choose size")
        return;
    }
    if (self.selectedSku.status != 1) {
        SVProgressError(@"Out of stock")
        return;
    }
    loadView(nil)
    WS(wSelf)
    if (whetherReadSku) {
        [XZZDataDownload cartGetSkuInforSkuIDs:@[self.selectedSku.ID] httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (successful) {
                NSArray * array = data;
                if ([array isKindOfClass:[NSArray class]]) {
                    wSelf.selectedSku = [array firstObject];
                    [wSelf addToCartNum:num whetherReadSku:NO];
                }
            }else{
                SVProgressError(@"Out of stock")
                [wSelf.addCartAndBuyNewView whetherCanAddShoppingCartAndBuy:NO];
            }
        }];
        
        return;
    }
    [self getSkuInforHttpBlock:^(id data, BOOL successful, NSError *error) {
        [wSelf addToCartSKU:wSelf.selectedSku goods:wSelf.goodsInfor num:num VC:wSelf.VC];
    }];
    
}


- (void)addToCartSKU:(XZZSku *)sku goods:(XZZGoodsDetails *)goods num:(NSInteger)num VC:(UIViewController *)VC
{
    if (sku.status == 0) {
        SVProgressError(@"Out of stock")
        return;
    }
    WS(wSelf)
    loadView(nil)
    sku.weight = goods.goods.weight;
    XZZCartInfor * cartInfor = [XZZCartInfor cartInforWithSku:sku num:num];
    [all_cart addCart:cartInfor goodsDetails:goods httpBlock:^(id data, BOOL successful, NSError *error) {
        loadViewStop
        if (successful) {
            SVProgressSuccess(data);
            [wSelf.addCartAndBuyNewView removeView];
        }else{
            SVProgressError(data);
        }
    }];
}

- (void)buyNewNum:(int)num whetherReadSku:(BOOL)whetherReadSku
{
    if (!self.selectedColor) {
        SVProgressError(@"Please choose color")
        return;
    }
    if (!self.selectedSize) {
        SVProgressError(@"Please choose size")
        return;
    }
    if (self.selectedSku.status != 1) {
        SVProgressError(@"Out of stock")
        return;
    }
    loadView(nil)
    WS(wSelf)
        [XZZDataDownload cartGetSkuInforSkuIDs:@[self.selectedSku.ID] httpBlock:^(id data, BOOL successful, NSError *error) {
            loadViewStop
            if (successful) {
                NSArray * array = data;
                if ([array isKindOfClass:[NSArray class]]) {
                    wSelf.selectedSku = [array firstObject];
                    [wSelf buyNewSKU:wSelf.selectedSku goods:wSelf.goodsInfor.goods num:num VC:wSelf.VC];
                }
            }else{
                SVProgressError(@"Out of stock")
                [wSelf.addCartAndBuyNewView whetherCanAddShoppingCartAndBuy:NO];
            }
        }];


}

- (void)buyNewSKU:(XZZSku *)sku goods:(XZZGoods *)goods num:(NSInteger)num VC:(UIViewController *)VC
{
    if (sku.status == 0) {
        SVProgressError(@"Out of stock")
        return;
    }
    sku.weight = goods.weight;
    XZZCartInfor * cartInfor = [XZZCartInfor cartInforWithSku:sku num:num];
    cartInfor.goodsCode = goods.code;
    [XZZBuriedPoint aws_buyNow:cartInfor];
    [self.addCartAndBuyNewView removeView];

    if (!User_Infor.isLogin) {
        logInVC(VC);
        return;
    }


    XZZCheckOutViewController * checkOutVC = [XZZCheckOutViewController allocInit];
    checkOutVC.cartInforArray = @[cartInfor];
    checkOutVC.isBuyNow = YES;
    [checkOutVC setHidesBottomBarWhenPushed:YES];
    
    if (User_Infor.addressArray.count <= 0) {
        XZZAddAddressViewController * addAddressVC = [XZZAddAddressViewController allocInit];
        addAddressVC.delegate = checkOutVC;
        [VC pushViewController:addAddressVC animated:YES];
        
        NSMutableArray*tempMarr =[NSMutableArray arrayWithArray:VC.navigationController.viewControllers];
        
        [tempMarr insertObject:checkOutVC atIndex:tempMarr.count- 1];
        
        [VC.navigationController setViewControllers:tempMarr animated:YES];
        
    }else{
        [VC pushViewController:checkOutVC animated:YES];
    }
    
}

- (void)goToCartVC:(UIViewController *)VC
{
    [self.addCartAndBuyNewView removeView];
    if (VC.navigationController.viewControllers.count > 1) {
        [VC pushViewController:[XZZCartViewController allocInit] animated:YES];
    }else{
        VC.tabBarController.selectedIndex = 2;
    }
}


@end
