//
//  XZZCheckOutOptionsView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/28.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCheckOutOptionsView.h"
#import "XZZCheckOutTitleView.h"
#import "XZZCheckOutFreightView.h"

@interface XZZCheckOutOptionsView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutFreightView * selectedView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * postageViewArray;

@end

@implementation XZZCheckOutOptionsView

+ (instancetype)allocInit
{
    XZZCheckOutOptionsView * view = [super allocInit];

    return view;
}



- (void)addView
{
    [self removeAllSubviews];
    WS(wSelf)
    XZZCheckOutTitleView * titleView = [XZZCheckOutTitleView allocInit];
    titleView.title = @"Options";
    titleView.titleLabel.font = textFont_bold(13);
    [self addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(@35);
    }];
    
    weakView(weak_titleView, titleView)
    UIView * backView = [UIView allocInit];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf);
        make.top.equalTo(weak_titleView.mas_bottom);
    }];
    
    weakView(weak_backView, backView)
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(weak_backView);
        make.height.equalTo(@.5);
    }];

    
    
    NSArray * postageInforArray = [XZZAllOrderPostageInfor shareAllOrderPostageInfor].allPostageInforArray;
    
    for (int i = 0; i < postageInforArray.count; i++) {
        XZZOrderPostageInfor * postageInfor = postageInforArray[i];
        if ([postageInfor.transportId isEqualToString:self.postageInfor.transportId]) {
            break;
        }
        if (i == postageInforArray.count - 1) {
            self.postageInfor = nil;
        }
    }
    
    UIView * topView = dividerView;
    int i = 0;
    NSMutableArray * array = @[].mutableCopy;
    for (XZZOrderPostageInfor * postageInfor in postageInforArray) {
        weakView(weak_topView, topView)
        XZZCheckOutFreightView * freightView = [XZZCheckOutFreightView allocInit];
        freightView.postageInfor = postageInfor;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFreightInformation:)];
        [freightView addGestureRecognizer:tap];
        freightView.selected = NO;
        if (self.postageInfor) {
            if ([postageInfor.transportId isEqualToString:self.postageInfor.transportId]) {
                [self selectFreightInformation:tap];
            }
        }else{
            if (i == 0) {
                [self selectFreightInformation:tap];
            }
        }
        
        [array addObject:freightView];
        [backView addSubview:freightView];
        [freightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weak_backView);
            make.top.equalTo(weak_topView.mas_bottom);
            make.height.equalTo(@70);
        }];
        i++;
        topView = freightView;
    }
    self.postageViewArray = array.copy;
    weakView(weak_topView, topView)
    UIView * dividerView2 = [UIView allocInit];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [backView addSubview:dividerView2];
    [dividerView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(wSelf);
        make.top.equalTo(weak_topView.mas_bottom);
        make.height.equalTo(@.5);
    }];
    
//    if (self.postageInfor) {
//        self.postageInfor = self.postageInfor;
//    }
    
    
}

//- (void)setPostageInfor:(XZZOrderPostageInfor *)postageInfor
//{
//    _postageInfor = postageInfor;
//    for (XZZCheckOutFreightView * view in self.postageViewArray) {
//        if ([view.postageInfor.transportId isEqualToString:postageInfor.transportId]) {
//            self.selectedView.selected = NO;
//            self.selectedView = view;
//            self.selectedView.selected = YES;
//        }
//    }
//}

- (void)selectFreightInformation:(UITapGestureRecognizer *)tap
{
    if (![self.selectedView isEqual:tap.view]) {
        self.selectedView.selected = NO;
        self.selectedView = (XZZCheckOutFreightView *)tap.view;
        self.selectedView.selected = YES;
        self.postageInfor = self.selectedView.postageInfor;
        !self.selectFreight?:self.selectFreight(self.selectedView.postageInfor);
    }
}

- (void)setGoodsPrices:(CGFloat)goodsPrices
{
    _goodsPrices = goodsPrices;
    for (XZZCheckOutFreightView * view in self.postageViewArray) {
        [view calculateFreight:goodsPrices];
    }
}



@end
