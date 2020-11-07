//
//  XZZCommentsTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/27.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCommentsTableViewCell.h"
#import "XZZStarRateView.h"


@interface XZZCommentsTableViewCell ()

/**
 * 姓名
 */
@property (nonatomic, strong)UILabel * nameLabel;
/**
 * 时间
 */
@property (nonatomic, strong)UILabel * dateLabel;
/**
 * 内容
 */
@property (nonatomic, strong)UILabel * contentLabel;
/**
 * 评分分数
 */
@property (nonatomic, strong)XZZStarRateView * starRateView;
/**
 * 信息
 */
@property (nonatomic, strong)UILabel * commentsInforLabel;
/**
 * 图片背景信息
 */
@property (nonatomic, strong)UIView * imageBackView;

@end


@implementation XZZCommentsTableViewCell


/**
 *  计算高度
 */
+ (CGFloat)calculateHeightCell:(XZZGoodsComments *)comments
{
    CGFloat height = [CalculateHeight getLabelHeightTitle:comments.content font:11 width:ScreenWidth - 35 * 2];
    height += 10;
    
    CGFloat imageheight = (ScreenWidth - 16 * 4) / 3.0;
    if (comments.pictureList.count <= 0) {
        imageheight = 0;
    }
    
    return 5/*top*/ + 20/*星星高度*/ + 5/*星星与name间距*/ + 15/*name高度*/ + 5/*name与合身程度的距离*/ + 15/*合身程度高的*/ + 8/*合身程度与内容的距离*/ + height/*内容高的*/ + 10 + imageheight + 2;
    return 10/**/ + 15 + 10 + height + 5 + 20 + 10 + 15 + 10 + imageheight + 10;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self addView];
        [self addViewNew];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setGoodsComments:(XZZGoodsComments *)goodsComments
{
    _goodsComments = goodsComments;
    
    self.nameLabel.text = [XZZFormatValidation stringSubstitution:goodsComments.username];
    self.dateLabel.text = [self timeFormat:@"MMM-d/yyyy HH:mm:ss" conversionDate:goodsComments.commentTime];
    self.contentLabel.text = goodsComments.content;
    NSString * infor = @"";
    if (/* DISABLES CODE */ (0)) {//没有尺寸
        infor = [NSString stringWithFormat:@"Size:%@    ", @""];
    }
    if (/* DISABLES CODE */ (0)) {//没有颜色
        infor = [NSString stringWithFormat:@"%@Color:%@    ", infor, @""];
    }
    
    NSString * fit = @"Ture to Size";
    
    if (goodsComments.suitability == 0) {
        fit = @"Small";
    }else if (goodsComments.suitability == 2){
        fit = @"Big";
    }
    infor = [NSString stringWithFormat:@"%@Fit:%@", infor, fit];
    self.commentsInforLabel.text = infor;
    
    self.starRateView.currentScore = goodsComments.score;
    
    [self.imageBackView removeAllSubviews];
    CGFloat imageWidth = (ScreenWidth - 16 * 4) / 3.0;
    CGFloat left = 0;
    for (int i = 0; i < goodsComments.pictureList.count; i++) {
        if (i < 3) {
            UIImageView * imageView = [UIImageView allocInitWithFrame:CGRectMake(left, 0, imageWidth, imageWidth)];
            [imageView addImageFromUrlStr:goodsComments.pictureList[i]];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [imageView cutRounded:5];
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageView:)]];
            [self.imageBackView addSubview:imageView];
            left = imageView.right + 10;
        }else{
            break;
        }
    }
}

- (void)clickOnImageView:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(viewLargerVersionImages:imageView:index:)]) {
        [self.delegate viewLargerVersionImages:self.goodsComments.pictureList imageView:tap.view index:tap.view.tag];
    }
}


