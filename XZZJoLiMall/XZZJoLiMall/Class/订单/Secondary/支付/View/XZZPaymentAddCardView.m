//
//  XZZPaymentAddCardView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/4.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZPaymentAddCardView.h"

@interface XZZPaymentAddCardView ()<UITextFieldDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, assign)CGFloat textHeight;

@end


@implementation XZZPaymentAddCardView

+ (instancetype)allocInit
{
    XZZPaymentAddCardView * view = [super allocInit];
    if (ScreenWidth == 320) {
        view.textHeight = 50;
    }else{
        view.textHeight = 60;
    }
    [view addView];
    return view;
}

- (void)addView{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = DIVIDER_COLOR.CGColor;
    self.layer.borderWidth = .5;
    
    WS(wSelf)
    
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInit];
    imageView.image = imageName(@"order_pay_Bank_card");
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@11);
    }];
    
    weakView(weak_imageView, imageView)
    UIView * dividerVIew = [UIView allocInit];
    dividerVIew.backgroundColor = DIVIDER_COLOR;
    [self addSubview:dividerVIew];
    [dividerVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_imageView);
        make.top.equalTo(weak_imageView.mas_bottom).offset(10);
        make.centerX.equalTo(wSelf);
        make.height.equalTo(@.5);
    }];
    weakView(weak_dividerVIew, dividerVIew)
    self.cardTextField = [self text:@"Card Number" tag:0];
    UIView * cardBackView = self.cardTextField.superview;
    [cardBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_imageView);
        make.centerX.equalTo(wSelf);
        make.top.equalTo(weak_dividerVIew.mas_bottom).offset(5);
        make.height.equalTo(@(wSelf.textHeight));
    }];
    weakView(weak_cardBackView, cardBackView)
    self.cvvTextField = [self text:@"CVV" tag:2];
    UIView * cvvBackView = self.cvvTextField.superview;
    [cvvBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.height.equalTo(weak_cardBackView);
        make.top.equalTo(weak_cardBackView.mas_bottom);
        make.width.equalTo(@130);
    }];
    weakView(weak_cvvBackView, cvvBackView)
    self.dateTextField = [self text:@"Expiration Date" tag:1];
    UIView * dateBackView = self.dateTextField.superview;
    [dateBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(weak_cardBackView);
        make.right.equalTo(weak_cvvBackView.mas_left).offset(-30);
        make.top.equalTo(weak_cvvBackView);
    }];
    
    
    self.firstNameTextField = [self text:@"First Name" tag:3];
    self.firstNameTextField.keyboardType = UIKeyboardTypeDefault;
    UIView * firstNameBackView = self.firstNameTextField.superview;
    [firstNameBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_cardBackView);
        make.height.equalTo(@(wSelf.textHeight));
        make.top.equalTo(weak_cvvBackView.mas_bottom);
        make.right.equalTo(wSelf.mas_centerX).offset(-8);
    }];
    
    weakView(weak_firstNameBackView, firstNameBackView)
    
    self.lastNameTextField = [self text:@"Last Name" tag:4];
    self.lastNameTextField.keyboardType = UIKeyboardTypeDefault;
    UIView * lastNameBackView = self.lastNameTextField.superview;
    [lastNameBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(weak_firstNameBackView);
        make.left.equalTo(wSelf.mas_centerX).offset(8);
    }];
    
    
    
    
    
    
    self.addressLabel = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x727272) textFont:10 textAlignment:(NSTextAlignmentRight) tag:1];
    [self addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weak_cardBackView);
        make.top.equalTo(weak_firstNameBackView.mas_bottom);
        make.bottom.equalTo(wSelf);
        make.height.equalTo(@30);
    }];
    
    
    
}

