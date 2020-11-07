//
//  XZZOrderDetailsCountdownView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZOrderDetailsCountdownView.h"


@interface XZZOrderDetailsCountdownView ()
/**
 * <#expression#>
 */
@property (nonatomic, strong)dispatch_source_t timer;
/**
 * 小时
 */
@property (nonatomic, strong)UILabel * hoursLabel;
/**
 * 分钟
 */
@property (nonatomic, strong)UILabel * minutesLabel;
/**
 * 秒
 */
@property (nonatomic, strong)UILabel * secondsLabel;

@end


@implementation XZZOrderDetailsCountdownView

- (void)dealloc
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil; // OK
    }
}

+ (instancetype)allocInit
{
    XZZOrderDetailsCountdownView * view = [super allocInit];
    [view addView];
    return view;
}

- (void)addView{
    NSLog(@"%s %d 行", __func__, __LINE__);
    self.backgroundColor = BACK_COLOR;
    WS(wSelf)
//    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"order_details_countdown"];
//    [self addSubview:imageView];
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@11);
//        make.centerY.equalTo(wSelf);
//    }];
//
//    weakView(weak_imageView, imageView)
    UILabel * remainingLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xFF4444) textFont:13 textAlignment:(NSTextAlignmentLeft) tag:1];
    remainingLabel.text = @"Remaining Payment Time:";
    [self addSubview:remainingLabel];
    [remainingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weak_imageView.mas_right).offset(8);
//        make.centerY.equalTo(weak_imageView);
        make.left.equalTo(@16);
        make.top.equalTo(@0);
        make.bottom.equalTo(wSelf);
        make.height.equalTo(@68);
    }];
    
    UIColor * backColor = kColor(0xffffff);
    UIColor * titleColor = kColor(0xFF4444);
    CGFloat titleFont = 12;
    CGFloat width = 28;
    
    UIView * secondsView = [UIView allocInit];
    secondsView.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:68/255.0 blue:68/255.0 alpha:0.2].CGColor;
    secondsView.layer.shadowOffset = CGSizeMake(0,8);
    secondsView.layer.shadowOpacity = 1;
    secondsView.layer.shadowRadius = 8;
    secondsView.backgroundColor = self.backgroundColor;
    [self addSubview:secondsView];
    
    self.secondsLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:titleColor textColor:backColor textFont:titleFont textAlignment:(NSTextAlignmentCenter) tag:1];
    self.secondsLabel.text = @"00";
    self.secondsLabel.font = textFont_bold(14);
    [self.secondsLabel cutRounded:2];
    [self addSubview:self.secondsLabel];
    [self.secondsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf).offset(-16);
        make.centerY.equalTo(wSelf);
        make.width.height.equalTo(@(width));
    }];
    [secondsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(wSelf.secondsLabel);
    }];
    
    UILabel * colonLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:titleColor textFont:15 textAlignment:(NSTextAlignmentCenter) tag:1];
    colonLabel.text = @":";
    [self addSubview:colonLabel];
    [colonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.secondsLabel.mas_left);
        make.width.equalTo(@20);
        make.centerY.equalTo(wSelf);
    }];
    
    UIView * minutesView = [UIView allocInit];
    minutesView.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:68/255.0 blue:68/255.0 alpha:0.2].CGColor;
    minutesView.layer.shadowOffset = CGSizeMake(0,8);
    minutesView.layer.shadowOpacity = 1;
    minutesView.layer.shadowRadius = 8;
    minutesView.backgroundColor = self.backgroundColor;
    [self addSubview:minutesView];
    weakView(weak_colonLabel, colonLabel)
    self.minutesLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:backColor textColor:titleColor textFont:titleFont textAlignment:(NSTextAlignmentCenter) tag:1];
    self.minutesLabel.text = @"00";
    self.minutesLabel.font = textFont_bold(14);
    [self.minutesLabel cutRounded:2];
    [self addSubview:self.minutesLabel];
    [self.minutesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_colonLabel.mas_left);
        make.centerY.equalTo(wSelf);
        make.width.height.equalTo(wSelf.secondsLabel);
    }];
    [minutesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(wSelf.minutesLabel);
    }];
    
    UILabel * colonLabelTwo = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:titleColor textFont:15 textAlignment:(NSTextAlignmentCenter) tag:1];
    colonLabelTwo.text = @":";
    [self addSubview:colonLabelTwo];
    [colonLabelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.minutesLabel.mas_left);
        make.width.equalTo(weak_colonLabel);
        make.centerY.equalTo(wSelf);
    }];
    
    UIView * hoursView = [UIView allocInit];
    hoursView.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:68/255.0 blue:68/255.0 alpha:0.2].CGColor;
    hoursView.layer.shadowOffset = CGSizeMake(0,8);
    hoursView.layer.shadowOpacity = 1;
    hoursView.layer.shadowRadius = 8;
    hoursView.backgroundColor = self.backgroundColor;
    [self addSubview:hoursView];
    weakView(weak_colonLabelTwo, colonLabelTwo)
    self.hoursLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:backColor textColor:titleColor textFont:titleFont textAlignment:(NSTextAlignmentCenter) tag:1];
    self.hoursLabel.text = @"00";
    self.hoursLabel.font = textFont_bold(14);
    [self.hoursLabel cutRounded:2];
    [self cutRounded:2];
    [self addSubview:self.hoursLabel];
    [self.hoursLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weak_colonLabelTwo.mas_left);
        make.centerY.equalTo(wSelf);
        make.width.height.equalTo(wSelf.secondsLabel);
    }];
    [hoursView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(wSelf.hoursLabel);
    }];
}

- (void)setCurrentTime:(NSString *)currentTime
{
    _currentTime = currentTime;
    [self countdown];
}




- (void)countdown
{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
    NSDate * currentDate = [NSDate date];
    NSDate * cancelDate = [self conversionDate:self.orderCancelTime];
    
    
    NSTimeInterval cancelTime = 0; //取消时间
    NSTimeInterval currentTime = 0;//当前时间
    
    if (currentDate) {
        currentTime = currentDate.timeIntervalSince1970;
    }
    if (cancelDate) {
        cancelTime = cancelDate.timeIntervalSince1970;
    }
    
    if (currentTime == 0) {
        currentTime = [NSDate date].timeIntervalSince1970;
    }
    
    
    WS(wSelf)
    __block int timeout = cancelTime - currentTime; //倒计时时间
    //    timeout = self.timeout;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                wSelf.hoursLabel.text = @"00";
                wSelf.minutesLabel.text = @"00";
                wSelf.secondsLabel.text = @"00";
            });
        }else{
            int hours = timeout / 3600;
            int minutes = (timeout % 3600) / 60;
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                wSelf.hoursLabel.text = [NSString stringWithFormat:@"%02d", hours];
                wSelf.minutesLabel.text = [NSString stringWithFormat:@"%02d", minutes];
                wSelf.secondsLabel.text = [NSString stringWithFormat:@"%02d", seconds];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}




@end
