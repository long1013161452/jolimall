//
//  XZZCheckOutGoodsAndPriceInforView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCheckOutGoodsAndPriceInforView.h"

#import "XZZCheckOutOrderGoodsView.h"
#import "XZZCheckOutChooseCouponsView.h"

@interface XZZCheckOutGoodsAndPriceInforView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * titleLabel;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * priceLabel;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * anImageView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutChooseCouponsView * promoCodeView;

/**
 * 商品总价
 */
@property (nonatomic, strong)UIView * subtotalView;

/**
 * 商品总价
 */
@property (nonatomic, strong)UILabel * subtotalLabel;

/**
 * 运费
 */
@property (nonatomic, strong)UIView * shippingView;
/**
 * 运费
 */
@property (nonatomic, strong)UILabel * shippingLabel;

/**
 * 折扣
 */
@property (nonatomic, strong)UIView * discountView;
/**
 * 折扣
 */
@property (nonatomic, strong)UILabel * discountLabel;

/**
 * 利润
 */
@property (nonatomic, strong)UIView * profitView;
/**
 * 利润
 */
@property (nonatomic, strong)UILabel * profitLabel;

/**
 * 支付价格
 */
@property (nonatomic, strong)UIView * totalView;
/**
 * 支付价格
 */
@property (nonatomic, strong)UILabel * totalLabel;

/**
 * 商品视图是否展开
 */
@property (nonatomic, assign)BOOL isGoodsViewAn;


@end

@implementation XZZCheckOutGoodsAndPriceInforView

- (void)setCartInforArray:(NSArray *)cartInforArray
{
    _cartInforArray = cartInforArray;
    self.isGoodsViewAn = NO;
    [self addView];
}


- (void)addView{
    
    [self removeAllSubviews];
    WS(wSelf)
    self.backgroundColor = [UIColor whiteColor];
    UIView * titleView = [UIView allocInit];
    [titleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandProductInformation)]];
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(@48);
    }];
//    return;
    weakView(weak_titleView, titleView)
    UIImageView * imageView = [UIImageView allocInit];
    imageView.image = imageName(@"my_order");
    [titleView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.centerY.equalTo(weak_titleView);
        make.width.equalTo(@13);
        make.height.equalTo(@16);
    }];
    
    weakView(weak_imageView, imageView)
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    titleLabel.text = @"Show order summary";
    self.titleLabel = titleLabel;
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_imageView.mas_right).offset(2);
        make.centerY.equalTo(weak_titleView);
    }];
    
    weakView(weak_titleLabel, titleLabel);
    UIImageView * anImageView = [UIImageView allocInit];
    anImageView.image = imageName(@"goods_details_an");
    [titleView addSubview:anImageView];
    self.anImageView = anImageView;
    [anImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weak_titleView).offset(1);
        make.width.equalTo(@10);
        make.height.equalTo(@5.5);
        make.left.equalTo(weak_titleLabel.mas_right).offset(4);
    }];
    
    UILabel * priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:Selling_price_color textFont:14 textAlignment:(NSTextAlignmentRight) tag:1];
    priceLabel.font = textFont_bold(14);
    [titleView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weak_titleView);
        make.right.equalTo(wSelf).offset(-10);
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [titleView addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(weak_titleView);
        make.height.equalTo(@.5);
    }];
    
    self.backView = [UIView allocInit];
    self.backView.layer.masksToBounds = YES;
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_titleView.mas_bottom);
        make.left.right.bottom.equalTo(wSelf);
        make.height.equalTo(@0);
    }];
    
    
    UIView * topView = nil;
    for (XZZCartInfor * cartInfor in self.cartInforArray) {
        weakView(weak_topView, topView)
        XZZCheckOutOrderGoodsView * goodsView = [XZZCheckOutOrderGoodsView allocInit];
        goodsView.cartInfor = cartInfor;
        [self.backView addSubview:goodsView];
        [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf.backView);
            if (weak_topView) {
                make.top.equalTo(weak_topView.mas_bottom);
            }else{
                make.top.equalTo(@5);
            }
        }];
        topView = goodsView;
    }
    
