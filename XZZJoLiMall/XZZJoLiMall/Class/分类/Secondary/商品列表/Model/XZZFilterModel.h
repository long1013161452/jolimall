//
//  XZZFilterModel.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XZZFilterSize, XZZFilterColor;

@interface XZZFilterModel : NSObject


+ (XZZFilterModel *)shareFilterModel;

/**
 * 颜色
 */
@property (nonatomic, strong)NSArray<XZZFilterColor *> * colorArray;

/**
 * 衣服尺寸
 */
@property (nonatomic, strong)NSArray<XZZFilterSize *> * clothesSizeArray;

/**
 * 鞋子尺寸
 */
@property (nonatomic, strong)NSArray<XZZFilterSize *> * shoerSizeArray;

/**
 * 童装尺寸
 */
@property (nonatomic, strong)NSArray<XZZFilterSize *> * childrenClothesSizeArray;


@end


@interface XZZFilterSize : NSObject

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * sizeCodeList;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * shortSizeCodeList;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * typeId;
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSString * typeName;

@end


@interface XZZFilterColor : NSObject


+ (instancetype)allocInitFrameColor:(UIColor *)color code:(NSString *)code;
/**
 * 颜色
 */
@property (nonatomic, strong)UIColor * color;

/**
 * id
 */
@property (nonatomic, strong)NSString * colorCode;

@end




NS_ASSUME_NONNULL_END
