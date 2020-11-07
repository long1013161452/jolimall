//
//  XZZFilterModel.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/26.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZFilterModel.h"

@implementation XZZFilterModel

static XZZFilterModel * filterModel;

+ (XZZFilterModel *)shareFilterModel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        filterModel  = [self allocInit];
    });
    return filterModel;
}


- (NSArray<XZZFilterColor *> *)colorArray
{
    if (!_colorArray) {
        NSArray * colors = @[
                             [UIColor blackColor],
                             [UIColor whiteColor],
                             kColor(0x9b9b9b),//灰色
                             kColor(0x8b572a),//棕色
                             kColor(0x6f0000),//酒红色
                             kColor(0x3e4d0f),//军绿色
                             kColor(0xff9898),//粉色
                             kColor(0x0072ca),//蓝色
                             kColor(0xffcb3c)//黄色
                             ];
        NSArray * codes = @[@"HS", @"BS", @"GR", @"BR", @"JH", @"JL", @"FS", @"BL", @"YL"];
        NSMutableArray * colorArray = @[].mutableCopy;
        for (int i = 0; i < colors.count; i++) {
            [colorArray addObject:[XZZFilterColor allocInitFrameColor:colors[i] code:codes[i]]];
        }
        self.colorArray = colorArray.copy;
    }
    return _colorArray;
}

- (NSArray<XZZFilterSize *> *)clothesSizeArray
{
    if (!_clothesSizeArray) {
        NSArray * sizes = @[@"XS", @"S", @"M", @"L", @"XL", @"XXL", @"XXXL", @"XXXXL"];
        NSArray * ids = @[@"2", @"1", @"5", @"6", @"7", @"8", @"9", @"10"];
        
        NSMutableArray * sizeArray = [NSMutableArray array];
        for (int i = 0; i < sizes.count; i++) {
//            [sizeArray addObject:[XZZFilterSize allocInitFrameSize:sizes[i] ID:ids[i]]];
        }
        self.clothesSizeArray = sizeArray.copy;
        
    }
    return _clothesSizeArray;
}

- (NSArray<XZZFilterSize *> *)shoerSizeArray
{
    if (!_shoerSizeArray) {
        NSArray * sizes = @[@"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
        NSArray * ids = @[@"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19"];
        NSMutableArray * sizeArray = [NSMutableArray array];
        for (int i = 0; i < sizes.count; i++) {
//            [sizeArray addObject:[XZZFilterSize allocInitFrameSize:sizes[i] ID:ids[i]]];
        }
        self.shoerSizeArray = sizeArray.copy;
        
    }
    return _shoerSizeArray;
}

- (NSArray<XZZFilterSize *> *)childrenClothesSizeArray
{
    if (!_childrenClothesSizeArray) {
        NSArray * sizes = @[@"60CM", @"70CM", @"80CM", @"90CM", @"100CM", @"110CM", @"120CM", @"130CM", @"140CM"];
        NSArray * ids = @[@"40", @"41", @"42", @"43", @"39", @"34", @"35", @"36", @"37"];
        NSMutableArray * sizeArray = [NSMutableArray array];
        for (int i = 0; i < sizes.count; i++) {
//            [sizeArray addObject:[XZZFilterSize allocInitFrameSize:sizes[i] ID:ids[i]]];
        }
        self.childrenClothesSizeArray = sizeArray.copy;
    }
    return _childrenClothesSizeArray;
}

@end

@implementation XZZFilterSize

//+ (instancetype)allocInitFrameSize:(NSString *)size ID:(NSString *)ID
//{
//    XZZFilterSize * filterSize = [XZZFilterSize allocInit];
//    filterSize.size = size;
//    filterSize.ID = ID;
//    return filterSize;
//}

@end

@implementation XZZFilterColor

+ (instancetype)allocInitFrameColor:(UIColor *)color code:(NSString *)code
{
    XZZFilterColor * filterColor = [self allocInit];
    filterColor.color = color;
    filterColor.colorCode = code;
    return filterColor;
}

@end
