//
//  XZZFormatValidation.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/20.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




#define email_Format(email) [XZZFormatValidation emailFormatValidation:email]

#define password_Format(password) [XZZFormatValidation passwordFormatValidation:password]

#define phone_Format(phone) [XZZFormatValidation phoneFormatValidation:phone]

#define string_Substitution(str) [XZZFormatValidation stringSubstitution:str]





@interface XZZFormatValidation : NSObject

/**
 * 验证邮箱格式
 */
+ (BOOL)emailFormatValidation:(NSString *)email;

/**
 * 验证密码
 */
+ (BOOL)passwordFormatValidation:(NSString *)password;

/**
 * 验证电话   暂时没有确定格式信息
 */
+ (BOOL)phoneFormatValidation:(NSString *)phone;

/**
 * 字符串替换    只留下首尾   其余为星号
 */
+ (NSString *)stringSubstitution:(NSString *)str;



@end

NS_ASSUME_NONNULL_END
