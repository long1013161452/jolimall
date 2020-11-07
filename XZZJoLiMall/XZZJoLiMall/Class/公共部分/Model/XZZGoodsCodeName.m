//
//  XZZGoodsCodeName.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/4/16.
//  Copyright © 2019 龙少. All rights reserved.
//

#import "XZZGoodsCodeName.h"




@interface XZZGoodsCodeName ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSDictionary * codeNameDic;

@end

@implementation XZZGoodsCodeName

static XZZGoodsCodeName * goodsCodeName = nil;

+ (XZZGoodsCodeName *)shareGoodsCodeName
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        
        goodsCodeName = [[XZZGoodsCodeName alloc]init];
        
    });
    return goodsCodeName;
}

- (NSDictionary *)codeNameDic
{
    if (!_codeNameDic) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"goods_code_name" ofType:@"txt"];
        NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"%@", content);
        
        NSArray *array = [self jsonStringToKeyValues:content];
        
        NSMutableDictionary * muDic = @{}.mutableCopy;
        
        for (NSDictionary * dic in array) {
            
            NSString * color_code = dic[@"color_code"];
            NSString * color_name = dic[@"color_name"];
            if (color_code.length > 0 && color_name.length > 0) {
                [muDic setValue:color_name forKey:color_code];
            }
        }
        self.codeNameDic = muDic.copy;
    }
    return _codeNameDic;
}

//json字符串转化成OC键值对
- (id)jsonStringToKeyValues:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = nil;
    if (JSONData) {
        responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    }
    
    return responseJSON;
}


- (NSString *)readNameByCode:(NSString *)code
{
    return self.codeNameDic[code];
}

@end
