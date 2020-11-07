//
//  XZZHomeSecondsKillView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/25.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZHomeSecondsKillView.h"

#import "XZZCountdownGoodsView.h"
#import "XZZSecondsKillGoods.h"

@interface XZZHomeSecondsKillView ()
/**
 * <#expression#>
 */
@property (nonatomic, strong)dispatch_source_t timer;
/**
 * 倒计时背景
 */
@property (nonatomic, strong)UIView * countdownBackView;

/**
 * 存放倒计时信息
 */
@property (nonatomic, strong)NSMutableArray<UILabel *> * countdownLabelArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)FLAnimatedImageView * backImageView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIView * backView;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UILabel * endInLabel;
/**
 * <#expression#>
 */
@property (nonatomic, strong)UIScrollView * scrollView;

@end

#define Aspect_ratio (312.0 / 375.0)

@implementation XZZHomeSecondsKillView


- (void)dealloc
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil; // OK
    }
}

- (NSMutableArray<UILabel *> *)countdownLabelArray
{
    if (!_countdownLabelArray) {
        self.countdownLabelArray = @[].mutableCopy;
    }
    return _countdownLabelArray;
}

- (void)addView
{
    XZZHomeTemplate * homeTemplate = self.homeTemplateArray[0];
    self.backImageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * Aspect_ratio)];
    self.backImageView.userInteractionEnabled = YES;
    [self addSubview:self.backImageView];
    [self.backImageView addImageFromUrlStr:homeTemplate.picture];
    self.height = self.backImageView.bottom;
    
    CGFloat top = 55 * (ScreenWidth / 375.0);
    UIView * backView = [UIView allocInitWithFrame:CGRectMake(16, top, ScreenWidth - 16 * 2, self.backImageView.height - top - 16)];
    backView.backgroundColor = [UIColor whiteColor];
    [backView cutRounded:8];
    [self.backImageView addSubview:backView];
    self.backView = backView;
    CGFloat interval = 16;
    
    UILabel * endInLabel = [UILabel allocInitWithFrame:CGRectMake(interval, 0, 10, 50)];
    endInLabel.textColor = Selling_price_color;
    endInLabel.font = textFont(14);
    endInLabel.text = @"End in";
    [backView addSubview:endInLabel];
    self.endInLabel = endInLabel;
    [endInLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(interval));
        make.top.equalTo(@0);
        make.height.equalTo(@50);
    }];
    
    
    
    CGFloat countdownBackViewHeight = 24;
    CGFloat colonWidth = 10;
    weakView(weak_endInLabel, endInLabel)
    self.countdownBackView = [UIView allocInitWithFrame:CGRectMake(endInLabel.right + interval, 0, 100, countdownBackViewHeight)];
    [backView addSubview:self.countdownBackView];
    self.countdownBackView.centerY = endInLabel.centerY;
    [self.countdownLabelArray removeAllObjects];
    [self.countdownBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_endInLabel.mas_right).offset(interval);
        make.width.equalTo(@200);
        make.centerY.equalTo(weak_endInLabel);
        make.height.equalTo(@(countdownBackViewHeight));
    }];
    
    UIColor * countdownBackColor = kColor(0xF9E7E7);
    UIColor * countdownTextColor = button_back_color;
    UIFont * countdownTextFont = textFont_bold(14);
    UIFont * colonFont = textFont_bold(14);
    UILabel * dayLabel = [self createLabel:CGRectMake(0, 0, countdownBackViewHeight, countdownBackViewHeight) textColor:countdownTextColor backColor:countdownBackColor text:@"00" fontSize:12];
    [dayLabel cutRounded:4];
    dayLabel.font = countdownTextFont;
    [self.countdownBackView addSubview:dayLabel];
    [self.countdownLabelArray addObject:dayLabel];
    
    UILabel * colonLabel1 = [self createLabel:CGRectMake(dayLabel.right, -2, colonWidth, countdownBackViewHeight) textColor:countdownTextColor backColor:[UIColor clearColor] text:@":" fontSize:15];
    colonLabel1.font = colonFont;
    [self.countdownBackView addSubview:colonLabel1];
    
    UILabel * hoursLabel = [self createLabel:CGRectMake(colonLabel1.right, dayLabel.top, countdownBackViewHeight, countdownBackViewHeight) textColor:countdownTextColor backColor:countdownBackColor text:@"00" fontSize:12];
    hoursLabel.font = countdownTextFont;
    [hoursLabel cutRounded:4];
    [self.countdownBackView addSubview:hoursLabel];
    [self.countdownLabelArray addObject:hoursLabel];
    
    UILabel * colonLabel2 = [self createLabel:CGRectMake(hoursLabel.right, colonLabel1.top, colonWidth, countdownBackViewHeight) textColor:countdownTextColor backColor:[UIColor clearColor] text:@":" fontSize:15];
    colonLabel2.font = colonFont;
    [self.countdownBackView addSubview:colonLabel2];
    
    UILabel * minutesLabel = [self createLabel:CGRectMake(colonLabel2.right, dayLabel.top, countdownBackViewHeight, countdownBackViewHeight) textColor:countdownTextColor backColor:countdownBackColor text:@"00" fontSize:12];
    minutesLabel.font = countdownTextFont;
    [minutesLabel cutRounded:4];
    [self.countdownBackView addSubview:minutesLabel];
    [self.countdownLabelArray addObject:minutesLabel];
    
    UILabel * colonLabel3 = [self createLabel:CGRectMake(minutesLabel.right, colonLabel1.top, colonWidth, countdownBackViewHeight) textColor:countdownTextColor backColor:[UIColor clearColor] text:@":" fontSize:15];
    colonLabel3.font = colonFont;
    [self.countdownBackView addSubview:colonLabel3];
    
    UILabel * secondsLabel = [self createLabel:CGRectMake(colonLabel3.right, dayLabel.top, countdownBackViewHeight, countdownBackViewHeight) textColor:countdownTextColor backColor:countdownBackColor text:@"00" fontSize:12];
    secondsLabel.font = countdownTextFont;
    [secondsLabel cutRounded:4];
    [self.countdownBackView addSubview:secondsLabel];
    [self.countdownLabelArray addObject:secondsLabel];
    
    [self startCountdown];
    
    
    /**
     *  创建所有的按钮
     */
    UIButton * allButton = [UIButton allocInitWithFrame:CGRectMake(backView.width - 80, 0, 80, countdownBackViewHeight)];
    [allButton setTitle:@"View All>>" forState:(UIControlStateNormal)];
    [allButton setTitle:@"View All>>" forState:(UIControlStateHighlighted)];
    [allButton addTarget:self action:@selector(clickOnViewAll:) forControlEvents:(UIControlEventTouchUpInside)];
    [allButton setTitleColor:kColor(0x999999) forState:(UIControlStateNormal)];
    allButton.titleLabel.font = textFont(11);
    allButton.centerY = self.countdownBackView.centerY;
    [backView addSubview:allButton];
    
    
    CGFloat goodsHeight = backView.height - 50;
    UIScrollView * scrollView = [UIScrollView allocInitWithFrame:CGRectMake(0, 50, backView.width, goodsHeight)];
    scrollView.showsHorizontalScrollIndicator = NO;
    [backView addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setEndTime:(NSString *)endTime
{
    _endTime = endTime;
    [self startCountdown];
}

- (void)setState:(XZZSecondsKillState)state
{
    _state = state;
    if (self.state == XZZSecondsKillStateOngoing) {
        self.endInLabel.text = @"End in";
    }else if (self.state == XZZSecondsKillStateNot){
        self.endInLabel.text = @"Starts In";
    }
}


- (void)setGoodsArray:(NSArray *)goodsArray
{
    _goodsArray = goodsArray;
    [self addViewTwo];
}

- (void)addViewTwo
{
    [self.scrollView removeAllSubviews];
    CGFloat goodsHeight = self.backView.height - 50;
    CGFloat goodsWidth = [XZZCountdownGoodsView getWidth:goodsHeight];
    if (ScreenWidth > 320) {
        goodsWidth = [XZZSecKillGoodsView getWidth:goodsHeight];
    }
    
    CGFloat left = 15;
    CGFloat interval = 10;
    for (int i = 0; i < self.goodsArray.count; i++) {
        if (i >= 6) {
            break;
        }
        XZZSecKillGoodsView * goodsView = nil;
        if (ScreenWidth > 320) {
            goodsView = [XZZSecKillGoodsView allocInitWithFrame:CGRectMake(left, 0, goodsWidth, goodsHeight)];
        }else{
            goodsView = (XZZSecKillGoodsView *)[XZZCountdownGoodsView allocInitWithFrame:CGRectMake(left, 0, goodsWidth, goodsHeight)];
        }
        goodsView.tag = i;
        goodsView.goods = self.goodsArray[i];
        [goodsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnGoodsTap:)]];
        [self.scrollView addSubview:goodsView];
        left = goodsView.right + interval;
    }
    /**
     *  创建所有的按钮
     */
    UIButton * allButtonTwo = [UIButton allocInitWithFrame:CGRectMake(left, 0, goodsWidth, goodsWidth * 406.0 / 304.0)];
    [allButtonTwo setImage:imageName(@"home_all_activity") forState:(UIControlStateNormal)];
    [allButtonTwo setImage:imageName(@"home_all_activity") forState:(UIControlStateHighlighted)];
    [allButtonTwo addTarget:self action:@selector(clickOnViewAll:) forControlEvents:(UIControlEventTouchUpInside)];
    [allButtonTwo setTitleColor:kColor(0x000000) forState:(UIControlStateNormal)];
    allButtonTwo.titleLabel.font = textFont(11);
    [self.scrollView addSubview:allButtonTwo];
    
    self.scrollView.contentSize = CGSizeMake(allButtonTwo.right + 16, 0);
}

