//
//  XZZSecKillHeaderView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/12/2.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZSecKillHeaderView.h"

#import "XZZSecondsKillView.h"

#import "XZZSecondsKillSession.h"


@interface XZZSecKillHeaderView ()




/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * secondsKillViewList;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * arrowImageView;

@end

@implementation XZZSecKillHeaderView

- (void)setSecondsKillList:(NSArray *)secondsKillList
{
    _secondsKillList = secondsKillList;
    [self addView];
}

- (void)addView
{
    [self removeAllSubviews];
    self.backgroundColor = BACK_COLOR;
    self.backView = [UIImageView allocInitWithFrame:CGRectMake(0, self.imageView.bottom, ScreenWidth, 64)];
    self.backView.image = imageName(@"seconds_kill_sale_bg_2");
    self.backView.userInteractionEnabled = YES;
    [self addSubview:self.backView];
    
    self.height = self.backView.bottom;
    
    
    NSInteger count = self.secondsKillList.count > 3 ? 3 : self.secondsKillList.count;
    
    CGFloat width = ScreenWidth / count;
    CGFloat left = 0;
    
    NSMutableArray * array = @[].mutableCopy;
    
    BOOL ongoing = NO;
    int index = 0;
    NSInteger tag = 0;
    for (XZZSecondsKillSession * secondsKill in self.secondsKillList) {
        XZZSecondsKillView * secondsKillView = [XZZSecondsKillView allocInitWithFrame:CGRectMake(left, 0, width, 64)];
        [self.backView addSubview:secondsKillView];
        [array addObject:secondsKillView];
        secondsKillView.state = secondsKill.status == 2 ? XZZSecondsKillStateEnd : XZZSecondsKillStateNot;
        secondsKillView.secondsKill = secondsKill;
        secondsKillView.tag = tag;
        [secondsKillView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOutSession:)]];
        left = secondsKillView.right;
        if (secondsKill.status == 3 || secondsKill.status == 4) {//进行中的  或者  未开始的
            ongoing = YES;
        }
        if (!ongoing) {
            index++;
        }
        tag++;
    }
    self.secondsKillViewList = array.copy;
//    index = index == 0 ? 1 : index;
    self.arrowImageView = [UIImageView allocInitWithFrame:CGRectMake(0, 64 - 8, 16, 8) imageName:@"seconds_kill_triangle"];
    [self.backView addSubview:self.arrowImageView];
}

- (void)clickOutSession:(UITapGestureRecognizer *)tap
{
    !self.selectSession?:self.selectSession(tap.view.tag);
}

- (void)setScrollViewX:(CGFloat)scrollViewX
{
    _scrollViewX = scrollViewX;
    
    CGFloat jichu = (ScreenWidth / (self.secondsKillViewList.count * 1.0) / 2.0);
    self.arrowImageView.centerX = jichu + scrollViewX / (self.secondsKillViewList.count * 1.0);
    
    for (XZZSecondsKillView * secondsKillView in self.secondsKillViewList) {
        secondsKillView.indicatorcenterX = self.arrowImageView.centerX;
    }
}



@end
