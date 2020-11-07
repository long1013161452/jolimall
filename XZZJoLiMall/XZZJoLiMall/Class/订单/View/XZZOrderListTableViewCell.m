//
//  XZZOrderListTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/21.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZOrderListTableViewCell.h"

#import "XZZOrderGoodsView.h"


#define goods_height 152

@interface XZZOrderListTableViewCell ()

/**
 * 订单号
 */
@property (nonatomic, strong)UILabel * orderNumLabel;

/**
 * 订单状态
 */
@property (nonatomic, strong)UILabel * orderStateLabel;

/**
 * 订单状态   颜色块
 */
@property (nonatomic, strong)UIView * orderStateView;

/**
 * 滚动视图
 */
@property (nonatomic, strong)UIScrollView * scrollView;
/**
 * 商品
 */
@property (nonatomic, strong)UIView * goodsBackView;

/**
 * 下单时间
 */
@property (nonatomic, strong)UILabel * orderDateLabel;

/**
 * 订单商品数量
 */
@property (nonatomic, strong)UILabel * orderItemsLabel;

/**
 * 订单价格
 */
@property (nonatomic, strong)UILabel * orderTotalLabel;

/**
 * 支付
 */
@property (nonatomic, strong)UIButton * payButton;

@end

@implementation XZZOrderListTableViewCell


+ (CGFloat)calculateHeight:(XZZOrderList *)orderList
{
    return 44 + orderList.skus.count * goods_height + 68;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderList:(XZZOrderList *)orderList
{
    _orderList = orderList;
    if (!self.orderNumLabel) {
        [self addViewNew];
    }
    if (ScreenWidth > 320) {
        self.orderNumLabel.text = [NSString stringWithFormat:@"Order#：%@", orderList.orderId];
    }else{
        self.orderNumLabel.text = orderList.orderId;
    }
    self.payButton.hidden = YES;
    UIColor * stateColor = nil;
    NSString * statelabetText = @"";
    switch (orderList.status) {
        case 0:{
            statelabetText = @"waiting for payment";
            self.payButton.hidden = NO;
            [self.payButton setTitle:@"Pay Now" forState:(UIControlStateNormal)];
            [self.payButton setTitle:@"Pay Now" forState:(UIControlStateSelected)];
            [self.payButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@90);
            }];
            stateColor = kColor(0xc1b3fe);
        }
            break;
        case 1:{
            statelabetText = @"order confirmation";
            stateColor = kColor(0x00c160);
        }
            break;
        case 2:{
            statelabetText = @"shipping confirmation";
            stateColor = kColor(0xf7ac54);
        }
            break;
        case 3:{
            statelabetText = @"shipping update";
            stateColor = kColor(0x9a6322);
        }
            break;
        case 4:{
            statelabetText = @"shippment delievered";
            self.payButton.hidden = self.orderList.isComment;
            [self.payButton setTitle:@"Write Reviews" forState:(UIControlStateNormal)];
            [self.payButton setTitle:@"Write Reviews" forState:(UIControlStateSelected)];
            [self.payButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@100);
            }];
            stateColor = kColor(0x71acee);
        }
            break;
        case 5 :{
            statelabetText = @"refunded";
            stateColor = kColor(0xdc2e2e);
        }
            break;
        case 6:{
            statelabetText = @"refunded";
            stateColor = kColor(0xdc2e2e);
        }
            break;
        case 7:{
            statelabetText = @"refunded";
            stateColor = kColor(0xdc2e2e);
        }
            break;
        case 8:{
            statelabetText = @"canceled";
            stateColor = kColor(0xa5a5a5);
        }
            break;
        default:
            break;
    }
    
    self.orderStateView.backgroundColor = stateColor;
    self.orderStateLabel.text = statelabetText;
    static NSDateFormatter * formatter = nil;
    if (!formatter) {
        formatter = [NSDateFormatter allocInit];
        
    }
    
    self.orderDateLabel.text = [self timeFormat:@"MMM.d.YYYY HH:mm:ss" conversionDate:orderList.createTime];
    self.orderTotalLabel.text =
    self.orderTotalLabel.text = [NSString stringWithFormat:@"$%.2f", orderList.totalAmount];
    

    
    
    int count = 0;
    CGFloat interval = 8;
    CGFloat height = 121;
    CGFloat left = 8;
    CGFloat width = height * 3.0 / 4.0;
    [self.scrollView removeAllSubviews];
    [self.goodsBackView removeAllSubviews];
    
    UIView * topView = nil;
    WS(wSelf)
    for (XZZOrderSku * orderSku in orderList.skus) {
        count += orderSku.quantity.intValue;
        weakView(weak_topView, topView)
        XZZOrderGoodsView * goodsView = [XZZOrderGoodsView allocInit];
        goodsView.orderSku = orderSku;
        [self.goodsBackView addSubview:goodsView];
        [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (weak_topView) {
                make.top.equalTo(weak_topView.mas_bottom);
            }else{
                make.top.equalTo(@0);
            }
            make.left.right.equalTo(wSelf);
        }];
        
        topView = goodsView;
        
