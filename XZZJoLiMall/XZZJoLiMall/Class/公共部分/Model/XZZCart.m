//
//  XZZCart.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZCart.h"



@implementation XZZCartInfor

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    return [self yy_modelInitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder*)aCoder {
    
    [self yy_modelEncodeWithCoder:aCoder];
    
}

- (NSString *)mainPicture
{
//    if (![_mainPicture hasPrefix:Image_New_prefix]) {
//        
//        NSString * imageprefixNew = [NSString stringWithFormat:@"%@270x360/", Image_New_prefix];
//        self.mainPicture = [_mainPicture stringByReplacingOccurrencesOfString:Image_prefix withString:imageprefixNew];
//        
//    }
    return _mainPicture;
}


+ (id)cartInforWithSku:(XZZSku *)sku num:(NSInteger)num
{
    XZZCartInfor * cartInfor = [XZZCartInfor allocInit];
    cartInfor.skuNum = num;
    cartInfor.skuPrice = sku.skuPrice;
    cartInfor.skuNominalPrice = sku.skuNominalPrice;
    cartInfor.goodsTitle = sku.goodsTitle;
    cartInfor.goodsId = sku.goodsId;
    cartInfor.goodsCode = sku.goodsCode;
    cartInfor.sizeCode = sku.sizeCode;
    cartInfor.sizeName = sku.sizeName;
    cartInfor.colorCode = sku.colorCode;
    cartInfor.colorName = sku.colorName;
    cartInfor.code = sku.code;
    cartInfor.mainPicture = sku.mainPicture;
    cartInfor.subPictures = sku.subPictures;
    cartInfor.ID = sku.ID;
    cartInfor.status = sku.status;
    cartInfor.stock = sku.stock;
    cartInfor.weight = sku.weight;
    cartInfor.shortSizeCode = sku.shortSizeCode;
    cartInfor.activityVo = sku.activityVo;
    cartInfor.secKillVo = sku.secKillVo;
    
    return cartInfor;
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




+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id",};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"activityVo" : [XZZActivityInfor class], @"secKillVo" : [XZZSecKillVo class]};
}

@end

