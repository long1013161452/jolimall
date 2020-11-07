//
//  XZZAsiaBillPay.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/20.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZAsiaBillPay.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

//#import <AsiabillSDK/AsiabillSDK.h>

@interface XZZAsiaBillPay ()


/**
 *  商户号
 */
@property(nonatomic, copy) NSString * merNo;

/**
 *  网管接入号
 */
@property(nonatomic, copy) NSString * gatewayNo;

/**
 *  订单号
 */
@property(nonatomic, copy) NSString * orderNo;

/**
 *  交易币种
 */
@property(nonatomic, copy) NSString * orderCurrency;

/**
 *  交易金额
 */
@property(nonatomic, copy) NSString * orderAmount;



/**
 *  signkey
 */
@property(nonatomic, copy) NSString * signkey;

@property(nonatomic, copy) NSString * firstName;

@property(nonatomic, copy) NSString * lastName;

@property(nonatomic, copy) NSString * email;

@property(nonatomic, copy) NSString * phone;

/**
 *  支付方式
 */
@property(nonatomic, copy) NSString * paymentMethod;

@property(nonatomic, copy) NSString * country;

@property(nonatomic, copy) NSString * city;

@property(nonatomic, copy) NSString * address;

@property(nonatomic, copy) NSString * zip;

@property(nonatomic, copy) NSString * remark;

@property(nonatomic, copy) NSString * merWebsite;

@property(nonatomic, copy) NSString * interfaceInfo;

@property(nonatomic, copy) NSString * interfaceVersion;

/**
 *  客户端类型
 */
@property(nonatomic, copy) NSString * isMobile;

@property(nonatomic, copy) NSString * payType;

/**
 *  签名数据
 */
@property(nonatomic, copy) NSString * signInfo;

/**
 * 【后台通知地址】
 */
@property (nonatomic, strong)NSString * callbackUrl;


@end



@implementation XZZAsiaBillPay



//将商品信息拼接成字符串
- (NSString *)description {
    NSMutableString * discription = [NSMutableString string];
    
//    if (self.merNo && self.gatewayNo && self.orderNo && self.orderCurrency && self.orderAmount && self.returnUrl ) {
//        NSString *beforeSha256 = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", self.merNo, self.gatewayNo, self.orderNo, self.orderCurrency, self.orderAmount, self.returnUrl, self.signkey];
//        self.signInfo = [self sha256:beforeSha256];
//    }
    
    if (self.merNo) {
        [discription appendFormat:@"merNo=%@",self.merNo];
    }
    
    if (self.gatewayNo) {
        [discription appendFormat:@"&gatewayNo=%@",self.gatewayNo];
    }
    
    if (self.orderNo) {
        [discription appendFormat:@"&orderNo=%@",self.orderNo];
    }
    
    if (self.orderCurrency) {
        [discription appendFormat:@"&orderCurrency=%@",self.orderCurrency];
    }
    
    if (self.orderAmount) {
        [discription appendFormat:@"&orderAmount=%@",self.orderAmount];
    }
    
    if (self.signInfo) {
        [discription appendFormat:@"&signInfo=%@",self.signInfo];
    }
    
    if (self.returnUrl) {
        [discription appendFormat:@"&returnUrl=%@",self.returnUrl];
    }
    
    if (self.firstName) {
        [discription appendFormat:@"&firstName=%@",self.firstName];
    }
    
    if (self.lastName) {
        [discription appendFormat:@"&lastName=%@",self.lastName];
    }
    
    if (self.email) {
        [discription appendFormat:@"&email=%@",self.email];
    }
    
    if (self.phone) {
        [discription appendFormat:@"&phone=%@",self.phone];
    }
    
    if (self.paymentMethod) {
        [discription appendFormat:@"&paymentMethod=%@",self.paymentMethod];
    }
    
    if (self.country) {
        [discription appendFormat:@"&country=%@",self.country];
    }
    
    if (self.city) {
        [discription appendFormat:@"&city=%@",self.city];
    }
    
    if (self.address) {
        [discription appendFormat:@"&address=%@",self.address];
    }
    
    if (self.zip) {
        [discription appendFormat:@"&zip=%@",self.zip];
    }
    
    if (self.remark) {
        [discription appendFormat:@"&remark=%@",self.remark];
    }
    
    if (self.merWebsite) {
        [discription appendFormat:@"&merWebsite=%@",self.merWebsite];
    }
    
    if (self.interfaceInfo) {
        [discription appendFormat:@"&interfaceInfo=%@",self.interfaceInfo];
    }
    
    if (self.interfaceVersion) {
        [discription appendFormat:@"&interfaceVersion=%@",self.interfaceVersion];
    }
    
    if (self.isMobile) {
        [discription appendFormat:@"&isMobile=%@",self.isMobile];
    }
    
    if (self.payType) {
        [discription appendFormat:@"&payType=%@",self.payType];
    }
    if (self.callbackUrl) {
        [discription appendFormat:@"&callbackUrl=%@",self.callbackUrl];
    }
    
    return discription;
}

- (NSString*)sha256:(NSString *)string
{
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


+ (XZZAsiaBillPay *)setupAsiaBillOrderNum:(NSString *)orderNum price:(CGFloat)price paymentType:(XZZPaymentType *)paymentType address:(XZZAddressInfor *)address
{
    //将商品信息赋予AlixPayOrder的成员变量
    XZZAsiaBillPay *order = [[XZZAsiaBillPay alloc] init];
    order.merNo = paymentType.merchantNumber;
    order.gatewayNo = paymentType.payModel;
    order.signkey = paymentType.signKey;
    
    order.orderNo = orderNum;
    order.orderCurrency = @"USD";
    order.orderAmount = [NSString stringWithFormat:@"%.2f", price];
    order.returnUrl = paymentType.returnUrl;
    order.firstName = address.firstName;
    order.lastName = address.lastName;
    order.email = User_Infor.email;
    order.phone = address.phone;
    order.paymentMethod = @"Credit Card";
    order.country = address.countryCode;
    order.city = address.cityName;
    order.address = address.detailAddress1;
    order.zip = address.zipCode;
//    order.remark = @"233333";
//    order.interfaceInfo = @"zencard";
//    order.interfaceVersion = @"V2.1";
    order.isMobile = @"2";
    order.payType = @"0";
    return order;
}

- (NSString *)payType
{
    if (!_payType) {
        self.payType = @"0";
    }
    return _payType;
}

- (NSString *)isMobile
{
    if (!_isMobile) {
        self.isMobile = @"1";
    }
    return _isMobile;
}

- (NSString *)merWebsite
{
//    if(!_merWebsite){
    NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSLog(@"=======%@", infoDictionary);
    
//    self.merWebsite = @"com.JoLiMall.XZZ.text1";
    self.merWebsite = infoDictionary[@"CFBundleIdentifier"];
//    }
    return _merWebsite;
}

- (void)pay:(AsiaBillPay)asiaBillPay
{
    
    
    
    
//    [[AsiabillSDK defaultService] payOrder:[self description] fromScheme:@"qwerty" callback:^(NSString *resData) {
//        NSLog(@"~~~~~~~·%@", resData);
//        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[resData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
//        if ([dic[@"code"] intValue] == 9900) {
//            !asiaBillPay?:asiaBillPay(YES, dic[@"message"]);
//        }else{
//            !asiaBillPay?:asiaBillPay(NO, dic[@"message"]);
//        }
//    }];
//
//
//    
//    NSLog(@"%@", [UIApplication sharedApplication].delegate.window.subviews);
    
    
    
}

@end
