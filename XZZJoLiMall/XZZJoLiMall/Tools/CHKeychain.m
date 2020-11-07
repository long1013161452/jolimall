//
//  CHKeychain.m
//  测试缓存
//
//  Created by 龙少 on 2018/12/11.
//  Copyright © 2018年 龙少. All rights reserved.
//

#import "CHKeychain.h"

@implementation CHKeychain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 (id)kSecClassGenericPassword,(id)kSecClass,
                                 service, (id)kSecAttrService,
                                 service, (id)kSecAttrAccount,
                                 (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
                                 nil];
    
    return dic;
}

+ (void)save:(NSString *)service data:(id)data
{
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
//    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    if (@available(iOS 11.0, *)) {
        [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data requiringSecureCoding:YES error:nil] forKey:(id)kSecValueData];
    } else {
        // Fallback on earlier versions
           [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    }
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}
+ (id)load:(NSString *)service class:(Class)Myclass
{
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
//
            if (@available(iOS 11.0, *)) {
                ret = [NSKeyedUnarchiver unarchivedObjectOfClass:Myclass fromData:(__bridge NSData * _Nonnull)(keyData) error:nil];
            } else {
                // Fallback on earlier versions
                 ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
            }
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}
+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

@end
