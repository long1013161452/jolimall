//
//  XZZCountdownView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/16.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCountdownView.h"

#import "XZZCountdownGoodsView.h"

#define goods_count 4

@interface XZZCountdownView ()
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
@property (nonatomic, strong)NSMutableArray * goodsViewArray;

@end

@implementation XZZCountdownView

- (void)dealloc
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil; // OK
    }
}

- (void)setGoodsArray:(NSArray *)goodsArray
{
    _goodsArray = goodsArray;
    if (goodsArray.count) {
        [self addViewTwo];
    }else{
        self.height = 0;
    }
}

- (NSMutableArray<UILabel *> *)countdownLabelArray
{
    if (!_countdownLabelArray) {
        self.countdownLabelArray = @[].mutableCopy;
    }
    return _countdownLabelArray;
}

- (void)addViewTwo
{
    for (int i = 0; i < self.goodsViewArray.count; i++) {
        XZZCountdownGoodsView * goodsView = self.goodsViewArray[i];
        if (i < self.goodsArray.count) {
            goodsView.goods = self.goodsArray[i];
            goodsView.hidden = NO;
            goodsView.userInteractionEnabled = YES;
        }else{
            goodsView.hidden = YES;
            goodsView.userInteractionEnabled = NO;
        }
        if (ScreenWidth < 321) {
            goodsView.priceLabel.font = textFont(13);
        }
    }
    
    if (self.goodsArray.count > 4) {
        XZZCountdownGoodsView * goodsView = self.goodsViewArray[4];
        self.height = goodsView.bottom + 15 + home_Template_interval;
    }else{
        XZZCountdownGoodsView * goodsView = self.goodsViewArray[0];
        self.height = goodsView.bottom + 15 + home_Template_interval;
    }
    !self.refresh?:self.refresh();
}

