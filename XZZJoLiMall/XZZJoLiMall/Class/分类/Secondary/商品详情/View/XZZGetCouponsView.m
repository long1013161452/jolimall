//
//  XZZGetCouponsView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/8/2.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZGetCouponsView.h"

#import "XZZCouponsListTableViewCell.h"


@interface XZZGetCouponsView ()<UITableViewDelegate, UITableViewDataSource>



/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;


@end


@implementation XZZGetCouponsView

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    if (!self.backView) {
    [self addView];
    }
    [self.tableView reloadData];
}

- (void)addView
{
    [self removeAllSubviews];
    UIView * view = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = .3;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)]];
    [self addSubview:view];
    
    self.backView = [UIView allocInitWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight / 2.0)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    UILabel * couponLabel = [UILabel labelWithFrame:CGRectMake(0, 0, ScreenWidth, 48) backColor:nil textColor:kColor(0x000000) textFont:16 textAlignment:(NSTextAlignmentCenter) tag:1];
    couponLabel.text = @"COUPON";
    [self.backView addSubview:couponLabel];
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, couponLabel.height - .5, ScreenWidth, .5)];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [couponLabel addSubview:dividerView];
    
    CGFloat buttonBottom = StatusRect.size.height > 20 ? bottomHeight : 0;
    
    UIButton * shutDownButton = [UIButton allocInitWithTitle:@"×" color:kColor(0x000000) selectedTitle:@"×" selectedColor:kColor(0x000000) font:26];
    shutDownButton.frame = CGRectMake(0, self.backView.height - couponLabel.height - buttonBottom, couponLabel.width, couponLabel.height);
    [shutDownButton addTarget:self action:@selector(removeView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:shutDownButton];
    
    UIView * dividerView2 = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, .5)];
    dividerView2.backgroundColor = DIVIDER_COLOR;
    [shutDownButton addSubview:dividerView2];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, couponLabel.bottom, ScreenWidth, shutDownButton.top - couponLabel.bottom) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    [self.backView addSubview:self.tableView];
    
    
}

#pragma mark ----- tableView代理方法
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XZZCouponsListTableViewCell * cell = [XZZCouponsListTableViewCell codeCellWithTableView:tableView];
    cell.isGoodsDetauls = YES;
    cell.couponsInfor = self.dataArray[indexPath.row];
    [cell setButtonTitle:@"Get it"];
    cell.getCouponBlock = self.getCouponBlock;
    return cell;
}
#pragma mark ----- 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}
#pragma mark ----- 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d 行", __func__, __LINE__);
}
#pragma mark ----- tableView代理结束




/**
 * 加载到父视图   默认是加载到window上
 */
- (void)addSuperviewView
{
    WS(wSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].delegate.window addSubview:self];
        [UIView animateWithDuration:.3 animations:^{
            [wSelf.tableView reloadData];
            wSelf.backView.bottom = ScreenHeight;
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
