//
//  XZZGoodsNameAndPriceView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZGoodsNameAndPriceView.h"

#import "XZZStarRateView.h"

#import "XZZActivityInfor.h"

@interface XZZGoodsNameAndPriceView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)dispatch_source_t timer;
/**
 * 倒计时  label  1
 */
@property (nonatomic, strong)UILabel * countdownLabel1;

/**
 * 倒计时  label 2
 */
@property (nonatomic, strong)UILabel * countdownLabel2;

/**
 * 倒计时  label  3
 */
@property (nonatomic, strong)UILabel * countdownLabel3;
/**
 * 倒计时  label  4
 */
@property (nonatomic, strong)UILabel * countdownLabel4;

@end


@implementation XZZGoodsNameAndPriceView

+ (id)allocInitWithFrame:(CGRect)frame
{
    XZZGoodsNameAndPriceView * view = [super allocInitWithFrame:frame];
   
    [view addView];
    return view;
}

- (void)dealloc
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil; // OK
    }
}

- (void)setGoods:(XZZGoodsDetails *)goods
{
    _goods = goods;
    if (self.goods.activityVo.isShow || self.goods.secKillVo) {
        [self addViewTwo];
    }else{
        [self addView];
    }
}

- (void)setScore:(XZZGoodsScore *)score
{
    _score = score;
    if (self.goods) {
        if (self.goods.activityVo.isShow || self.goods.secKillVo) {
            [self addViewTwo];
        }else{
            [self addView];
        }
    }
}

- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf);
       [self removeAllSubviews];
    UILabel * priceLabel = [UILabel labelWithFrame:CGRectMake(10, 0, 80, 30) backColor:nil textColor:kColor(0xFF4444) textFont:19 textAlignment:(NSTextAlignmentLeft) tag:1];
    priceLabel.font = font_bold_22;
    if (!self.goods) {
        [priceLabel addBreathingLampView:YES];
        priceLabel.text = @"          ";
    }else{
        if (self.goods.goods.discountPercent > 0) {
            priceLabel.text = [NSString stringWithFormat:@"$%.2f", self.goods.goods.discountPrice];
        }else{
            priceLabel.text = [NSString stringWithFormat:@"$%.2f", self.goods.goods.currentPrice];
        }
    }
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@15);
        make.height.equalTo(@30);
    }];
    
    weakView(weak_priceLabel, priceLabel)
    UIView * leftView = priceLabel;
    
    UILabel * msrpPriceLabel = [UILabel labelWithFrame:CGRectMake(priceLabel.right + 12, priceLabel.top, 40, 20) backColor:nil textColor:original_price_color textFont:11 textAlignment:(NSTextAlignmentLeft) tag:1];
    msrpPriceLabel.font = font_12;
    [self addSubview:msrpPriceLabel];
    self.msrpPriceLabel = msrpPriceLabel;
    [msrpPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_priceLabel.mas_right).offset(12);
        make.height.equalTo(@20);
        make.centerY.equalTo(weak_priceLabel).offset(2);
    }];
    if (!self.goods) {
        [msrpPriceLabel addBreathingLampView:YES];
        msrpPriceLabel.text = @"        ";
    }else{
        if (self.goods.goods.nominalPrice > 0) {
            msrpPriceLabel.text = [NSString stringWithFormat:@"$%.2f", self.goods.goods.nominalPrice];
            weakView(weak_msrpPriceLabel, msrpPriceLabel)
            UIView * dividerView = [UIView allocInit];
            dividerView.backgroundColor = original_price_color;
            [self addSubview:dividerView];
            [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.centerX.equalTo(weak_msrpPriceLabel);
                make.left.equalTo(weak_msrpPriceLabel).offset(0);
                make.height.equalTo(@.5);
            }];
        }else{
            msrpPriceLabel.text = @"";
        }
    }
        
        leftView = msrpPriceLabel;
    
    
    if (self.score.totalCommentCount > 0) {
        UILabel * numLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 10, 15) backColor:nil textColor:kColor(0xFFA800) textFont:7 textAlignment:(NSTextAlignmentLeft) tag:1];
        numLabel.text = [NSString stringWithFormat:@"(%d)", self.score.totalCommentCount];
        [self addSubview:numLabel];
        [numLabel sizeToFit];
        numLabel.centerY = priceLabel.centerY;
        numLabel.right = ScreenWidth - 10;
        
        UIView * dividerNumView = [UIView allocInitWithFrame:CGRectMake(numLabel.left, numLabel.bottom, numLabel.width, .5)];
        dividerNumView.backgroundColor = numLabel.textColor;
        [self addSubview:dividerNumView];
        
        XZZStarRateView * starRateView = [XZZStarRateView allocInitWithFrame:CGRectMake(numLabel.left - 60, numLabel.top, 60, 15)];
        starRateView.userInteractionEnabled = NO;
        starRateView.currentScore = self.score.averageScore;
        [self addSubview:starRateView];
        starRateView.centerY = numLabel.centerY;
        
        
    }
    
    
    
    
    
    
    weakView(weak_leftView, leftView)
    
    UIButton * shareButton = [UIButton allocInitWithImageName:@"goods_details_share" selectedImageName:@"goods_details_share"];
    [shareButton addTarget:self action:@selector(clickOnShare) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf);
        make.width.equalTo(@40);
    }];
    
    weakView(weak_shareButton, shareButton)
    UIButton * collectionButton = [UIButton allocInitWithImageName:@"list_no_collected" selectedImageName:@"list_already_collected"];
    collectionButton.selected = StateCollectionGoodsId(self.goods.goods.ID);
    [collectionButton addTarget:self action:@selector(clickOnCollection) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:collectionButton];
    self.collectionButton = collectionButton;
    [collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_shareButton.mas_left);
        make.centerY.equalTo(weak_shareButton);
        make.width.equalTo(@40);
    }];
    
    weakView(weak_collectionButton, collectionButton)
    UILabel * nameLabel = [UILabel labelWithFrame:CGRectMake(priceLabel.left, priceLabel.bottom + 10, ScreenWidth - priceLabel.left * 2 - 80, 20) backColor:nil textColor:important_Color_191919 textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    nameLabel.font = font_16;
    if (!self.goods) {
        [nameLabel addBreathingLampView:YES];
        nameLabel.text = @" ";
    }else{
        nameLabel.text = self.goods.goods.title;
    }
    
    nameLabel.numberOfLines = 0;
    [self addSubview:nameLabel];
    [nameLabel changeTheHeightInputInformation];
    CGFloat nameLabelHeight = nameLabel.height + 15;
    nameLabel.height = nameLabelHeight;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_priceLabel);
        make.top.equalTo(weak_priceLabel.mas_bottom).offset(5);
        make.centerY.equalTo(weak_shareButton);
        make.right.equalTo(weak_collectionButton.mas_left).offset(-10);
        make.height.equalTo(@(nameLabelHeight));
    }];
    
    
    
    
    UIView * topView = nameLabel;
    
    //    if (My_Basic_Infor.detailsPageOffer.length > 0) {
    //        weakView(weak_nameLabel, nameLabel)
    //        UIView * backView = [UIView allocInitWithFrame:CGRectMake(priceLabel.left, nameLabel.bottom + 5, 100, 35)];
    //        backView.backgroundColor = kColorWithRGB(255, 68, 68, .1);
    //        [self addSubview:backView];
    //        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.left.equalTo(weak_priceLabel);
    //            make.top.equalTo(weak_nameLabel.mas_bottom).offset(10);
    //            make.height.equalTo(@35);
    //
    //        }];
    //
    //        weakView(weak_backView, backView)
    //        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInit];
    //        imageView.image = imageName(@"goods_details_discount");
    //        [backView addSubview:imageView];
    //        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    ////            make.top.equalTo(@6);
    //            make.width.equalTo(@18);
    //            make.height.equalTo(@18);
    //            make.centerY.equalTo(weak_backView);
    //            make.left.equalTo(@3);
    //        }];
    //
    //        weakView(weak_imageView, imageView)
    //        UILabel * promoCodeLabel = [UILabel labelWithFrame:CGRectMake(0, 00, 0, 0) backColor:nil textColor:kColor(0xFF0000) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    //        promoCodeLabel.text = My_Basic_Infor.detailsPageOffer;
    //        [backView addSubview:promoCodeLabel];
    //        [promoCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.left.equalTo(weak_imageView.mas_right).offset(5);
    //            make.top.bottom.equalTo(weak_backView);
    //            make.right.equalTo(weak_backView).offset(-5);
    //        }];
    //
    //        topView = backView;
    //
    //
    //    }
    weakView(weak_topView, topView)
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, topView.bottom + 10, ScreenWidth, 10)];
    dividerView.backgroundColor = BACK_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf);
        make.top.equalTo(weak_topView.mas_bottom).offset(10);
        make.height.equalTo(@10);
    }];
    
    self.height = dividerView.bottom;
    !self.refresh?:self.refresh();
}