- (void)addView
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.goodsViewArray = @[].mutableCopy;
    
    CGFloat interval = 8;
    UILabel * nameLabel = [UILabel allocInitWithFrame:CGRectMake(0, 25, 10, 30)];
    nameLabel.textColor = Selling_price_color;
    nameLabel.font = textFont(13);
    nameLabel.text = @"Flash Deals";
    [self addSubview:nameLabel];
    [nameLabel sizeToFit];
    nameLabel.centerX = self.centerX + 11;
    
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(nameLabel.left - 15 - interval, 0, 15, 18)];
    imageView.image = imageName(@"home_Flash_sales");
    [self addSubview:imageView];
    imageView.centerY = nameLabel.centerY - 2;
    
    UILabel * endInLabel = [UILabel allocInitWithFrame:CGRectMake(interval, nameLabel.bottom + 25, 10, 20)];
    endInLabel.textColor = Selling_price_color;
    endInLabel.font = textFont(13);
    endInLabel.text = @"End in";
    [self addSubview:endInLabel];
    [endInLabel sizeToFit];
    
    
    
    CGFloat countdownBackViewHeight = 19;
    CGFloat colonWidth = 10;
    self.countdownBackView = [UIView allocInitWithFrame:CGRectMake(endInLabel.right + interval, 0, 100, countdownBackViewHeight)];
    [self addSubview:self.countdownBackView];
    self.countdownBackView.centerY = endInLabel.centerY;
    
    [self.countdownLabelArray removeAllObjects];
    
    UILabel * dayLabel = [self createLabel:CGRectMake(0, 0, countdownBackViewHeight, countdownBackViewHeight) textColor:kColor(0xffffff) backColor:button_back_color text:@"00" fontSize:12];
    [self.countdownBackView addSubview:dayLabel];
    [self.countdownLabelArray addObject:dayLabel];
    
    UILabel * colonLabel1 = [self createLabel:CGRectMake(dayLabel.right, dayLabel.top, colonWidth, countdownBackViewHeight) textColor:button_back_color backColor:[UIColor clearColor] text:@":" fontSize:15];
    [self.countdownBackView addSubview:colonLabel1];
    
    UILabel * hoursLabel = [self createLabel:CGRectMake(colonLabel1.right, colonLabel1.top, countdownBackViewHeight, countdownBackViewHeight) textColor:kColor(0xffffff) backColor:button_back_color text:@"00" fontSize:12];
    [self.countdownBackView addSubview:hoursLabel];
    [self.countdownLabelArray addObject:hoursLabel];
    
    UILabel * colonLabel2 = [self createLabel:CGRectMake(hoursLabel.right, dayLabel.top, colonWidth, countdownBackViewHeight) textColor:button_back_color backColor:[UIColor clearColor] text:@":" fontSize:15];
    [self.countdownBackView addSubview:colonLabel2];
    
    UILabel * minutesLabel = [self createLabel:CGRectMake(colonLabel2.right, colonLabel2.top, countdownBackViewHeight, countdownBackViewHeight) textColor:kColor(0xffffff) backColor:button_back_color text:@"00" fontSize:12];
    [self.countdownBackView addSubview:minutesLabel];
    [self.countdownLabelArray addObject:minutesLabel];
    
    UILabel * colonLabel3 = [self createLabel:CGRectMake(minutesLabel.right, dayLabel.top, colonWidth, countdownBackViewHeight) textColor:button_back_color backColor:[UIColor clearColor] text:@":" fontSize:15];
    [self.countdownBackView addSubview:colonLabel3];
    
    UILabel * secondsLabel = [self createLabel:CGRectMake(colonLabel3.right, colonLabel3.top, countdownBackViewHeight, countdownBackViewHeight) textColor:kColor(0xffffff) backColor:button_back_color text:@"00" fontSize:12];
    [self.countdownBackView addSubview:secondsLabel];
    [self.countdownLabelArray addObject:secondsLabel];
    
    [self startCountdown];
    
    
    /**
     *  创建所有的按钮
     */
    UIButton * allButton = [UIButton allocInitWithFrame:CGRectMake(self.width - 80, 0, 80, countdownBackViewHeight)];
    [allButton setTitle:@"View All >" forState:(UIControlStateNormal)];
    [allButton setTitle:@"View All >" forState:(UIControlStateHighlighted)];
    [allButton addTarget:self action:@selector(clickOnViewAll:) forControlEvents:(UIControlEventTouchUpInside)];
    [allButton setTitleColor:button_back_color forState:(UIControlStateNormal)];
    allButton.titleLabel.font = textFont(11);
    allButton.centerY = self.countdownBackView.centerY;
    [self addSubview:allButton];
    
    
    
    CGFloat goodsWidth = (ScreenWidth - (goods_count + 1) * interval) / goods_count;
    CGFloat goodsHeight = [XZZCountdownGoodsView getHeight:goodsWidth];
    CGFloat left = interval;
    CGFloat top = self.countdownBackView.bottom + 14;
    for (int i = 0; i < 8; i++) {
        if (i == 4) {
            left = interval;
            top += (goodsHeight + interval);
        }
        XZZCountdownGoodsView * goodsView = [XZZCountdownGoodsView allocInitWithFrame:CGRectMake(left, top, goodsWidth, goodsHeight)];
        goodsView.tag = i;
        [goodsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnGoodsTap:)]];
        [self addSubview:goodsView];
        left = goodsView.right + interval;
        [self.goodsViewArray addObject:goodsView];
        self.height = goodsView.bottom;
    }
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, self.height + 15, ScreenWidth, home_Template_interval)];
//    dividerView.backgroundColor = BACK_COLOR;
    [self addSubview:dividerView];
    self.height = dividerView.bottom;
    
    
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
        if ([goods isKindOfClass:[XZZGoodsList class]]) {
            XZZGoodsList * goodsList = goods;
            goodsId = goodsList.goodsId;
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
    NSDate * endTimeDate = [self conversionDate:self.homeTemplateArray[0].endTime];
    
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
                wSelf.countdownBackView.hidden = YES;
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


