//
//  XZZGoodsScoreView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZGoodsScoreView.h"

#import "XZZStarRateView.h"

@implementation XZZGoodsScoreView


- (void)setScore:(XZZGoodsScore *)score
{
    _score = score;
    [self addView];
}

- (void)addView{
    [self removeAllSubviews];
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    dividerView.backgroundColor = BACK_COLOR;
    [self addSubview:dividerView];
    
    UIView * backView = [UIView allocInitWithFrame:CGRectMake(0, dividerView.bottom, ScreenWidth, 80)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    UILabel * scoreLabel = [UILabel labelWithFrame:CGRectMake(16, 10, 40, 20) backColor:nil textColor:kColor(0x4d4d4d) textFont:18 textAlignment:(NSTextAlignmentLeft) tag:1];
    scoreLabel.text = [NSString stringWithFormat:@"%.1f", roundf(self.score.averageScore * 10) / 10.0];
    [backView addSubview:scoreLabel];
    
    XZZStarRateView * starRateView = [XZZStarRateView allocInitWithFrame:CGRectMake(scoreLabel.left, scoreLabel.bottom + 5, 60, 15)];
    starRateView.userInteractionEnabled = NO;
    starRateView.currentScore = self.score.averageScore;
    [backView addSubview:starRateView];
    
    UILabel * numLabel = [UILabel labelWithFrame:CGRectMake(starRateView.right + 3, starRateView.top, 10, starRateView.height) backColor:nil textColor:kColor(0xFFA800) textFont:7 textAlignment:(NSTextAlignmentLeft) tag:1];
    numLabel.text = [NSString stringWithFormat:@"(%d)", self.score.totalCommentCount];
    [backView addSubview:numLabel];
    [numLabel sizeToFit];
    numLabel.centerY = starRateView.centerY;
    
    UIView * dividerNumView = [UIView allocInitWithFrame:CGRectMake(numLabel.left, numLabel.bottom, numLabel.width, .5)];
    dividerNumView.backgroundColor = numLabel.textColor;
    [backView addSubview:dividerNumView];
    
    UILabel * averageRatingLabel = [UILabel labelWithFrame:CGRectMake(starRateView.left, starRateView.bottom + 5, 60, 15) backColor:nil textColor:kColor(0x4d4d4d) textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    averageRatingLabel.text = @"Average Rating";
    [backView addSubview:averageRatingLabel];
    [averageRatingLabel sizeToFit];
    
    
    CGFloat spacing = ScreenWidth > 320 ? 40 : 15;
    
    UIColor * backColor = kColor(0xFFA800);
    
    UILabel * trueToSizeLabel = [UILabel labelWithFrame:CGRectMake(numLabel.right + spacing, 20, 20, 20) backColor:nil textColor:kColor(0x4d4d4d) textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    trueToSizeLabel.text = @"True to Size";
    [backView addSubview:trueToSizeLabel];
    [trueToSizeLabel sizeToFit];
    trueToSizeLabel.centerY = backView.height / 2.0;
    
    CGFloat ture = self.score.rightPercent;
    
    UILabel * trueToSizeAbsolutelyLabel = [UILabel labelWithFrame:CGRectMake(backView.width - 40, trueToSizeLabel.top, 40, trueToSizeLabel.height) backColor:nil textColor:kColor(0x4d4d4d) textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    trueToSizeAbsolutelyLabel.text = [NSString stringWithFormat:@"%.0f%%", ture];
    [backView addSubview:trueToSizeAbsolutelyLabel];
    
    
    UIView * trueToSizeBackView = [UIView allocInitWithFrame:CGRectMake(trueToSizeLabel.right + 10, trueToSizeLabel.top, trueToSizeAbsolutelyLabel.left - 4 - (trueToSizeLabel.right + 10), 8)];
    trueToSizeBackView.backgroundColor = DIVIDER_COLOR;
    [backView addSubview:trueToSizeBackView];
    trueToSizeBackView.centerY = trueToSizeLabel.centerY;
    
    UIView * trueToSizeFillView = [UIView allocInitWithFrame:CGRectMake(0, 0, trueToSizeBackView.width * (ture / 100.0), trueToSizeBackView.height)];
    trueToSizeFillView.backgroundColor = backColor;
    [trueToSizeBackView addSubview:trueToSizeFillView];
    
    
    
    UILabel * smallLabel = [UILabel labelWithFrame:CGRectMake(trueToSizeLabel.left, trueToSizeLabel.top - 30, trueToSizeLabel.width, 30) backColor:nil textColor:kColor(0x4d4d4d) textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    smallLabel.text = @"Small";
    [backView addSubview:smallLabel];
    
    CGFloat small = self.score.smallPercent;
    
    UILabel * smallAbsolutelyLabel = [UILabel labelWithFrame:CGRectMake(trueToSizeAbsolutelyLabel.left, smallLabel.top, trueToSizeAbsolutelyLabel.width, smallLabel.height) backColor:nil textColor:kColor(0x4d4d4d) textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    smallAbsolutelyLabel.text = [NSString stringWithFormat:@"%.0f%%", small];
    [backView addSubview:smallAbsolutelyLabel];
    
    UIView * smallBackView = [UIView allocInitWithFrame:CGRectMake(trueToSizeBackView.left, trueToSizeLabel.top, trueToSizeBackView.width, trueToSizeBackView.height)];
    smallBackView.backgroundColor = DIVIDER_COLOR;
    [backView addSubview:smallBackView];
    smallBackView.centerY = smallLabel.centerY;
    
    UIView * smallFillView = [UIView allocInitWithFrame:CGRectMake(0, 0, trueToSizeBackView.width * (small / 100.0), trueToSizeBackView.height)];
    smallFillView.backgroundColor = backColor;
    [smallBackView addSubview:smallFillView];
    
    UILabel * largeLabel = [UILabel labelWithFrame:CGRectMake(trueToSizeLabel.left, trueToSizeLabel.bottom, trueToSizeLabel.width, smallLabel.height) backColor:nil textColor:kColor(0x4d4d4d) textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    largeLabel.text = @"Large";
    [backView addSubview:largeLabel];
    
    CGFloat large = self.score.bigPercent;
    
    UILabel * largeAbsolutelyLabel = [UILabel labelWithFrame:CGRectMake(trueToSizeAbsolutelyLabel.left, largeLabel.top, trueToSizeAbsolutelyLabel.width, largeLabel.height) backColor:nil textColor:kColor(0x4d4d4d) textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    largeAbsolutelyLabel.text = [NSString stringWithFormat:@"%.0f%%", large];
    [backView addSubview:largeAbsolutelyLabel];
    
    UIView * largeBackView = [UIView allocInitWithFrame:CGRectMake(trueToSizeBackView.left, trueToSizeLabel.top, trueToSizeBackView.width, trueToSizeBackView.height)];
    largeBackView.backgroundColor = DIVIDER_COLOR;
    [backView addSubview:largeBackView];
    largeBackView.centerY = largeLabel.centerY;
    
    UIView * largeFillView = [UIView allocInitWithFrame:CGRectMake(0, 0, trueToSizeBackView.width * (large / 100.0), trueToSizeBackView.height)];
    largeFillView.backgroundColor = backColor;
    [largeBackView addSubview:largeFillView];
    
    
    UIView * dividerView2 = [UIView allocInitWithFrame:CGRectMake(0, backView.bottom, ScreenWidth, 10)];
    dividerView2.backgroundColor = BACK_COLOR;
    [self addSubview:dividerView2];
    
    if (!self.hiddenViewAll) {
        UIButton * button = [UIButton allocInitWithFrame:CGRectMake(0, dividerView2.bottom, ScreenWidth, 40)];
        button.backgroundColor = [UIColor whiteColor];
        [self addSubview:button];
        self.height = button.bottom;
        
//        UIView * dividerView3 = [UIView allocInitWithFrame:CGRectMake(16, button.bottom - .5, ScreenWidth - 16 * 2, .5)];
//        dividerView3.backgroundColor = DIVIDER_COLOR;
//        [self addSubview:dividerView3];
        
        
        UILabel * reviewsLabel = [UILabel labelWithFrame:CGRectMake(16, 0, 200, button.height) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
        reviewsLabel.text = [NSString stringWithFormat:@"Reviews(%d)", self.score.totalCommentCount];
        [button addSubview:reviewsLabel];
        
        UILabel * viewAllLabel = [UILabel labelWithFrame:CGRectMake(ScreenWidth - 16 * 2 - 100, 0, 100, reviewsLabel.height) backColor:nil textColor:kColor(0x000000) textFont:11 textAlignment:(NSTextAlignmentRight) tag:1];
        viewAllLabel.text = @"VIEW ALL >";
        viewAllLabel.userInteractionEnabled = YES;
        [viewAllLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnViewAllView)]];
        [button addSubview:viewAllLabel];
        
    }else{
        self.height = dividerView2.bottom;
    }
    
   
    
    
    
}



- (void)clickOnViewAllView
{
    !self.viewAll?:self.viewAll();
}



@end