#pragma mark ----  * 创建视图信息  展示商品优惠数据
/**
 * 创建视图信息  展示商品优惠数据
 */
- (void)addViewTwo
{
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
    [self removeAllSubviews];
    
    UIImageView * backView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 54)];
    backView.image = imageName(@"goods_details_sale_bg");
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(@54);
    }];
    
    weakView(weak_backView, backView)
    
    UIImageView * activityBackImageView = [UIImageView allocInit];
    activityBackImageView.image = imageName(@"goods_details_saleprice");
    if (self.goods.secKillVo) {
        activityBackImageView.image = imageName(@"goods_details_secondsKill");
    }
    [backView addSubview:activityBackImageView];
    [activityBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(weak_backView);
    }];
    
    
    weakView(weak_activityBackImageView, activityBackImageView)
    UILabel * priceLabel = [UILabel labelWithFrame:CGRectMake(10, 10, 0, 20) backColor:nil textColor:kColor(0xffffff) textFont:22 textAlignment:(NSTextAlignmentLeft) tag:1];
    priceLabel.font = textFont_bold(22);
    if (self.goods.goods.discountPercent > 0) {
        priceLabel.text = [NSString stringWithFormat:@"$%.2f", self.goods.goods.discountPrice];
    }else{
        priceLabel.text = [NSString stringWithFormat:@"$%.2f", self.goods.goods.currentPrice];
    }
    [backView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_activityBackImageView.mas_right).offset(-15);
        make.centerY.equalTo(weak_activityBackImageView).offset(6);
        make.height.equalTo(@30);
    }];
    
    weakView(weak_priceLabel, priceLabel)
    UIView * leftView = priceLabel;
    if (self.goods.goods.nominalPrice > 0) {
        UILabel * msrpPriceLabel = [UILabel labelWithFrame:CGRectMake(priceLabel.right + 4, priceLabel.top, 0, priceLabel.height) backColor:nil textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
        msrpPriceLabel.text = [NSString stringWithFormat:@"$%.2f", self.goods.goods.nominalPrice];
        [backView addSubview:msrpPriceLabel];
        self.msrpPriceLabel = msrpPriceLabel;
        [msrpPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weak_priceLabel.mas_right).offset(6);
            make.centerY.equalTo(weak_priceLabel).offset(2);
        }];
        weakView(weak_msrpPriceLabel, msrpPriceLabel)
        UIView * dividerView = [UIView allocInit];
        dividerView.backgroundColor = self.msrpPriceLabel.textColor;
        [self addSubview:dividerView];
        [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(weak_msrpPriceLabel);
            make.left.equalTo(weak_msrpPriceLabel).offset(0);
            make.height.equalTo(@.5);
        }];
        leftView = msrpPriceLabel;
    }
    
    UILabel * saleEndLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xffffff) textFont:12 textAlignment:(NSTextAlignmentRight) tag:1];
    saleEndLabel.text = @"Sale ends in:";
    [backView addSubview:saleEndLabel];
    [saleEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
    }];
    weakView(weak_saleEndLabel, saleEndLabel);
    CGFloat width = ScreenWidth > 320 ? 24 : 20;
    ///秒
    self.countdownLabel4 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0x131313) textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    if (self.goods.secKillVo) {
        self.countdownLabel4.backgroundColor = [UIColor whiteColor];
        self.countdownLabel4.textColor = button_back_color;
    }
    self.countdownLabel4.text = @"00";
    self.countdownLabel4.font = textFont_bold(14);
    [self.countdownLabel4 cutRounded:3];
    [backView addSubview:self.countdownLabel4];
    [self.countdownLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.priceLabel);
        make.right.equalTo(backView).offset(-16);
        make.right.equalTo(weak_saleEndLabel);
        make.width.height.equalTo(@(width));
        make.top.equalTo(weak_saleEndLabel.mas_bottom);
    }];
    
    UILabel * colonLabel1 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:self.countdownLabel4.backgroundColor textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    colonLabel1.text = @":";
    [backView addSubview:colonLabel1];
    [colonLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.countdownLabel4);
        make.width.equalTo(@10);
        make.right.equalTo(wSelf.countdownLabel4.mas_left);
    }];
    
    weakView(weak_colonLabel1, colonLabel1)
    ///分钟
    self.countdownLabel3 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0x131313) textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.countdownLabel3.text = @"00";
    self.countdownLabel3.font = textFont_bold(14);
    [self.countdownLabel3 cutRounded:3];
    [backView addSubview:self.countdownLabel3];
    [self.countdownLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.priceLabel);
        make.right.equalTo(weak_colonLabel1.mas_left);
        make.width.height.equalTo(wSelf.countdownLabel4);
    }];
    
    UILabel * colonLabel2 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:self.countdownLabel4.backgroundColor textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    colonLabel2.text = @":";
    [backView addSubview:colonLabel2];
    [colonLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.countdownLabel4);
        make.width.equalTo(@10);
        make.right.equalTo(wSelf.countdownLabel3.mas_left);
    }];
    
    weakView(weak_colonLabel2, colonLabel2)
    self.countdownLabel2 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0x131313) textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.countdownLabel2.text = @"00";
    self.countdownLabel2.font = textFont_bold(14);
    [self.countdownLabel2 cutRounded:3];
    [backView addSubview:self.countdownLabel2];
    [self.countdownLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.priceLabel);
        make.right.equalTo(weak_colonLabel2.mas_left);
        make.width.height.equalTo(wSelf.countdownLabel4);
    }];
    
    UILabel * colonLabel3 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:self.countdownLabel4.backgroundColor textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    colonLabel3.text = @":";
    [backView addSubview:colonLabel3];
    [colonLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.countdownLabel4);
        make.width.equalTo(@10);
        make.right.equalTo(wSelf.countdownLabel2.mas_left);
    }];
    
    weakView(weak_colonLabel3, colonLabel3)
    self.countdownLabel1 = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0x131313) textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.countdownLabel1.text = @"00";
    self.countdownLabel1.font = textFont_bold(14);
    [self.countdownLabel1 cutRounded:3];
    [backView addSubview:self.countdownLabel1];
    [self.countdownLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.priceLabel);
        make.right.equalTo(weak_colonLabel3.mas_left);
        make.width.height.equalTo(wSelf.countdownLabel4);
    }];
    
    
    UILabel * nameLabel = [UILabel labelWithFrame:CGRectMake(priceLabel.left, backView.bottom + 6, ScreenWidth - priceLabel.left * 2 - 80, 40) backColor:nil textColor:kColor(0x191919) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    nameLabel.text = self.goods.goods.title;
    nameLabel.numberOfLines = 2;
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(weak_backView.mas_bottom).offset(6);
        make.centerX.equalTo(wSelf);
        make.height.equalTo(@(40));
    }];
    
    weakView(weak_nameLabel, nameLabel)
    UIView * shareButtonBackView = [UIView allocInitWithFrame:CGRectMake(0, nameLabel.bottom, ScreenWidth, 30)];
    [self addSubview:shareButtonBackView];
    [shareButtonBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(weak_nameLabel.mas_bottom);
        make.height.equalTo(@30);
    }];
    
    weakView(weak_shareButtonBackView, shareButtonBackView)
    UIButton * shareButton = [UIButton allocInitWithImageName:@"goods_details_share" selectedImageName:@"goods_details_share"];
    [shareButton addTarget:self action:@selector(clickOnShare) forControlEvents:(UIControlEventTouchUpInside)];
    [shareButtonBackView addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf);
        make.width.equalTo(@40);
        make.centerY.equalTo(weak_shareButtonBackView);
    }];
    
    weakView(weak_shareButton, shareButton)
    UIButton * collectionButton = [UIButton allocInitWithImageName:@"list_no_collected" selectedImageName:@"list_already_collected"];
    collectionButton.selected = StateCollectionGoodsId(self.goods.goods.ID);
    [collectionButton addTarget:self action:@selector(clickOnCollection) forControlEvents:(UIControlEventTouchUpInside)];
    [shareButtonBackView addSubview:collectionButton];
    self.collectionButton = collectionButton;
    [collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_shareButton.mas_left);
        make.centerY.equalTo(weak_shareButton);
        make.width.equalTo(@40);
    }];
    
    if (self.score.totalCommentCount > 0) {
        
        XZZStarRateView * starRateView = [XZZStarRateView allocInitWithFrame:CGRectMake(16, nameLabel.bottom + 10, 60, 15)];
        starRateView.userInteractionEnabled = NO;
        starRateView.currentScore = self.score.averageScore;
        [shareButtonBackView addSubview:starRateView];
        starRateView.centerY = shareButtonBackView.height / 2.0;
        
        UILabel * numLabel = [UILabel labelWithFrame:CGRectMake(starRateView.right, 0, 10, 15) backColor:nil textColor:kColor(0xFFA800) textFont:7 textAlignment:(NSTextAlignmentLeft) tag:1];
        numLabel.text = [NSString stringWithFormat:@"(%d)", self.score.totalCommentCount];
        [shareButtonBackView addSubview:numLabel];
        [numLabel sizeToFit];
        numLabel.centerY = starRateView.centerY;
        
        UIView * dividerNumView = [UIView allocInitWithFrame:CGRectMake(numLabel.left, numLabel.bottom, numLabel.width, .5)];
        dividerNumView.backgroundColor = numLabel.textColor;
        [shareButtonBackView addSubview:dividerNumView];
    }
    
    UIView * topView = shareButtonBackView;
    
    if (self.goods.activityVo) {
        UIView * activityBackView = [UIView allocInitWithFrame:CGRectMake(weak_shareButtonBackView.left, shareButtonBackView.bottom + 10, 100, 35)];
        activityBackView.backgroundColor = kColorWithRGB(254.0, 86.0, 86.0, .1);
        [activityBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnActivity)]];
        [self addSubview:activityBackView];
        [activityBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weak_nameLabel);
            make.top.equalTo(weak_shareButtonBackView.mas_bottom).offset(10);
            make.height.equalTo(@35);
        }];
        topView = activityBackView;
        
        weakView(weak_activityBackView, activityBackView)
        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInit];
        [imageView cutRounded:10];
        if (self.goods.activityVo.iconPictureOne.length) {
            [imageView addImageFromUrlStr:self.goods.activityVo.iconPictureOne];
        }else{
            imageView.image = imageName(@"goods_details_discount_icon");
        }
        [activityBackView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@20);
            make.centerY.equalTo(weak_activityBackView);
            make.left.equalTo(@3);
        }];
        
        
        
        UIImageView * arrowImageView = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 15, 15) imageName:@"goods_details_arrow_red"];
        [activityBackView addSubview:arrowImageView];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weak_activityBackView).offset(-5);
            make.centerY.equalTo(weak_activityBackView);
            make.width.equalTo(@15);
            make.height.equalTo(@15);
        }];
        
        
        
        
        weakView(weak_imageView, imageView)
        weakView(weak_arrowImageView, arrowImageView)
        UILabel * promoCodeLabel = [UILabel labelWithFrame:CGRectMake(0, 00, 0, 0) backColor:nil textColor:kColor(0xd73e3e) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
        promoCodeLabel.textColor = button_back_color;
        promoCodeLabel.text = self.goods.activityVo.longTitle;
        [activityBackView addSubview:promoCodeLabel];
        [promoCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weak_imageView.mas_right).offset(5);
            make.top.bottom.equalTo(weak_activityBackView);
            make.right.equalTo(weak_arrowImageView.mas_left).offset(-5);
        }];
    }
    
    weakView(weak_topView, topView);
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, topView.bottom + 10, ScreenWidth, 10)];
    dividerView.backgroundColor = BACK_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf);
        make.top.equalTo(weak_topView.mas_bottom).offset(10);
        make.height.equalTo(@10);
    }];
    
    self.height = dividerView.bottom;
    [self startCountdown];
    !self.refresh?:self.refresh();
}

