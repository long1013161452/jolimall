//
//  XZZCheckOutBouncedSelectPostageView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZCheckOutBouncedSelectPostageView.h"

#import "XZZCheckOutFreightView.h"

@interface XZZCheckOutBouncedSelectPostageView ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)XZZCheckOutFreightView * selectedView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * postageViewArray;

@end

@implementation XZZCheckOutBouncedSelectPostageView

- (void)addView
{
    WS(wSelf)
    
    [self removeAllSubviews];
    
    UIView * view = [UIView allocInit];
    view.backgroundColor = kColorWithRGB(0, 0, 0, .3);
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)]];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.equalTo(wSelf);
    }];
    
    self.backView = [UIView allocInitWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight * 0.7)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, ScreenWidth, 45) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    label.text = @"Shipping method";
    label.font = textFont_bold(14);
    [self.backView addSubview:label];
    
    UIButton * shutDownButton = [UIButton allocInitWithImageName:@"goods_details_Shut_down" selectedImageName:@"goods_details_Shut_down"];
    shutDownButton.frame = CGRectMake(self.backView.width - label.height, 0, label.height, label.height);
    [shutDownButton addTarget:self action:@selector(removeView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:shutDownButton];
    
    UIView * dividerView1 = [UIView allocInitWithFrame:CGRectMake(0, label.bottom - .5, ScreenWidth, .5)];
    dividerView1.backgroundColor = DIVIDER_COLOR;
    [label addSubview:dividerView1];
    
    self.scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, label.bottom, ScreenWidth, self.backView.height - label.bottom)];
    [self.backView addSubview:self.scrollView];
    
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
    
    UIView * topView = nil;
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
        [self.scrollView addSubview:freightView];
        [freightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(wSelf);
            if (!weak_topView) {
                make.top.equalTo(@0);
            }else{
                make.top.equalTo(weak_topView.mas_bottom);
            }
            make.height.equalTo(@70);
        }];
        i++;
        topView = freightView;
    }
    self.postageViewArray = array.copy;
    CGFloat height = self.postageViewArray.count * 70 + 30;
    if (height < self.scrollView.height) {
        self.scrollView.height = height;
        self.backView.height = self.scrollView.bottom;
    }
    
//    if (self.postageInfor) {
//        self.postageInfor = self.postageInfor;
//    }
    
    [self dynamicChangesRefreshView];
}



- (void)selectFreightInformation:(UITapGestureRecognizer *)tap
{
    if (![self.selectedView isEqual:tap.view]) {
        self.selectedView.selected = NO;
        self.selectedView = (XZZCheckOutFreightView *)tap.view;
        self.selectedView.selected = YES;
        self.postageInfor = self.selectedView.postageInfor;
        !self.selectFreight?:self.selectFreight(self.selectedView.postageInfor);
    }
    if (self.superview) {
        [self removeView];
    }
}

- (void)setGoodsPrices:(CGFloat)goodsPrices
{
    _goodsPrices = goodsPrices;
    for (XZZCheckOutFreightView * view in self.postageViewArray) {
        [view calculateFreight:goodsPrices];
    }
}


#pragma mark ----*  动态延时刷新视图
/**
 *  动态延时刷新视图
 */
- (void)dynamicChangesRefreshView
{
    WS(wSelf)
    UIView * view = [self.postageViewArray lastObject];
    weakView(weak_view, view)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        wSelf.scrollView.contentSize = CGSizeMake(0, weak_view.bottom + 20);
    });
}


/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView
{
    WS(wSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [wSelf.VC.view addSubview:wSelf];
        CGFloat top = StatusRect.size.height > 20 ? 88 : 64;
        [UIView animateWithDuration:.3 animations:^{
            wSelf.backView.bottom = ScreenHeight - top;
        }];
    });
}

/**
 * 移除视图
 */
- (void)removeView
{
    WS(wSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3 animations:^{
            wSelf.backView.top = ScreenHeight;
        } completion:^(BOOL finished) {
            [wSelf removeFromSuperview];
        }];
    });
}


@end
