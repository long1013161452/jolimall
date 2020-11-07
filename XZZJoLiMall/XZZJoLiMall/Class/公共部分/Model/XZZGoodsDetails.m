//
//  XZZGoodsDetails.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/3/21.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZGoodsDetails.h"

@implementation XZZGoodsDetails


/**
 *  属性所对应的对象
 */
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"goods" : [XZZGoods class], @"skuList" : [XZZSku class], @"categoryMap" : [XZZCategoryMap class], @"couponList" : [XZZCouponsInfor class], @"activityVo" : [XZZActivityInfor class], @"secKillVo" : [XZZSecKillVo class]};
}

- (NSArray<XZZColor *> *)colorInforArray
{
    if (!_colorInforArray) {
        NSMutableDictionary * dic = @{}.mutableCopy;
        NSMutableArray * array = @[].mutableCopy;
        
        for (XZZSku * sku in self.skuList) {
            if (!dic[sku.colorCode]) {
                XZZColor * color = [XZZColor allocInitFrame:sku];
                [dic setObject:color forKey:color.colorCode];
                [array addObject:color];
            }
        }
        self.colorInforArray = array.copy;
    }
    return _colorInforArray;
}

- (NSArray<XZZSize *> *)sizeInforArray
{
    if (!_sizeInforArray) {
        NSMutableDictionary * dic = @{}.mutableCopy;
        NSMutableArray * array = @[].mutableCopy;
        
        for (XZZSku * sku in self.skuList) {
            if (!dic[sku.sizeCode]) {
                XZZSize * size = [XZZSize allocInitFrame:sku];
                [dic setObject:size forKey:size.sizeCode];
                [array addObject:size];
            }
        }
        self.sizeInforArray = array.copy;
    }
    return _sizeInforArray;
}

- (NSMutableDictionary *)colorCodeDictionary
{
    if (!_colorCodeDictionary) {
        NSMutableDictionary * dic = @{}.mutableCopy;
        for (XZZColor * color in self.colorInforArray) {
            NSMutableDictionary * colorCodeDic = @{}.mutableCopy;
            [dic setObject:colorCodeDic forKey:color.colorCode];
            for (XZZSku * sku in self.skuList) {
                if ([sku.colorCode isEqualToString:color.colorCode] && sku.status == 1) {
                    [colorCodeDic setObject:@"" forKey:sku.sizeCode];
                }
            }
        }
        self.colorCodeDictionary = dic;
    }
    return _colorCodeDictionary;
}


- (NSMutableDictionary *)sizeCodeDictionary
{
    if (!_sizeCodeDictionary) {
        NSMutableDictionary * dic = @{}.mutableCopy;
        for (XZZSize * size in self.sizeInforArray) {
            NSMutableDictionary * colorCodeDic = @{}.mutableCopy;
            [dic setObject:colorCodeDic forKey:size.sizeCode];
            for (XZZSku * sku in self.skuList) {
                if ([sku.sizeCode isEqualToString:size.sizeCode] && sku.status == 1) {
                    [colorCodeDic setObject:@"" forKey:sku.colorCode];
                }
            }
        }
        self.sizeCodeDictionary = dic;
    }
    return _sizeCodeDictionary;
}

- (NSArray *)picArray
{
    if (!_picArray) {
        NSMutableArray * array = @[].mutableCopy;
        
        if (self.goods.pictureUrl.length) {
            [array addObject:self.goods.pictureUrl];
        }
        [array addObjectsFromArray:self.goods.subPicturesList];
        
        for (XZZColor * color in self.colorInforArray) {
            [array addObjectsFromArray:color.picturesArray];
        }
        self.picArray = array.copy;
    }
    return _picArray;
}

- (XZZSku *)accordingColor:(XZZColor *)color size:(XZZSize *)size
{
    for (XZZSku * sku in self.skuList) {
        if ([sku.colorCode isEqualToString:color.colorCode] && [sku.sizeCode isEqualToString:size.sizeCode]) {
            return sku;
        }
    }
    return nil;
}

@end

@implementation XZZGoods

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id", @"descriptionJsonStr" : @"description"};
}

- (NSString *)descriptionStr
{
    if (!_descriptionStr) {
        NSString * str = @"";
        for (XZZGoodsDescribe * goodsDescribe in self.descriptionJson) {
            str = [NSString stringWithFormat:@"%@%@%@:%@", str, str.length ? @"\n" : @"", goodsDescribe.title, goodsDescribe.desc];
        }
        self.descriptionStr = str;
    }
    return _descriptionStr;
}

- (NSArray<XZZGoodsDescribe *> *)descriptionJson
{
    if (!_descriptionJson.count) {
        NSArray * array = [NSArray yy_modelArrayWithClass:[XZZGoodsDescribe class] json:self.descriptionJsonStr];
        self.descriptionJson = array;
    }
    return _descriptionJson;
}