- (void)addViewNew{
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
    
    self.starRateView = [XZZStarRateView allocInitWithFrame:CGRectMake(self.contentLabel.left, 0, 50, 20)];
    self.starRateView.userInteractionEnabled = NO;
    [self addSubview:self.starRateView];
    [self.starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@5);
        make.width.equalTo(@50);
        make.height.equalTo(@20);
    }];
    
    self.nameLabel = [UILabel labelWithFrame:CGRectMake(10, 10, 100, 15) backColor:nil textColor:kColor(0x191919) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.starRateView);
        make.top.equalTo(wSelf.starRateView.mas_bottom).offset(5);
        make.height.equalTo(@15);
    }];
    
    self.dateLabel = [UILabel labelWithFrame:CGRectMake(10, 10, 100, 15) backColor:nil textColor:kColor(0x828282) textFont:11 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf).offset(-12);
        make.centerY.equalTo(wSelf.nameLabel);
    }];
    
    
    self.commentsInforLabel = [UILabel labelWithFrame:CGRectMake(10, 10, 100, 15) backColor:nil textColor:kColor(0x4d4d4d) textFont:11 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.commentsInforLabel];
    [self.commentsInforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.starRateView);
        make.top.equalTo(wSelf.nameLabel.mas_bottom).offset(5);
        make.height.equalTo(@15);
    }];
    
    
    self.contentLabel = [UILabel labelWithFrame:CGRectMake(35, 10, 100, 15) backColor:nil textColor:kColor(0x000000) textFont:11 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.nameLabel);
        make.centerX.equalTo(wSelf);
        make.top.equalTo(wSelf.commentsInforLabel.mas_bottom).offset(8);
    }];
    

    
    

    
    self.imageBackView = [UIView allocInitWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:self.imageBackView];
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(wSelf.contentLabel.mas_bottom).offset(10);
        make.centerX.equalTo(wSelf);
        make.bottom.equalTo(wSelf).offset(-2);
    }];
}

- (void)addView{
    self.backgroundColor = [UIColor whiteColor];
    WS(wSelf)
    self.nameLabel = [UILabel labelWithFrame:CGRectMake(10, 10, 100, 15) backColor:nil textColor:kColor(0x4d4d4d) textFont:11 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.height.equalTo(@15);
    }];
    
    self.dateLabel = [UILabel labelWithFrame:CGRectMake(10, 10, 100, 15) backColor:nil textColor:kColor(0x828282) textFont:11 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf).offset(-10);
        make.centerY.equalTo(wSelf.nameLabel);
    }];
    
    self.contentLabel = [UILabel labelWithFrame:CGRectMake(35, 10, 100, 15) backColor:nil textColor:kColor(0x000000) textFont:11 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@35);
        make.centerX.equalTo(wSelf);
        make.top.equalTo(wSelf.nameLabel.mas_bottom).offset(10);
    }];
    
    self.starRateView = [XZZStarRateView allocInitWithFrame:CGRectMake(self.contentLabel.left, 0, 50, 20)];
    self.starRateView.userInteractionEnabled = NO;
    [self addSubview:self.starRateView];
    [self.starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.contentLabel);
        make.top.equalTo(wSelf.contentLabel.mas_bottom).offset(5);
        make.width.equalTo(@50);
        make.height.equalTo(@20);
    }];
    
    
    self.commentsInforLabel = [UILabel labelWithFrame:CGRectMake(10, 10, 100, 15) backColor:nil textColor:kColor(0x4d4d4d) textFont:11 textAlignment:(NSTextAlignmentLeft) tag:1];
    [self addSubview:self.commentsInforLabel];
    [self.commentsInforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.starRateView);
        make.top.equalTo(wSelf.starRateView.mas_bottom).offset(10);
        make.height.equalTo(@15);
    }];
    
    self.imageBackView = [UIView allocInitWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:self.imageBackView];
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(wSelf.commentsInforLabel.mas_bottom).offset(10);
        make.centerX.equalTo(wSelf);
        make.bottom.equalTo(wSelf).offset(-10);
    }];
}



@end