- (UITextField *)text:(NSString *)text tag:(NSInteger)tag
{
    UIView * view = [UIView allocInit];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputBoxForEditingTap:)]];
    view.tag = tag;
    [self addSubview:view];
    weakView(weak_view, view)
    UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 0, 0) backColor:nil textColor:kColor(0x777777) textFont:10 textAlignment:(NSTextAlignmentLeft) tag:1];
    label.text = text;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weak_view);
    }];
    weakView(weak_label, label)
    UITextField * textField = [UITextField allocInit];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.textAlignment = NSTextAlignmentRight;
    textField.delegate = self;
    [view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(weak_view);
        make.left.equalTo(weak_label.mas_right).offset(5);
    }];
    UIView * dividerView = [UIView allocInit];
    dividerView.backgroundColor = DIVIDER_COLOR;
    [view addSubview:dividerView];
    [dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weak_view);
        make.height.equalTo(@.5);
    }];
    return textField;
}

- (void)setHideNameInfor:(BOOL)hideNameInfor
{
    _hideNameInfor = hideNameInfor;
    UIView * firstNameBackView = self.firstNameTextField.superview;
    UIView * lastNameBackView = self.lastNameTextField.superview;
    if (hideNameInfor) {
        firstNameBackView.hidden = YES;
        lastNameBackView.hidden = YES;
        [firstNameBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }else{
        WS(wSelf)
        firstNameBackView.hidden = NO;
        lastNameBackView.hidden = NO;
        [firstNameBackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(wSelf.textHeight));
        }];
    }
}

- (void)inputBoxForEditingTap:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    if (tag == 0) {//银行卡号
        [self.cardTextField becomeFirstResponder];
    }else if (tag == 1){
        [self.dateTextField becomeFirstResponder];
    }else if(tag == 2){
        [self.cvvTextField becomeFirstResponder];
    }else if (tag == 3){
        [self.firstNameTextField becomeFirstResponder];
    }else if (tag == 4){
        [self.firstNameTextField becomeFirstResponder];
    }
}


//每组个数
static NSInteger const kGroupSize = 4;


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.cardTextField) {
        NSString *text = textField.text;
        NSString *beingString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *cardNo = [self removingSapceString:beingString];
        //校验卡号只能是数字，且不能超过20位
        if ( (string.length != 0 && ![self isValidNumbers:cardNo]) || cardNo.length > 20) {
            return NO;
        }
        //获取【光标右侧的数字个数】
        NSInteger rightNumberCount = [self removingSapceString:[text substringFromIndex:textField.selectedRange.location + textField.selectedRange.length]].length;
        //输入长度大于4 需要对数字进行分组，每4个一组，用空格隔开
        if (beingString.length > kGroupSize) {
            textField.text = [self groupedString:beingString];
        } else {
            textField.text = beingString;
        }
        text = textField.text;
        /**
         * 计算光标位置(相对末尾)
         * 光标右侧空格数 = 所有的空格数 - 光标左侧的空格数
         * 光标位置 = 【光标右侧的数字个数】+ 光标右侧空格数
         */
        NSInteger rightOffset = [self rightOffsetWithCardNoLength:cardNo.length rightNumberCount:rightNumberCount];
        NSRange currentSelectedRange = NSMakeRange(text.length - rightOffset, 0);
        
        //如果光标左侧是一个空格，则光标回退一格
        if (currentSelectedRange.location > 0 && [[text substringWithRange:NSMakeRange(currentSelectedRange.location - 1, 1)] isEqualToString:@" "]) {
            currentSelectedRange.location -= 1;
        }
        [textField setSelectedRange:currentSelectedRange];
        return NO;
    }
    
    if (textField == self.dateTextField) {
        if (string.length > 0) {//输入
            if ([self isValidNumbers:string]) {//输入的是数字
                int count = string.intValue;
                
                if (textField.text.length == 0) {
                    if (count > 1) {
                        string = [NSString stringWithFormat:@"0%d/", count];
                        [textField setSelectedRange:NSMakeRange(string.length, 0)];
                        textField.text = string;
                        return NO;
                    }else{
                        return YES;
                    }
                }else if (textField.text.length == 1){
                    
                    if (count > 2 && textField.text.intValue == 1) {
                        return NO;
                    }
                    string = [NSString stringWithFormat:@"%@%d/",textField.text, count];
                    [textField setSelectedRange:NSMakeRange(string.length, 0)];
                    textField.text = string;
                    return NO;
                }else if (textField.text.length >= 2 && textField.text.length < 5){
                    if (textField.text.length == 2) {
                        string = [NSString stringWithFormat:@"%@/%d",textField.text, count];
                        [textField setSelectedRange:NSMakeRange(string.length, 0)];
                        textField.text = string;
                        return NO;
                    }
                    return YES;
                }else{
                    return NO;
                }
            }else{
                return NO;
            }
        }else{
            if (textField.text.length > 4) {
                return YES;
            }
            if (textField.text.length == 4) {
                textField.text = [textField.text substringToIndex:2];
                [textField setSelectedRange:NSMakeRange(textField.text.length, 0)];
                return NO;
            }
            if (textField.text.length == 3) {
                return YES;
            }
            if ([textField.text hasPrefix:@"0"]) {
                textField.text = @"";
                return NO;
            }else{
                return YES;
            }
        }
    }
    
    if ([textField isEqual:self.cvvTextField]) {
        if (string.length > 0) {
            
            if (textField.text.length > 3) {
                return NO;
            }else{
                return YES;
            }
        }else{
            return YES;
        }
    }
    
    return YES;
}