- (void)clickOnActivity
{
    !self.activityGoodsList?:self.activityGoodsList();
}


- (void)clickOnGoodsCollectionButton
{
    if ([self.delegate respondsToSelector:@selector(collectGoodsAccordingId:)]) {
        [self.delegate collectGoodsAccordingId:self.goods.goods.ID];
    }
}


- (void)clickOnShare
{
    if ([self.delegate respondsToSelector:@selector(clickOnGoodsShare)]) {
        [self.delegate clickOnGoodsShare];
    }
}

- (void)clickOnCollection
{
    if ([self.delegate respondsToSelector:@selector(collectGoodsAccordingId:)]) {
        [self.delegate collectGoodsAccordingId:self.goods.goods.ID];
    }
}




#pragma mark ----*  开始倒计时
/**
 *  开始倒计时
 */
- (void)startCountdown
{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    NSDate * currentDate = [NSDate date];
    NSString * endTime = self.goods.secKillVo ? self.goods.secKillVo.endTime : self.goods.activityVo.endTime;
    NSDate * endTimeDate = [self conversionDate:endTime];
    
    NSTimeInterval endTimeTime = 0;
    NSTimeInterval currentTime = 0;
    
    if (currentDate) {
        currentTime = currentDate.timeIntervalSince1970;
    }
    if (endTimeDate) {
        endTimeTime = endTimeDate.timeIntervalSince1970;
    }
    
    if (currentTime == 0) {
        currentTime = [NSDate date].timeIntervalSince1970;
    }
    WS(wSelf)
    __block int timeout = endTimeTime - currentTime; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                !wSelf.refreshData?:wSelf.refreshData();
                
            });
        }else{
            int day = timeout / (3600 * 24);
            int hours = (timeout % (3600 * 24)) / 3600;
            int minutes = (timeout % 3600) / 60;
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                wSelf.countdownLabel1.text = [NSString stringWithFormat:@"%02d", day];
                wSelf.countdownLabel2.text = [NSString stringWithFormat:@"%02d", hours];
                wSelf.countdownLabel3.text = [NSString stringWithFormat:@"%02d", minutes];
                wSelf.countdownLabel4.text = [NSString stringWithFormat:@"%02d", seconds];
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}




@end

