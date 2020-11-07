//
//  XZZChatTableViewCell.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZChatTableViewCell.h"
#import "ZDCChatEvent+XZZChatEvent.h"

@implementation XZZChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)getTime
{
    static NSDateFormatter * formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM-dd/YYYY HH:mm:ss"];
    }
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:self.event.timestamp.integerValue / 1000];
    return [formatter stringFromDate:date];
    
}

- (void)setEvent:(ZDCChatEvent *)event
{
    _event = event;

    self.timeLabel.text = self.getTime;
    
    if (event.type == ZDCChatEventTypeVisitorUpload || event.type == ZDCChatEventTypeAgentUpload) {
        
        if (event.image) {
            self.messageImageView.image = event.image;
        }else{
            [self.messageImageView addImageFromUrlStr:self.getImageUrl httpBlock:^(id data, BOOL successful, NSError *error) {
                if (successful) {
                }
            }];
        }

        self.messageImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.messageImageView.clipsToBounds = YES;
        
    }else{
//        self.messageTextView.text = event.message;
//        self.messageTextView.font = textFont(14);
        self.messageLabel.text = event.message;
        [self messageViewWithWideHigh];
//        self.messageTextView.backgroundColor = [UIColor clearColor];
    }
    
    

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


- (BOOL)messageViewWithWideHigh
{
    CGFloat width = ScreenWidth * (3.0 / 4.0) - 18 - 10;
    CGFloat height = 20;
    CGFloat twoWidth = [CalculateHeight getLabelWidthTitle:self.messageLabel.text font:self.messageLabel.font.pointSize height:height];
    CGFloat twoHeight = [CalculateHeight getLabelHeightTitle:self.messageLabel.text font:self.messageLabel.font.pointSize width:width];
    if (width > twoWidth && height > twoHeight) {
        return YES;
    }
    return NO;
    
    
    return width > twoWidth;
//    if (width < twoWidth) {
//        if ([self isKindOfClass:[XZZChatMyMessageTableViewCell class]]) {
//
//        }else if ([self isKindOfClass:[XZZChatMyImageMessageTableViewCell class]]){
//
//        }
//    }
    
    
//    [self.messageLabel sizeToFit];
//    width = self.messageLabel.width > width ? width : self.messageLabel.width;
//    height = self.messageLabel.height + 10;
//    [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@(width));
//        make.height.equalTo(@(height));
//    }];
    
    
//    self.messageTextView.scrollEnabled = NO;
//    CGFloat twoWidth = [CalculateHeight getLabelWidthTitle:self.messageTextView.text font:16 height:height] + 15;
////    twoWidth = twoWidth > 90 ? twoWidth : 90;
//    width = twoWidth > width ? width : twoWidth;
//    height = [CalculateHeight getLabelHeightTitle:self.messageTextView.text font:16 width:width] + 10;
//    self.messageTextView.width = width;
//    self.messageTextView.height = height;
//
//    [self.messageTextView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@(width));
//        make.height.equalTo(@(height));
//    }];
    
    
    
}

- (NSString *)getImageUrl
{
//    if (self.event.imaegUrl) {
//        return self.event.imaegUrl;
//    }
    NSArray * array = [self.event.message componentsSeparatedByString:@"\n"];
    
    for (NSString * str in array) {
        if ([str hasPrefix:@"URL: "]) {
            return [[str componentsSeparatedByString:@"URL: "] lastObject];
        }
    }
    
    
    
    
    return @"";
}

@end

#pragma mark ---- *  聊天消息  我的消息
/**
 *  聊天消息  我的消息
 */
@implementation XZZChatMyMessageTableViewCell

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
    backView.image = [[UIImage imageNamed:@"chat_my_message"] resizableImageWithCapInsets:UIEdgeInsetsMake(26, 18, 16, 26) resizingMode:UIImageResizingModeStretch];
    backView.userInteractionEnabled = YES;
    [self addSubview:backView];
    self.backView = backView;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_headPortraitImageV);
        make.right.equalTo(weak_headPortraitImageV.mas_left).offset(-5);
        make.width.lessThanOrEqualTo(@(width));
        make.bottom.equalTo(wSelf).offset(-11);
    }];
    
    weakView(weak_backView, backView)
    self.messageLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xffffff) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.messageLabel.numberOfLines = 0;    
    [backView addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.right.equalTo(weak_backView).offset(-18);
        make.centerY.equalTo(weak_backView);
    }];

}