- (NSString *)pictureUrl
{
//    if (![_pictureUrl hasPrefix:Image_New_prefix]) {//判断是否是直接返回的前缀开头  Image_prefix 是
//
//
//        {
//            NSString * imageprefixNew = [NSString stringWithFormat:@"%@120x160/", Image_New_prefix];//  字符串拼接 Image_New_prefix 是新的前缀，不包含大小   ScreenWidth屏幕宽度   拼出来https://n2n05n6wq1.execute-api.cn-northwest-1.amazonaws.com.cn/dev/fit-in/600x800/   这种格式的
//            self.smallPictureUrl = [_pictureUrl stringByReplacingOccurrencesOfString:Image_prefix withString:imageprefixNew];//字符串替换，把Image_prefix替换成imageprefixNew
//        }
//
//        NSString * imageprefixNew = [NSString stringWithFormat:@"%@%.0fx%.0f/", Image_New_prefix, (ScreenWidth * 3), (ScreenWidth * 4)];//  字符串拼接 Image_New_prefix 是新的前缀，不包含大小   ScreenWidth屏幕宽度   拼出来https://n2n05n6wq1.execute-api.cn-northwest-1.amazonaws.com.cn/dev/fit-in/600x800/   这种格式的
//        self.pictureUrl = [_pictureUrl stringByReplacingOccurrencesOfString:Image_prefix withString:imageprefixNew];//字符串替换，把Image_prefix替换成imageprefixNew
//
//    }
    return _pictureUrl;
}



/**
 *  属性所对应的对象
 */
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"descriptionJson" : [XZZGoodsDescribe class], @"subPicturesList" : [NSString class], @"associatedGoods" : [NSNumber class]};
}


@end


@implementation XZZSku

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id",};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"activityVo" : [XZZActivityInfor class], @"secKillVo" : [XZZSecKillVo class]};
}

- (NSInteger)status
{
    if (_status == 1 && (!self.stock || self.stock.integerValue > 0)) {
        self.status = 1;
    }else{
        self.status = 0;
    }
    return _status;
}


- (NSArray *)picturesArray
{
    if (!_picturesArray) {
        NSMutableArray * array = @[].mutableCopy;
        
        if (self.mainPicture.length) {
            [array addObject:self.mainPicture];
        }
        
        self.subPictures = [self.subPictures stringByReplacingOccurrencesOfString:@"；"withString:@";"];

        NSArray * urlArray = [self.subPictures componentsSeparatedByString:@";"];
        
        for (NSString * str in urlArray) {
            if (str.length) {
                [array addObject:[self workingString:str]];
            }
        }
        
        _picturesArray = array.copy;
    }
    return _picturesArray;
}

- (NSString *)workingString:(NSString *)string
{
    return [string stringByReplacingOccurrencesOfString:@"\r\n"withString:@""];
    
}


@end

@implementation XZZColor

+ (instancetype)allocInitFrame:(XZZSku *)sku
{
    XZZColor * color = [self allocInit];
    color.colorCode = sku.colorCode;
    color.colorName = sku.colorName;
    color.mainPicture = sku.mainPicture;
    color.picturesArray = sku.picturesArray;
    return color;
}

- (NSString *)smallMainPicture
{
    if (!_smallMainPicture) {
        
        self.smallMainPicture = self.mainPicture;
//        if (![_smallMainPicture hasPrefix:Image_New_prefix]) {
//
//            NSString * imageprefixNew = [NSString stringWithFormat:@"%@90x120/", Image_New_prefix];
//            self.smallMainPicture = [_smallMainPicture stringByReplacingOccurrencesOfString:Image_prefix withString:imageprefixNew];
//
//        }
    }
    return _smallMainPicture;
}


- (NSString *)mainPicture
{
//    if (![_mainPicture hasPrefix:Image_New_prefix]) {
//
//        NSString * imageprefixNew = [NSString stringWithFormat:@"%@%.0fx%.0f/", Image_New_prefix, ScreenWidth * 3, ScreenWidth * 4];
//        self.mainPicture = [_mainPicture stringByReplacingOccurrencesOfString:Image_prefix withString:imageprefixNew];
//    }
    return _mainPicture;
}

- (NSArray *)picturesArray
{
//    NSString * imageUrl = [_picturesArray firstObject];
//    if (![imageUrl hasPrefix:Image_New_prefix]) {
//        NSMutableArray * array = @[].mutableCopy;
//        NSString * imageprefixNew = [NSString stringWithFormat:@"%@%.0fx%.0f/", Image_New_prefix, ScreenWidth * 3, ScreenWidth * 4];
//        for (NSString * url in _picturesArray) {
//            NSString * urlTwo = [url stringByReplacingOccurrencesOfString:Image_prefix withString:imageprefixNew];
//            [array addObject:urlTwo];
//        }
//        self.picturesArray = array.copy;
//    }
    
    return _picturesArray;
}


@end


@implementation XZZSize

+ (instancetype)allocInitFrame:(XZZSku *)sku
{
    XZZSize * size = [self allocInit];
    size.sizeCode = sku.sizeCode;
    size.sizeName = sku.sizeName;
    size.shortSizeCode = sku.shortSizeCode;
    return size;
}

@end

@implementation XZZCategoryMap



@end


@implementation XZZGoodsDescribe



@end

@implementation XZZSecKillVo



@end