#pragma mark ----*  点击所有
/**
 *  点击所有
 */
- (void)clickOnViewAll:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(clickOnHomepageTemplate:)]) {
        [self.delegate clickOnHomepageTemplate:[self.homeTemplateArray firstObject]];
    }
}

#pragma mark ----*  点击商品
/**
 *  点击商品
 */
- (void)clickOnGoodsTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(clickOnGoodsAccordingId:state:)]) {
        NSLog(@"%s %d 行 点击了商品  ", __func__, __LINE__);
        
        id goods = self.goodsArray[tap.view.tag];
        NSString * goodsId = @"";
        BOOL state = false ;
        if ([goods isKindOfClass:[XZZSecondsKillGoods class]]) {
            XZZSecondsKillGoods * goodsList = goods;
            goodsId = goodsList.ID;
            state = YES;
        }
        [self.delegate clickOnGoodsAccordingId:goodsId state:state];
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
    NSDate * endTimeDate = [self conversionDate:self.endTime];
    
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
                !wSelf.refresh?:wSelf.refresh();
            });
        }else{
            int day = timeout / (3600 * 24);
            int hours = (timeout % (3600 * 24)) / 3600;
            int minutes = (timeout % 3600) / 60;
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                wSelf.countdownBackView.hidden = NO;
                UILabel * dayLabel = wSelf.countdownLabelArray[0];
                UILabel * hoursLabel = wSelf.countdownLabelArray[1];
                UILabel * minutesLabel = wSelf.countdownLabelArray[2];
                UILabel * secondsLabel = wSelf.countdownLabelArray[3];
                //                //设置界面的按钮显示 根据自己需求设置
                dayLabel.text = [NSString stringWithFormat:@"%02d", day];
                hoursLabel.text = [NSString stringWithFormat:@"%02d", hours];
                minutesLabel.text = [NSString stringWithFormat:@"%02d", minutes];
                secondsLabel.text = [NSString stringWithFormat:@"%02d", seconds];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



@end
