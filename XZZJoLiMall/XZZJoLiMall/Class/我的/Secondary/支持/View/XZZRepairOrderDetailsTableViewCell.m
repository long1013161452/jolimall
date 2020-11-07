//
//  XZZRepairOrderDetailsTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/13.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZRepairOrderDetailsTableViewCell.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation XZZRepairOrderDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCommentWithUser:(ZDKCommentWithUser *)commentWithUser
{
    _commentWithUser = commentWithUser;
    
    self.timeLabel.text = self.getTime;
    
    if (commentWithUser.user.isAgent) {
        self.contenttextView.attributedText = [[NSMutableAttributedString alloc] initWithData:[commentWithUser.comment.htmlBody dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    }else{
        NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithData:[commentWithUser.comment.htmlBody dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        [attributedStr addAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} range:NSMakeRange(0, attributedStr.length)];
        self.contenttextView.attributedText = attributedStr;
    }
//    self.contentLabel.attributedText = self.contenttextView.attributedText;
    self.backView.userInteractionEnabled = YES;
    self.contenttextView.delegate = self;
    self.contenttextView.backgroundColor = [UIColor clearColor];
    
}



- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    NSLog(@"%@", URL);
    //可在此做业务需求的跳转
    if ([self.delegate respondsToSelector:@selector(enterPageWebViewUrl:title:)]) {
        [self.delegate enterPageWebViewUrl:URL title:nil];
    }
    return NO;//返回YES，直接跳转Safari
    
}


- (void)contenttextViewWithWideHigh
{
    CGFloat width = ScreenWidth * (3.0 / 4.0) - 15 - 8;
    CGFloat height = 20;
    
    if (self.commentWithUser.comment.attachments.count <= 0) {
        CGFloat twoWidth = [CalculateHeight getLabelWidthTitle:self.contenttextView.attributedText size:CGSizeMake(width, height)] + 15;
        twoWidth = twoWidth > 90 ? twoWidth : 90;
        width = twoWidth > width ? width : twoWidth;
    }
    height = [CalculateHeight getLabelHeightTitle:self.contenttextView.attributedText size:CGSizeMake(width, height)] + 10;
    self.contenttextView.width = width;
    height = self.contenttextView.contentSize.height;

    self.contenttextView.height = height;
    [self.contenttextView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@0);
        make.width.equalTo(@(width));
        make.height.equalTo(@(height));
    }];
}


- (NSString *)getTime
{
    static NSDateFormatter * formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM-dd/YYYY HH:mm:ss"];
    }
    
    return [formatter stringFromDate:self.commentWithUser.comment.createdAt];
}


@end



@implementation XZZServerRepairOrderDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

- (void)addView{
    
    NSLog(@"%s %d 行", __func__, __LINE__);
    CGFloat width = ScreenWidth * (3.0 / 4.0);
    WS(wSelf)
    
    UIImageView * headPortraitImageV = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"chat_service_head"];
    [self addSubview:headPortraitImageV];
    [headPortraitImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@11);
        make.height.width.equalTo(@36);
    }];
    
    weakView(weak_headPortraitImageV, headPortraitImageV)
    UIImageView * backView = [UIImageView allocInit];
    backView.image = [[UIImage imageNamed:@"chat_server_message"] resizableImageWithCapInsets:UIEdgeInsetsMake(26, 26, 16, 20) resizingMode:UIImageResizingModeStretch];
    backView.userInteractionEnabled = YES;
    [self addSubview:backView];

    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_headPortraitImageV);
        make.left.equalTo(weak_headPortraitImageV.mas_right).offset(5);
        make.width.lessThanOrEqualTo(@(width));
        make.bottom.equalTo(wSelf).offset(-11);
    }];
    weakView(weak_backView, backView)
    
    self.contentLabel = [UILabel allocInit];
    self.contentLabel.numberOfLines = 0;
        self.contentLabel.alpha = 0;
    [backView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@0);
        make.right.equalTo(weak_backView).offset(-8);
    }];
    
    self.contenttextView = [UITextView allocInit];
    [self.contenttextView setSelectable: YES];
    [self.contenttextView setEditable:NO];
    self.contenttextView.scrollEnabled = NO;
    self.contenttextView.dataDetectorTypes = UIDataDetectorTypeLink;
    [backView addSubview:self.contenttextView];
    [self.contenttextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.contentLabel);
        make.bottom.equalTo(wSelf.contentLabel);
        make.left.equalTo(wSelf.contentLabel).offset(-5);
        make.top.equalTo(wSelf.contentLabel);
    }];
    
    
    self.imageBackView = [UIView allocInit];
    [backView addSubview:self.imageBackView];
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weak_backView);
        make.top.equalTo(wSelf.contenttextView.mas_bottom).offset(-40);
    }];
    
    self.timeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:8 textAlignment:(NSTextAlignmentLeft) tag:1];
    [backView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.contenttextView);
        make.left.equalTo(wSelf.contenttextView).offset(5);
        make.top.equalTo(wSelf.imageBackView.mas_bottom);
        make.height.equalTo(@20);
        make.bottom.equalTo(weak_backView);
    }];
    
    
}

