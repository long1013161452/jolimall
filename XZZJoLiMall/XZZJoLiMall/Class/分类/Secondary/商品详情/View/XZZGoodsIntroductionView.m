//
//  XZZGoodsIntroductionView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZGoodsIntroductionView.h"


@interface XZZGoodsIntroductionView ()

/**
 * 背景视图
 */
@property (nonatomic, strong)UIView * backView;



@end

@implementation XZZGoodsIntroductionView


- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    if (self.contentArray.count) {
        [self addView];
    }
}

- (void)setContentArray:(NSArray *)contentArray
{
    _contentArray = contentArray;
    if (self.titleArray.count) {
        [self addView];
    }
}

#pragma mark ---- 添加视图信息
/**
 *  添加视图
 */
- (void)addView{
    [self.backView removeAllSubviews];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    UIView * topView = nil;
    WS(wSelf)
    for (int i = 0; i < self.titleArray.count; i++) {
        XZZGoodsIntroductionSingleView * inforView = [XZZGoodsIntroductionSingleView allocInitWithFrame:CGRectMake(0, topView.bottom, ScreenWidth, 100)];
        [inforView addViewTitle:self.titleArray[i] content:self.contentArray[i]];
        [inforView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnViewTap:)]];
        [self addSubview:inforView];
        if (i == 0) {
            self.inforView = inforView;
            inforView.dividerView.hidden = YES;
        }else{
            [inforView showContentExpandedOrHidden:YES];
        }
        [inforView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (topView) {
                make.top.equalTo(topView.mas_bottom);
            }else{
                make.top.equalTo(@0);
            }
            make.left.right.equalTo(wSelf);
        }];
        topView = inforView;
    }
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.mas_bottom);
    }];
    self.height = topView.bottom;
}

- (void)clickOnViewTap:(UITapGestureRecognizer *)tap
{
    !self.goodsIntroductionView?:self.goodsIntroductionView(tap.view);
}

- (void)setInforView:(XZZGoodsIntroductionSingleView *)inforView
{
    CGFloat height = 0;
    [self.inforView showContentExpandedOrHidden:YES];
    if ([self.inforView isEqual:inforView]) {
        _inforView = nil;
        height = 40.5 * self.titleArray.count;
    }else{
        [inforView showContentExpandedOrHidden:NO];
        height = (40.5 * (self.titleArray.count - 1)) + inforView.height;
        _inforView = inforView;
    }
    [UIView animateWithDuration:.3 animations:^{
        self.height = height;
    }];
}



@end



@implementation XZZGoodsIntroductionSingleView

/***  创建视图信息 */
- (void)addViewTitle:(NSString *)title content:(NSString *)content
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    
    UILabel * titleLabel = [UILabel labelWithFrame:CGRectMake(16, 0, ScreenWidth - 16 * 2, 40) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    titleLabel.text = title;
    titleLabel.font = textFont_bold(17);
    [self addSubview:titleLabel];
    
    self.imageView = [FLAnimatedImageView allocInitWithFrame:CGRectMake(ScreenWidth - 14 - 16, 0, 9, 5)];
    self.imageView.image = imageName(@"goods_details_up");
    [self addSubview:self.imageView];
    self.imageView.centerY = titleLabel.centerY;
    
    content = [content stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    content = [content stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    content = [content stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    content = [content removeForeAndAftSpaces];
    
    self.contentLabel = [UILabel allocInitWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom, titleLabel.width, 100)];
    self.contentLabel.textColor = kColor(0x7B7B7B);
    self.contentLabel.text = content;
    self.contentLabel.font = textFont(12);
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    [self.contentLabel sizeToFit];
    
    self.contentLabel.height += 20;
    
    UIView * dividerView = [UIView allocInitWithFrame:CGRectMake(titleLabel.left, 0, ScreenWidth, .5)];
    dividerView.backgroundColor = kColor(0xF8F8F8);
    [self addSubview:dividerView];
    self.dividerView = dividerView;
    self.height = self.contentLabel.bottom + 10;
}

/***  展示内容展开或隐藏 */
- (void)showContentExpandedOrHidden:(BOOL)hidden
{
    self.contentLabel.hidden = hidden;

    [UIView animateWithDuration:.2 animations:^{
        CGFloat height = 40.5;
        if (hidden) {
            self.imageView.image = imageName(@"goods_details_an");
        }else{
            height = self.contentLabel.bottom + 10;
            self.imageView.image = imageName(@"goods_details_up");
        }
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height));
        }];
        self.height = height;
    }];
}

@end
