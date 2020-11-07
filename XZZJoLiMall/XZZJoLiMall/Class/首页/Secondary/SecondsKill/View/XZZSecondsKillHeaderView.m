//
//  XZZSecondsKillHeaderView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/11/26.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZSecondsKillHeaderView.h"

#import "XZZSecondsKillView.h"

#import "XZZSecondsKillSession.h"

@interface XZZSecondsKillHeaderView ()




/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * secondsKillViewList;

/**
 * <#expression#>
 */
@property (nonatomic, strong)UIImageView * arrowImageView;

@end

@implementation XZZSecondsKillHeaderView

- (void)setSecondsKillList:(NSArray *)secondsKillList
{
    _secondsKillList = secondsKillList;
    [self addView];
}

- (void)addView
{
    [self removeAllSubviews];
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    [self addSubview:imageView];
    NSString * imageUrl = self.imageUrl;
    self.imageView = imageView;
    WS(wSelf)
    if ([imageUrl containsString:@"*"]) {
        CGFloat imageWidth = 0;
        CGFloat imageHeight = 0;
        
        NSArray * array = [imageUrl componentsSeparatedByString:@"_"];
        NSString * str = [array lastObject];
        if ([str containsString:@"*"]) {
            array = [str componentsSeparatedByString:@"."];
            str = [array firstObject];
            array = [str componentsSeparatedByString:@"*"];
            if (array.count > 0) {
                imageWidth = [[array firstObject] floatValue];
                imageHeight = [[array lastObject] floatValue];
                wSelf.imageView.height = (ScreenWidth) * (imageHeight / imageWidth);
            }
        }
        [self.imageView addImageFromUrlStr:imageUrl];
    }else{
        [self.imageView addImageFromUrlStr:imageUrl httpBlock:^(id data, BOOL successful, NSError *error) {
            UIImage * image = nil;
            CGFloat imageWidth = 0;
            CGFloat imageHeight = 0;
            if (successful) {
                image = data;
            }
            if (image) {
                imageWidth = image.size.width;
                imageHeight = image.size.height;
            }else if(wSelf.imageView.animatedImage){
                imageHeight = wSelf.imageView.height;
                imageWidth = wSelf.imageView.width;
            }else{
                imageWidth = ScreenWidth;
                imageHeight = 0;
            }
            wSelf.imageView.height = (ScreenWidth) * (imageHeight / imageWidth);
            wSelf.backView.top = wSelf.imageView.bottom;
            wSelf.height = wSelf.backView.bottom;
            !wSelf.refreshBlock?:wSelf.refreshBlock();
        }];
    }
    
    self.backView = [UIImageView allocInitWithFrame:CGRectMake(0, self.imageView.bottom, ScreenWidth, 64)];
    self.backView.image = imageName(@"seconds_kill_sale_bg_2");
    self.backView.userInteractionEnabled = YES;
    [self addSubview:self.backView];
    
    UIImageView * backImageView2 = [UIImageView allocInitWithFrame:CGRectMake(0, self.backView.bottom, ScreenWidth, 56) imageName:@"seconds_kill_sale_bg_1"];
    [self addSubview:backImageView2];
    
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
    self.arrowImageView.centerX = (index + 0.5) * width;
    
    self.scrollViewX = ScreenWidth * (index);
    
    
    
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