//    if (!my_AppDelegate.iskol) {
        weakView(weak_topView, topView)
        self.promoCodeView = [XZZCheckOutChooseCouponsView allocInit];
        [self.promoCodeView setChooseCouponBlock:^{
            !wSelf.chooseCouponsInfor?:wSelf.chooseCouponsInfor();
        }];
        topView = self.promoCodeView;
        [self.backView addSubview:self.promoCodeView];
        [self.promoCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf.backView);
            make.top.equalTo(weak_topView.mas_bottom).offset(5);
            make.height.equalTo(@55);
        }];
        topView = self.promoCodeView;
        weakView(weak_topView2, topView)
        UIView * dividerView2 = [UIView allocInit];
        dividerView2.backgroundColor = DIVIDER_COLOR;
        [self.backView addSubview:dividerView2];
        [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf);
            make.top.equalTo(weak_topView2.mas_bottom).offset(-.5);
            make.height.equalTo(@.5);
        }];
        topView = dividerView2;

    weakView(weak_topView3, topView)

    
    CGFloat height = 25;

    
    self.subtotalLabel = [self priceInforTitle:@"Sub Total" textColor:kColor(0x000000) font:textFont(12)];
    self.subtotalView = self.subtotalLabel.superview;
    [self.subtotalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_topView3.mas_bottom);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@(height));
    }];
    
    self.shippingLabel = [self priceInforTitle:@"Shipping" textColor:kColor(0x000000) font:textFont(12)];
    self.shippingView = self.shippingLabel.superview;
    [self.shippingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo( wSelf.subtotalView.mas_bottom);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@(height));
    }];
    
    self.discountLabel = [self priceInforTitle:@"Discount" textColor:kColor(0x000000) font:textFont(12)];
    self.discountView = self.discountLabel.superview;
    [self.discountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.shippingView.mas_bottom);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@(height));
    }];

    
    self.profitLabel = [self priceInforTitle:@"Profit" textColor:kColor(0x000000) font:textFont(12)];
    self.profitView = self.profitLabel.superview;
    [self.profitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.discountView.mas_bottom);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@(height));
    }];
    
    
    self.totalLabel = [self priceInforTitle:@"Total" textColor:kColor(0x000000) font:textFont_bold(14)];
    self.totalLabel.font = textFont_bold(14);
    self.totalView = self.totalLabel.superview;
    [self.totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.profitView.mas_bottom).offset(5);
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@30);
//        make.bottom.equalTo(wSelf.backView);
    }];
    
    
}

- (void)shutDownProductInformation
{
    self.isGoodsViewAn = NO;
    
    self.titleLabel.text = !self.isGoodsViewAn ? @"Show order summary" : @"Hide order summary";
    
    [UIView animateWithDuration:.3 animations:^{
        self.anImageView.image = !self.isGoodsViewAn ? imageName(@"goods_details_an") : imageName(@"goods_details_up");
    }];
    
    [self dynamicChangesRefreshView];
}

- (void)expandProductInformation
{
    self.isGoodsViewAn = !self.isGoodsViewAn;
    
    self.titleLabel.text = !self.isGoodsViewAn ? @"Show order summary" : @"Hide order summary";
    
    [UIView animateWithDuration:.3 animations:^{
        self.anImageView.image = !self.isGoodsViewAn ? imageName(@"goods_details_an") : imageName(@"goods_details_up");
    }];
    
    [self dynamicChangesRefreshView];
}

- (void)dynamicChangesRefreshView
{
    WS(wSelf)
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat height = self.isGoodsViewAn ? self.totalView.bottom : 0;
        NSLog(@"===-----===== %f", height);
        
        [UIView animateWithDuration:.3 animations:^{
            [wSelf.backView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(height));
            }];
        } completion:^(BOOL finished) {
            !wSelf.reloadView?:wSelf.reloadView();
        }];
    });
    
}

- (void)setIsHiddenCoupon:(BOOL)isHiddenCoupon
{
    _isHiddenCoupon = isHiddenCoupon;
    if (isHiddenCoupon) {
        [self.promoCodeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.promoCodeView.hidden = YES;
    }else{
        [self.promoCodeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@55);
        }];
        self.promoCodeView.hidden = NO;
    }
}

- (void)setPriceInfor:(XZZOrderPriceInfor *)priceInfor
{
    _priceInfor = priceInfor;
    CGFloat height = 25;
    if (priceInfor.discount <= 0) {
        [self.discountView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.discountView.hidden = YES;
    }else{
        [self.discountView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height));
        }];
        self.discountView.hidden = NO;
    }
    
    if (priceInfor.profit <= 0) {
        [self.profitView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.profitView.hidden = YES;
    }else{
        [self.profitView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height));
        }];
        self.profitView.hidden = NO;
    }
    if (self.isShowShipping) {
        /***  运费 */
        self.shippingLabel.text = [NSString stringWithFormat:@"$%.2f", priceInfor.postFeePrice];
    }else{
        self.shippingLabel.text = @"Calculated at next step";
    }
    
    self.discountLabel.text = [NSString stringWithFormat:@"-$%.2f", priceInfor.discount];
    /***  支付金额 */
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", priceInfor.payTotal];

    self.profitLabel.text = [NSString stringWithFormat:@"$%.2f", priceInfor.profit];
    self.subtotalLabel.text = [NSString stringWithFormat:@"$%.2f", priceInfor.skuTotal];
    self.priceLabel.text = [NSString stringWithFormat:@"$%.2f", priceInfor.payTotal];
    
    if (self.isGoodsViewAn) {
        [self dynamicChangesRefreshView];
    }
    
}



- (UILabel *)priceInforTitle:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font
{
    UIView * view = [UIView allocInit];
    [self.backView addSubview:view];
    weakView(weak_view, view)
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:textColor textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    titleLabel.text = title;
    titleLabel.font = font;
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.bottom.equalTo(weak_view);
    }];
    
    UILabel * priceLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:textColor textFont:10 textAlignment:(NSTextAlignmentRight) tag:1];
    priceLabel.font = font;
    [view addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_view).offset(-11);
        make.top.bottom.equalTo(weak_view);
    }];
    return priceLabel;
    
}



@end