- (BOOL)messageViewWithWideHigh
{
    if ([super messageViewWithWideHigh]) {
        self.backView.image = [[UIImage imageNamed:@"chat_my_message_A_line_of"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17, 0, 26) resizingMode:UIImageResizingModeStretch];
        [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@4);
        }];
    }else{
        self.backView.image = [[UIImage imageNamed:@"chat_my_message"] resizableImageWithCapInsets:UIEdgeInsetsMake(26, 18, 16, 26) resizingMode:UIImageResizingModeStretch];
        [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
        }];
    }
    return YES;
}

@end

#pragma mark ---- *  聊天消息  我的图片消息
/**
 *  聊天消息  我的图片消息
 */
@implementation XZZChatMyImageMessageTableViewCell
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
    self.backView = backView;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_headPortraitImageV);
        make.right.equalTo(weak_headPortraitImageV.mas_left).offset(-5);
        make.width.lessThanOrEqualTo(@(width));
        make.bottom.equalTo(wSelf).offset(-11);
    }];
    
    weakView(weak_backView, backView)
    self.messageImageView = [FLAnimatedImageView allocInit];
    self.messageImageView.userInteractionEnabled = YES;
    [self.messageImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageView)]];
    [backView addSubview:self.messageImageView];
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.height.equalTo(@300);
        make.right.equalTo(weak_backView).offset(-15);
        make.bottom.equalTo(weak_backView).offset(-8);
    }];
    
    
//    self.timeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0xffffff) textFont:8 textAlignment:(NSTextAlignmentRight) tag:1];
//    [backView addSubview:self.timeLabel];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(wSelf.messageImageView);
//        make.top.equalTo(wSelf.messageImageView.mas_bottom);
//        make.height.equalTo(@20);
//        make.bottom.equalTo(weak_backView);
//    }];
}

- (void)clickOnImageView
{
    if ([self.delegate respondsToSelector:@selector(viewLargerVersionImage:)]) {
        UIImage * image = self.messageImageView.image;
        FLAnimatedImage * adimatedImage = self.messageImageView.animatedImage;
        id imageInfor = image;
        imageInfor = imageInfor ? imageInfor : adimatedImage;
        imageInfor = imageInfor ? imageInfor : self.getImageUrl;
        [self.delegate viewLargerVersionImage:imageInfor];
    }
}



@end

#pragma mark ---- *  聊天消息  服务器消息
/**
 *  聊天消息  服务器消息
 */
@implementation XZZChatServerMessageTableViewCell
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
    
    UIImageView * headPortraitImageV = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"chat_service_head"];
    [self addSubview:headPortraitImageV];
    [headPortraitImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@11);
        make.height.width.equalTo(@36);
    }];
    
    weakView(weak_headPortraitImageV, headPortraitImageV)
    UIImageView * backView = [UIImageView allocInit];
    backView.image = [[UIImage imageNamed:@"chat_server_message"] resizableImageWithCapInsets:UIEdgeInsetsMake(26, 26, 16, 20) resizingMode:UIImageResizingModeStretch]; ;
    backView.userInteractionEnabled = YES;
    [self addSubview:backView];
    self.backView = backView;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_headPortraitImageV);
        make.left.equalTo(weak_headPortraitImageV.mas_right).offset(5);
        make.width.lessThanOrEqualTo(@(width));
        make.bottom.equalTo(wSelf).offset(-11);
    }];
    
    weakView(weak_backView, backView)
    self.messageLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.messageLabel.numberOfLines = 0;
    [backView addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.top.equalTo(@10);
        make.right.equalTo(weak_backView).offset(-10);
        make.centerY.equalTo(weak_backView);
    }];
    
