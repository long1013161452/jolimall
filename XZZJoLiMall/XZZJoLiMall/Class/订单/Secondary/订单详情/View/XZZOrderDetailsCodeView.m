//
//  XZZOrderDetailsCodeView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZOrderDetailsCodeView.h"

@interface XZZOrderDetailsCodeView ()

/**
 * <#expression#>
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
 * 时间
 */
@property (nonatomic, strong)UILabel * dateLabel;

/**
 * 物流
 */
@property (nonatomic, strong)UILabel * logisticsLabel;
/**
 * 网址连接
 */
@property (nonatomic, strong)UILabel * promptUrlQueryLabel;

@end

@implementation XZZOrderDetailsCodeView

+ (instancetype)allocInit
{
    XZZOrderDetailsCodeView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
    self.orderNumLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.orderNumLabel.font = textFont_bold(14);
    [self addSubview:self.orderNumLabel];
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@16);
    }];
    
    self.orderStateView = [UIView allocInit];
    [self.orderStateView cutRounded:4];
    [self addSubview:self.orderStateView];
    [self.orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf).offset(-16);
        make.centerY.equalTo(wSelf.orderNumLabel);
        make.width.height.equalTo(@8);
    }];
    
    self.orderStateLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:kColor(0xffffff) textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentRight) tag:1];
    [self addSubview:self.orderStateLabel];
    [self.orderStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.orderStateView.mas_left).offset(-10);
        make.top.bottom.equalTo(wSelf.orderNumLabel);
    }];
    
    self.dateLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x999999) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.orderNumLabel);
        make.top.equalTo(wSelf.orderNumLabel.mas_bottom).offset(5);
    }];
    

    
    self.logisticsLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x7b7b7b) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.logisticsLabel.userInteractionEnabled = YES;
    [self.logisticsLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(assignLogisticsNumber)]];
    [self addSubview:self.logisticsLabel];
    [self.logisticsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.dateLabel);
        make.top.equalTo(wSelf.dateLabel.mas_bottom).offset(8);
        make.height.equalTo(@0);
    }];
    
    self.promptUrlQueryLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x7b7b7b) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.promptUrlQueryLabel.numberOfLines = 0;
    self.promptUrlQueryLabel.userInteractionEnabled = YES;
    [self.promptUrlQueryLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openTheLinkToCheckTheLogisticsInfor)]];
    [self addSubview:self.promptUrlQueryLabel];
    [self.promptUrlQueryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.logisticsLabel);
        make.top.equalTo(wSelf.logisticsLabel.mas_bottom);
        make.centerX.equalTo(wSelf);
        make.bottom.equalTo(wSelf).offset(-8);
    }];
    
}

- (void)setOrderNum:(NSString *)orderNum
{
    _orderNum = orderNum;
    if (ScreenWidth > 320) {
        self.orderNumLabel.text = [NSString stringWithFormat:@"Order#%@", orderNum];
    }else{
        self.orderNumLabel.text = orderNum;
    }
}

- (void)setCreationTime:(NSString *)creationTime
{
    _creationTime = creationTime;
    self.dateLabel.text = [self timeFormat:@"MMM.dd.yyy HH:mm:ss" conversionDate:creationTime];
}

- (void)setOrderState:(int)orderState
{
    _orderState = orderState;
    [self GetOrderStatus];
}

- (void)setTransportCode:(NSString *)transportCode
{
    _transportCode = transportCode;
    NSString * code = [NSString stringWithFormat:@"Logistics:%@", transportCode];
    self.logisticsLabel.attributedText = [self text:code font:14 color:kColor(0x191919) discolorationText:@"Logistics:" discolorationFont:14 discolorationColor:kColor(0x999999)];
    [self.logisticsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
    }];

    self.promptUrlQueryLabel.text = @"Please check the shipping information( your order status) in this site: www.17track.net";
    self.promptUrlQueryLabel.attributedText = [self text:@"Please check the shipping information( your order status) in this site: www.17track.net" font:12 color:kColor(0x010101) discolorationText:@"www.17track.net" discolorationFont:12 discolorationColor:kColor(0x0008aa)];
    
}

- (void)GetOrderStatus
{
    NSString * statelabetText = @"";
    UIColor * stateColor = nil;
    switch (self.orderState) {
        case 0:{
            statelabetText = @"waiting for payment";
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
    
    self.orderStateLabel.text = statelabetText;
    
    self.orderStateView.backgroundColor = stateColor;

}
#pragma mark ----*  复制物流单号
/**
 *  复制物流单号
 */
- (void)assignLogisticsNumber
{
    SVProgressSuccess(@"The logistics number has been copied");
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.transportCode;
}
#pragma mark ----*  打开连接查看物流信息
/**
 *  打开连接查看物流信息
 */
- (void)openTheLinkToCheckTheLogisticsInfor
{
    if ([self.delegate respondsToSelector:@selector(openWebPageUrl:)]) {
        [self.delegate openWebPageUrl:@"https://www.17track.net"];
    }
}



@end
