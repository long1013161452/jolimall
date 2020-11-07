//
//  XZZCategory.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/6.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  分类信息
 */
@interface XZZCategory : NSObject

/**
 *  商品类别英文名 ,
 */
@property (nonatomic, strong)NSString * name;// (string, optional):
/**
 *  ID ,
 */
@property (nonatomic, strong)NSString * ID;// (integer, optional):
/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray<XZZCategory *> * children;// (Array[TreeCate], optional),
/**
 * sizeType 等尺码类型 1.衣服 2.鞋子 3。童装
 */
@property (nonatomic, assign)int sizeType;
/**
 * 图片地址
 */
@property (nonatomic, strong)NSString * picture;

@end


