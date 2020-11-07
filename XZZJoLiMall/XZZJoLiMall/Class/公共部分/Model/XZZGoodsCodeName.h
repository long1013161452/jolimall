//
//  XZZGoodsCodeName.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/16.
//  Copyright © 2019 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define GoodsCodeName(name) [[XZZGoodsCodeName shareGoodsCodeName] readNameByCode:name]


@interface XZZGoodsCodeName : NSObject


+ (XZZGoodsCodeName *)shareGoodsCodeName;


//- (NSString *)readNameByCode:(NSString *)code;


@end

NS_ASSUME_NONNULL_END