//        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(left, interval, width, height)];
//        [imageView addImageFromUrlStr:orderSku.imageTwo];
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        imageView.layer.masksToBounds = YES;
//        [self.scrollView addSubview:imageView];
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.equalTo(@(width));
//            make.height.equalTo(@(height));
//            make.top.equalTo(@(interval));
//            make.left.equalTo(@(left));
//        }];
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.layer.masksToBounds = YES;
//        left = imageView.right + interval;
    }
    [self.scrollView setContentSize:CGSizeMake(left, 0)];
    CGFloat goodsBackHeight = orderList.skus.count * goods_height;
    [self.goodsBackView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(goodsBackHeight));
    }];
    
    self.orderItemsLabel.text = [NSString stringWithFormat:@"%d items Total:", count];

}

#pragma mark ----*  创建视图   新的
/**
 *  创建视图   新的
 */
- (void)addViewNew
{
    self.backgroundColor = [UIColor whiteColor];
    
    WS(wSelf)
    
    self.orderNumLabel = [UILabel labelWithFrame:CGRectMake(10, 0, 100, 36) backColor:kColor(0xffffff) textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.orderNumLabel];
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf);
        make.left.equalTo(@16);
        make.height.equalTo(@44);
    }];
    
    self.orderStateView = [UIView allocInit];
    [self.orderStateView cutRounded:4];
    [self addSubview:self.orderStateView];
    [self.orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf).offset(-10);
        make.centerY.equalTo(wSelf.orderNumLabel);
        make.width.height.equalTo(@8);
    }];
    
    self.orderStateLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0xffffff) textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentRight) tag:1];
    [self addSubview:self.orderStateLabel];
    [self.orderStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.orderStateView.mas_left).offset(-10);
        make.top.bottom.equalTo(wSelf.orderNumLabel);
    }];
    
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.height.equalTo(@.5);
        make.bottom.equalTo(wSelf.orderNumLabel);
    }];
    
    self.goodsBackView = [UIView allocInit];
    self.goodsBackView.userInteractionEnabled = NO;
    [self addSubview:self.goodsBackView];
    [self.goodsBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(wSelf.orderNumLabel.mas_bottom);
    }];
    
    UIView * orderDateView = [UIView allocInit];
    [self addSubview:orderDateView];
    [orderDateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@68);
        make.top.equalTo(wSelf.goodsBackView.mas_bottom);
        make.left.right.bottom.equalTo(wSelf);
    }];
    
    weakView(weak_orderDateView, orderDateView)
    self.orderDateLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [orderDateView addSubview:self.orderDateLabel];
    [self.orderDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.orderNumLabel);
        make.top.equalTo(@13);
    }];
    
    self.orderItemsLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.orderItemsLabel.text = @"1 items Total:";
    [orderDateView addSubview:self.orderItemsLabel];
    [self.orderItemsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.orderDateLabel);
        make.bottom.equalTo(weak_orderDateView).offset(-13);
    }];
    
    self.orderTotalLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0xffffff) textColor:Selling_price_color textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.orderTotalLabel];
    [self.orderTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.orderItemsLabel.mas_right);
        make.centerY.equalTo(wSelf.orderItemsLabel);
    }];
    
    self.payButton = [UIButton allocInitWithTitle:@"Pay Now" color:kColor(0xffffff) selectedTitle:@"Pay Now" selectedColor:kColor(0xffffff) font:14];
    self.payButton.backgroundColor = button_back_color;
    self.payButton.layer.cornerRadius = 18;
    self.payButton.layer.masksToBounds = YES;
    [orderDateView addSubview:self.payButton];
    self.payButton.userInteractionEnabled = NO;
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.orderStateView);
        make.centerY.equalTo(weak_orderDateView);
        make.width.equalTo(@90);
        make.height.equalTo(@36);
    }];
    
}

- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    
    WS(wSelf)
    
    self.orderNumLabel = [UILabel labelWithFrame:CGRectMake(10, 0, 100, 36) backColor:kColor(0xffffff) textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.orderNumLabel];
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf);
        make.left.equalTo(@10);
        make.height.equalTo(@36);
    }];
    
    self.orderStateView = [UIView allocInit];
    [self.orderStateView cutRounded:7];
    [self addSubview:self.orderStateView];
    [self.orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf).offset(-10);
        make.centerY.equalTo(wSelf.orderNumLabel);
        make.width.height.equalTo(@14);
    }];
    
    self.orderStateLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0xffffff) textColor:kColor(0x000000) textFont:12 textAlignment:(NSTextAlignmentRight) tag:1];
    [self addSubview:self.orderStateLabel];
    [self.orderStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.orderStateView.mas_left).offset(-10);
        make.top.bottom.equalTo(wSelf.orderNumLabel);
    }];
 
    self.scrollView = [UIScrollView allocInit];
    self.scrollView.backgroundColor = BACK_COLOR;
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnScrollViewEnterOrderDetails)]];
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(wSelf.orderNumLabel.mas_bottom);
        make.height.equalTo(@137);
    }];
    
    self.orderDateLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x727272) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.orderDateLabel];
    [self.orderDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.orderNumLabel);
        make.top.equalTo(wSelf.scrollView.mas_bottom).offset(8);
    }];
    
    self.orderItemsLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x727272) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.orderItemsLabel.text = @"1 items Total:";
    [self addSubview:self.orderItemsLabel];
    [self.orderItemsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.orderDateLabel);
        make.bottom.equalTo(wSelf).offset(-10);
    }];
    
    self.orderTotalLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0xffffff) textColor:Selling_price_color textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.orderTotalLabel];
    [self.orderTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.orderItemsLabel.mas_right);
        make.centerY.equalTo(wSelf.orderItemsLabel);
    }];
    
    self.payButton = [UIButton allocInitWithTitle:@"Pay Now" color:kColor(0xffffff) selectedTitle:@"Pay Now" selectedColor:kColor(0xffffff) font:14];
    self.payButton.backgroundColor = button_back_color;
    [self addSubview:self.payButton];
    self.payButton.userInteractionEnabled = NO;
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.orderStateView);
        make.top.equalTo(wSelf.orderDateLabel);
        make.bottom.equalTo(wSelf.orderTotalLabel);
        make.width.equalTo(@80);
    }];
    
}

- (void)clickOnScrollViewEnterOrderDetails
{
    if ([self.delegate respondsToSelector:@selector(enterOrderDetails:)]) {
        [self.delegate enterOrderDetails:self.orderList.orderId];
    }
}

@end