- (void)setCommentWithUser:(ZDKCommentWithUser *)commentWithUser
{
    [super setCommentWithUser:commentWithUser];
    
    [self.imageBackView removeAllSubviews];
    WS(wSelf)
    UIView * topView = nil;
    int tag = 0;
    for (ZDKAttachment * attachment in commentWithUser.comment.attachments) {
        weakView(weak_topView, topView)
        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInit];
        [imageView setImageFromUrl:attachment.contentURLString];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageView:)]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        imageView.tag = tag;
        [self.imageBackView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.height.equalTo(@300);
            make.centerX.equalTo(wSelf.imageBackView);
            if (weak_topView) {
                make.top.equalTo(weak_topView.mas_bottom).offset(5);
            }else{
                make.top.equalTo(@5);
            }
        }];
        topView = imageView;
        tag++;
    }
    if (topView) {
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(wSelf.imageBackView).offset(-5);
        }];
    }
    
}


- (void)clickOnImageView:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(viewLargerVersionImage:)]) {
        FLAnimatedImageView * imageView = (FLAnimatedImageView *)tap.view;
        UIImage * image = imageView.image;
        FLAnimatedImage * adimatedImage = imageView.animatedImage;
        ZDKAttachment * attachment = self.commentWithUser.comment.attachments[imageView.tag];
        id imageInfor = adimatedImage;
        imageInfor = imageInfor ? imageInfor : image;
        imageInfor = imageInfor ? imageInfor : attachment.contentURLString;
        [self.delegate viewLargerVersionImage:imageInfor];
    }
}


@end

#pragma mark ----我发送的消息
@implementation XZZMyRepairOrderDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

- (void)addView
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    
    CGFloat width = ScreenWidth * (3.0 / 4.0);
    WS(wSelf)
    
    UIImageView * headPortraitImageV = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"chat_My_head"];
    [self addSubview:headPortraitImageV];
    [headPortraitImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@11);
        make.right.equalTo(wSelf).offset(-11);
        make.height.width.equalTo(@36);
    }];
    
    weakView(weak_headPortraitImageV, headPortraitImageV)
    UIImageView * backView = [UIImageView allocInit];
    backView.image = [[UIImage imageNamed:@"chat_my_message"] resizableImageWithCapInsets:UIEdgeInsetsMake(26, 18, 16, 26) resizingMode:UIImageResizingModeStretch]; ;
    backView.userInteractionEnabled = YES;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_headPortraitImageV);
        make.right.equalTo(weak_headPortraitImageV.mas_left).offset(-5);
        make.width.lessThanOrEqualTo(@(width));
        make.bottom.equalTo(wSelf).offset(-11);
    }];
    
    weakView(weak_backView, backView)
    
    self.contentLabel = [UILabel allocInit];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.alpha = 0;
    [backView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@0);
        make.right.equalTo(weak_backView).offset(-15);
    }];
    
    self.contenttextView = [UITextView allocInit];
    [self.contenttextView setSelectable: YES];
    [self.contenttextView setEditable:NO];
    self.contenttextView.scrollEnabled = NO;
    self.contenttextView.dataDetectorTypes = UIDataDetectorTypeLink;
    [backView addSubview:self.contenttextView];
    [self.contenttextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@8);
//        make.top.equalTo(@5);
//        make.right.equalTo(weak_backView).offset(-15);
        make.left.equalTo(wSelf.contentLabel).offset(-5);
        make.top.equalTo(wSelf.contentLabel).offset(-0);
        make.centerX.equalTo(wSelf.contentLabel);
        make.bottom.equalTo(wSelf.contentLabel).offset(-30);
    }];
    
    self.imageBackView = [UIView allocInit];
    [backView addSubview:self.imageBackView];
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weak_backView);
        make.top.equalTo(wSelf.contenttextView.mas_bottom).offset(-40);
    }];
    
    self.timeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xffffff) textFont:8 textAlignment:(NSTextAlignmentRight) tag:1];
    [backView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.contenttextView);
        make.right.equalTo(wSelf.contenttextView).offset(-5);
        make.width.greaterThanOrEqualTo(@90);
        make.top.equalTo(wSelf.imageBackView.mas_bottom);
        make.height.equalTo(@20);
        make.bottom.equalTo(weak_backView);
    }];
}


- (void)setCommentWithUser:(ZDKCommentWithUser *)commentWithUser
{
    [super setCommentWithUser:commentWithUser];
    
    [self.imageBackView removeAllSubviews];
    WS(wSelf)
    UIView * topView = nil;
    int tag = 0;
    for (ZDKAttachment * attachment in commentWithUser.comment.attachments) {
        weakView(weak_topView, topView)
        FLAnimatedImageView * imageView = [FLAnimatedImageView allocInit];
        [imageView setImageFromUrl:attachment.contentURLString];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageView:)]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        imageView.tag = tag;
        [self.imageBackView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.height.equalTo(@300);
            make.centerX.equalTo(wSelf.imageBackView);
            if (weak_topView) {
                make.top.equalTo(weak_topView.mas_bottom).offset(5);
            }else{
                make.top.equalTo(@5);
            }
        }];
        topView = imageView;
        tag++;
    }
    if (topView) {
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(wSelf.imageBackView).offset(-5);
        }];
    }
    
}


- (void)clickOnImageView:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(viewLargerVersionImage:)]) {
        FLAnimatedImageView * imageView = (FLAnimatedImageView *)tap.view;
        UIImage * image = imageView.image;
        FLAnimatedImage * adimatedImage = imageView.animatedImage;
        ZDKAttachment * attachment = self.commentWithUser.comment.attachments[imageView.tag];
        id imageInfor = adimatedImage;
        imageInfor = imageInfor ? imageInfor : image;
        imageInfor = imageInfor ? imageInfor : attachment.contentURLString;
        [self.delegate viewLargerVersionImage:imageInfor];
    }
}

@end