//    self.messageTextView = [UITextView allocInit];
//    [self.messageTextView setSelectable: YES];
//    [self.messageTextView setEditable:NO];
//    self.messageTextView.dataDetectorTypes = UIDataDetectorTypeLink;
//    self.messageTextView.delegate = self;
//    [backView addSubview:self.messageTextView];
//    [self.messageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@15);
//        make.top.equalTo(@0);
//        make.right.equalTo(weak_backView).offset(-8);
//        make.bottom.equalTo(weak_backView).offset(-0);
//    }];
    
//    self.timeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:8 textAlignment:(NSTextAlignmentLeft) tag:1];
//    [backView addSubview:self.timeLabel];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(wSelf.messageTextView);
//        make.top.equalTo(wSelf.messageTextView.mas_bottom);
//        make.height.equalTo(@20);
//        make.bottom.equalTo(weak_backView);
//    }];
}

- (BOOL)messageViewWithWideHigh
{
    if ([super messageViewWithWideHigh]) {
        self.backView.image = [[UIImage imageNamed:@"chat_server_message_A_line_of"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 26, 0, 17) resizingMode:UIImageResizingModeStretch]; ;
        [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@4);
        }];
    }else{
        self.backView.image = [[UIImage imageNamed:@"chat_server_message"] resizableImageWithCapInsets:UIEdgeInsetsMake(26, 26, 16, 20) resizingMode:UIImageResizingModeStretch];
        [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
        }];
    }
    return YES;
}

@end

#pragma mark ---- *  聊天消息  服务器图片
/**
 *  聊天消息  服务器图片
 */
@implementation XZZChatServerImageMessageTableViewCell
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
    
    UIImageView * headPortraitImageV = [UIImageView allocInitWithFrame:CGRectMake(0, 0, 0, 0) imageName:@"chat_service_head"];
    [self addSubview:headPortraitImageV];
    [headPortraitImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@11);
        make.height.width.equalTo(@36);
    }];
    
    weakView(weak_headPortraitImageV, headPortraitImageV)
    UIImageView * backView = [UIImageView allocInit];
    backView.image = [[UIImage imageNamed:@"chat_server_message"] resizableImageWithCapInsets:UIEdgeInsetsMake(26, 26, 16, 20) resizingMode:UIImageResizingModeStretch]; ;
    backView.userInteractionEnabled = YES;
    [self addSubview:backView];
    self.backView = backView;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_headPortraitImageV);
        make.left.equalTo(weak_headPortraitImageV.mas_right).offset(5);
        make.width.lessThanOrEqualTo(@(width));
        make.bottom.equalTo(wSelf).offset(-11);
    }];
    
    weakView(weak_backView, backView)
    self.messageImageView = [FLAnimatedImageView allocInit];
    self.messageImageView.userInteractionEnabled = YES;
    [self.messageImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnImageView)]];
    [backView addSubview:self.messageImageView];
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@10);
        make.height.equalTo(@300);
        make.centerX.equalTo(weak_backView);
        make.bottom.equalTo(weak_backView).offset(-8);
    }];
    
//
//    self.timeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:8 textAlignment:(NSTextAlignmentLeft) tag:1];
//    [backView addSubview:self.timeLabel];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(wSelf.messageImageView);
//        make.top.equalTo(wSelf.messageImageView.mas_bottom);
//        make.height.equalTo(@20);
//        make.bottom.equalTo(weak_backView);
//    }];
}

- (void)clickOnImageView
{
    if ([self.delegate respondsToSelector:@selector(viewLargerVersionImage:)]) {
        UIImage * image = self.messageImageView.image;
        FLAnimatedImage * adimatedImage = self.messageImageView.animatedImage;
        id imageInfor = image;
        imageInfor = imageInfor ? imageInfor : adimatedImage;
        imageInfor = imageInfor ? imageInfor : self.getImageUrl;
        [self.delegate viewLargerVersionImage:imageInfor];
    }
}



@end

