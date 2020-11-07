//
//  XZZFormatValidation.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/20.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZFormatValidation.h"

@implementation XZZFormatValidation

+ (BOOL)emailFormatValidation:(NSString *)email
{
    if (email.length > 40) {
        return NO;
    }
    NSString *emailRegex = @".{1,40}@.{1,40}\\..{1,40}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)passwordFormatValidation:(NSString *)password
{
    NSString * passwordRegex = @"[A-Z0-9a-z]{6,21}";
    
    NSPredicate * passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",passwordRegex];
    
    return [passwordTest evaluateWithObject:password];
}

+ (BOOL)phoneFormatValidation:(NSString *)phone
{
    NSString * phoneRegex = @"[0-9-]{1,20}";
    
    NSPredicate * phoneText = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",phoneRegex];
    
    return [phoneText evaluateWithObject:phone];
}


+ (NSString *)stringSubstitution:(NSString *)str
{
    
    if (str.length > 2) {
        return [str stringByReplacingCharactersInRange:NSMakeRange(1, str.length - 2) withString:@"***"];
    }
    
    return str;
}

@end
