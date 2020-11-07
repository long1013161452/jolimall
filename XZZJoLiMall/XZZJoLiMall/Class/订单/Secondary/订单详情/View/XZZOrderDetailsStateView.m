//
//  XZZOrderDetailsStateView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZOrderDetailsStateView.h"


@interface XZZOrderDetailsStateView ()

/**
 * 时间
 */
@property (nonatomic, strong)UILabel * dateLabel;
/**
 * 状态
 */
@property (nonatomic, strong)UILabel * stateLabel;
/**
 * 物流
 */
@property (nonatomic, strong)UILabel * logisticsLabel;
/**
 * 网址连接
 */
@property (nonatomic, strong)UILabel * promptUrlQueryLabel;

@end

@implementation XZZOrderDetailsStateView

+ (instancetype)allocInit
{
    XZZOrderDetailsStateView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    NSLog(@"%s %d 行", __func__, __LINE__);
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
    self.dateLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x7b7b7b) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@11);
        make.top.equalTo(@8);
        make.height.equalTo(@20);
    }];
    
    self.stateLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x7b7b7b) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.dateLabel);
        make.top.equalTo(wSelf.dateLabel.mas_bottom);
        make.height.equalTo(@20);
    }];
    
    self.logisticsLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x7b7b7b) textFont:12 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.logisticsLabel.userInteractionEnabled = YES;
    [self.logisticsLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(assignLogisticsNumber)]];
    [self addSubview:self.logisticsLabel];
    [self.logisticsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.stateLabel);
        make.top.equalTo(wSelf.stateLabel.mas_bottom);
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
//        make.height.equalTo(@0);
        make.bottom.equalTo(wSelf).offset(-8);
    }];
}


- (void)setCreationTime:(NSString *)creationTime
{
    _creationTime = creationTime;
    NSString * time = [NSString stringWithFormat:@"Date:%@", [self timeFormat:@"MMM.dd.yyy" conversionDate:creationTime]];
    self.dateLabel.attributedText = [self text:time font:12 color:kColor(0x010101) discolorationText:@"Date:" discolorationFont:12 discolorationColor:kColor(0x7b7b7b)];
}

- (void)setOrderState:(int)orderState
{
    _orderState = orderState;
    NSString * time = [NSString stringWithFormat:@"Status:%@", [self GetOrderStatus]];
    self.stateLabel.attributedText = [self text:time font:12 color:kColor(0x010101) discolorationText:@"Status:" discolorationFont:12 discolorationColor:kColor(0x7b7b7b)];
}

- (void)setTransportCode:(NSString *)transportCode
{
    _transportCode = transportCode;
    NSString * code = [NSString stringWithFormat:@"Logistics:%@", transportCode];
    self.logisticsLabel.attributedText = [self text:code font:12 color:kColor(0x010101) discolorationText:@"Logistics:" discolorationFont:12 discolorationColor:kColor(0x7b7b7b)];
    [self.logisticsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
    }];
//    [self.promptUrlQueryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@30);
//    }];
    self.promptUrlQueryLabel.text = @"Please check the shipping information( your order status) in this site: www.17track.net";
    self.promptUrlQueryLabel.attributedText = [self text:@"Please check the shipping information( your order status) in this site: www.17track.net" font:12 color:kColor(0x010101) discolorationText:@"www.17track.net" discolorationFont:12 discolorationColor:kColor(0x0008aa)];

}

- (NSString *)GetOrderStatus
{
    NSString * statelabetText = @"";
    switch (self.orderState) {
        case 0:{
            statelabetText = @"waiting for payment";
        }
            break;
        case 1:{
            statelabetText = @"order confirmation";
        }
            break;
        case 2:{
            statelabetText = @"shipping confirmation";
        }
            break;
        case 3:{
            statelabetText = @"shipping update";
        }
            break;
        case 4:{
            statelabetText = @"shippment delievered";
        }
            break;
        case 5 :{
            statelabetText = @"refunded";
        }
            break;
        case 6:{
            statelabetText = @"refunded";
        }
            break;
        case 7:{
            statelabetText = @"refunded";
        }
            break;
        case 8:{
            statelabetText = @"canceled";
        }
            break;
        default:
            break;
    }
    return statelabetText;
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