#pragma mark - Helper
/**
 *  计算光标相对末尾的位置偏移
 *
 *  @param length           卡号的长度(不包括空格)
 *  @param rightNumberCount 光标右侧的数字个数
 *
 *  @return 光标相对末尾的位置偏移
 */
- (NSInteger)rightOffsetWithCardNoLength:(NSInteger)length rightNumberCount:(NSInteger)rightNumberCount {
    NSInteger totalGroupCount = [self groupCountWithLength:length];
    NSInteger leftGroupCount = [self groupCountWithLength:length - rightNumberCount];
    NSInteger totalWhiteSpace = totalGroupCount -1 > 0? totalGroupCount - 1 : 0;
    NSInteger leftWhiteSpace = leftGroupCount -1 > 0? leftGroupCount - 1 : 0;
    return rightNumberCount + (totalWhiteSpace - leftWhiteSpace);
}

/**
 *  校验给定字符串是否是纯数字
 *
 *  @param numberStr 字符串
 *
 *  @return 字符串是否是纯数字
 */
- (BOOL)isValidNumbers:(NSString *)numberStr {
    NSString* numberRegex = @"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    return [numberPre evaluateWithObject:numberStr];
}

/**
 *  去除字符串中包含的空格
 *
 *  @param str 字符串
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)removingSapceString:(NSString *)str {
    return [str stringByReplacingOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, str.length)];
}

/**
 *  根据长度计算分组的个数
 *
 *  @param length 长度
 *
 *  @return 分组的个数
 */
- (NSInteger)groupCountWithLength:(NSInteger)length {
    return (NSInteger)ceilf((CGFloat)length /kGroupSize);
}

/**
 *  给定字符串根据指定的个数进行分组，每一组用空格分隔
 *
 *  @param string 字符串
 *
 *  @return 分组后的字符串
 */
- (NSString *)groupedString:(NSString *)string {
    NSString *str = [self removingSapceString:string];
    NSInteger groupCount = [self groupCountWithLength:str.length];
    NSMutableArray *components = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < groupCount; i++) {
        if (i*kGroupSize + kGroupSize > str.length) {
            [components addObject:[str substringFromIndex:i*kGroupSize]];
        } else {
            [components addObject:[str substringWithRange:NSMakeRange(i*kGroupSize, kGroupSize)]];
        }
    }
    NSString *groupedString = [components componentsJoinedByString:@" "];
    return groupedString;
}






@end