#pragma mark ---- *  聊天消息  评价
/**
 *  聊天消息  评价
 */
@implementation XZZChatRatingMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

- (void)addView{
    NSLog(@"%s %d 行", __func__, __LINE__);
    WS(wSelf)
    
    CGFloat width = ScreenWidth * (2.0 / 4.0);
    UIView * backView = [UIView allocInit];
    backView.layer.borderWidth = 1;
    backView.layer.borderColor = [UIColor blackColor].CGColor;
    backView.layer.cornerRadius = 5;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.center.equalTo(wSelf);
        make.width.equalTo(@(width));
    }];
    weakView(weak_backView, backView)
    self.messageLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentLeft) tag:1];
    self.messageLabel.numberOfLines = 0;
    [backView addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@8);
        make.centerX.equalTo(weak_backView);
    }];
    
    
    
    
    
//    self.timeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:8 textAlignment:(NSTextAlignmentLeft) tag:1];
//    [backView addSubview:self.timeLabel];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(wSelf.messageLabel);
//        make.top.equalTo(wSelf.messageLabel.mas_bottom);
//        make.height.equalTo(@20);
//    }];
    
    self.goodsButton = [UIButton allocInitWithImageName:@"chat_rating_goods" selectedImageName:@"chat_rating_goods_selected"];
    [self.goodsButton addTarget:self action:@selector(chatGood) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:self.goodsButton];
    [self.goodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(wSelf.messageLabel.mas_bottom).offset(15);
        make.height.equalTo(@30);
        make.bottom.equalTo(weak_backView);
    }];
    
    self.badButton = [UIButton allocInitWithImageName:@"chat_rating_bad" selectedImageName:@"chat_rating_bad_selected"];
    [self.badButton addTarget:self action:@selector(chatBad) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:self.badButton];
    [self.badButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.goodsButton.mas_right);
        make.top.bottom.width.equalTo(wSelf.goodsButton);
        make.right.equalTo(weak_backView);
    }];
    
    
}

- (void)setEvent:(ZDCChatEvent *)event
{
    [super setEvent:event];
    
    

        self.messageLabel.text = @"已对聊天进行评价";
        if (event.rating == ZDCChatRatingBad) {
            self.badButton.selected = YES;
            self.goodsButton.selected = NO;
            self.userInteractionEnabled = NO;
        }else if(event.rating == ZDCChatRatingGood){
            self.badButton.selected = NO;
            self.goodsButton.selected = YES;
            self.userInteractionEnabled = NO;
        }
}

- (void)chatGood
{
    if ([self.delegate respondsToSelector:@selector(commentOnChatRating:)]) {
        [self.delegate commentOnChatRating:ZDCChatRatingGood];
//        self.event.rating = ZDCChatRatingGood;
//        self.event = self.event;
    }
}

- (void)chatBad{
    if ([self.delegate respondsToSelector:@selector(commentOnChatRating:)]) {
        [self.delegate commentOnChatRating:ZDCChatRatingBad];
//        self.event.rating = ZDCChatRatingBad;
//        self.event = self.event;
    }
}


@end



#pragma mark ---- *  聊天消息
/**
 *  聊天消息
 */
@implementation XZZChatMessageTableViewCell
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

    WS(wSelf)
    
    UIView * backView = [UIView allocInit];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.left.equalTo(@30);
        make.centerX.equalTo(wSelf);
        make.bottom.equalTo(wSelf).offset(-11);
    }];
    
    weakView(weak_backView, backView)
    self.messageLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:14 textAlignment:(NSTextAlignmentCenter) tag:1];
    self.messageLabel.numberOfLines = 0;
    [backView addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@8);
        make.centerX.equalTo(weak_backView);
    }];
    
    self.timeLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x000000) textFont:8 textAlignment:(NSTextAlignmentCenter) tag:1];
    [backView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf.messageLabel);
        make.top.equalTo(wSelf.messageLabel.mas_bottom);
        make.height.equalTo(@20);
        make.bottom.equalTo(weak_backView);
    }];
}



@end
