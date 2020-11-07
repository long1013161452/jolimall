//
//  DelegateHeader.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/7.
//  Copyright © 2019年 龙少. All rights reserved.
//

#ifndef DelegateHeader_h
#define DelegateHeader_h



#endif /* DelegateHeader_h */


#import <ZDCChatAPI/ZDCChatAPI.h>

/**
 * 返回回调    data 返回的数据信息  successful 成功失败     error 错误信息
 * successful 标识接口调用是否成功   跟错误信息无关   接口走通但是无返回数据或者返回数据为空
 * 如：调用获取购物车接口  successful 为no的时候是购物车内没有商品信息  yes是有商品
 */
typedef void(^HttpBlock)(id data, BOOL successful, NSError * error);
/**
 * 返回回调    data 返回的数据信息  code 状态码 successful 成功失败     error 错误信息
 * successful 标识接口调用是否成功   跟错误信息无关   接口走通但是无返回数据或者返回数据为空
 * 如：调用获取购物车接口  successful 为no的时候是购物车内没有商品信息  yes是有商品
 */
typedef void(^HttpCodeBlock)(id data, int code, BOOL successful, NSError * error);
/**
 *  通用的block
 */
typedef void (^GeneralBlock)(void);

typedef void(^SelectSession)(NSInteger index);


@class XZZCategory, XZZHomeTemplate, XZZAddressInfor, XZZCartInfor, XZZChatTableViewCell, XZZSku, XZZOrderSku;
/**
 *  所有的代理方法
 */
@protocol XZZMyDelegate<NSObject>

@optional
/**
 *  对商品进行收藏
 */
- (void)collectGoodsAccordingId:(NSString *)goodsId;
/**
 *  点击商品购物车  根据商品id
 */
- (void)goodsViewShopCartAccordingId:(NSString *)goodsId state:(BOOL)state;
/**
 *  点击商品    进入商品详情使用   State为商品状态  yes为上架  no为下架
 */
- (void)clickOnGoodsAccordingId:(NSString *)goodsId state:(BOOL)state;
/**
 *  点击分享
 */
- (void)clickOnGoodsShare;
/**
 *  分享的时候回调  type 1 fb  2 fbm  3 whapp  4 pin
 */
- (void)clickOnGoodsShareType:(NSInteger)type;
/**
 *  查看尺码介绍
 */
- (void)selectColorSizeView;

/**
 *  点击首页模板
 */
- (void)clickOnHomepageTemplate:(XZZHomeTemplate *)homeTemplate;
/**
 *  首页模板   下一排按钮
 */
- (void)clickOnHomepageTemplate:(XZZHomeTemplate *)homeTemplate selectedIndex:(NSInteger)selectedIndex;
/**
 *   搜索 存储搜索内容
 */
- (void)searchStoreSearchContent:(NSString *)content;

/**
 *  加入购物车  根据id  数量
 */
- (void)addToCartAccordingSku:(XZZSku *)sku num:(int)num;
/**
 *  立即购买  根据id  数量
 */
- (void)buyNowAccordingSku:(XZZSku *)sku num:(int)num;
/**
 *  选中主分类  category 分类信息  source 来源视图或者控制器
 */
- (void)selectiveClassificationInfor:(XZZCategory *)category source:(id)source;
/**
 *  添加地址或者修改地址成功回调
 */
- (void)addOrEditorAddressInforSuccessfully:(XZZAddressInfor *)address newAddressInfor:(XZZAddressInfor *)newAddress;
/**
 *  删除地址信息
 */
- (void)deleteAddressInfor:(XZZAddressInfor *)address;
/**
 *  编辑地址信息
 */
- (void)editorAddressInfor:(XZZAddressInfor *)address ;
/**
 *  设置地址为默认
 */
- (void)setAddressDefault:(XZZAddressInfor *)address;

/**
 *  进入订单详情
 */
- (void)enterOrderDetails:(NSString *)orderId;
/**
 *  删除购物车
 */
- (void)deleteCartInfor:(XZZCartInfor *)cartInfor;
/**
 *  选中购物车
 */
- (BOOL)SelectCartInfor:(XZZCartInfor *)cartInfor;
/**
 *  编辑购物车信息
 */
- (void)editCartInfor:(XZZCartInfor *)cartInfor count:(BOOL)count;
/**
 *  对商品进行评论
 */
- (void)productReviewOrderSku:(XZZOrderSku *)orderSku;

/**
 *  刷新cell
 */
- (void)refreshTableViewCell:(id)cell;
/**
 *  对聊天进行评价
 */
- (void)commentOnChatRating:(ZDCChatRating)rating;
/**
 *  进入网页
 */
- (void)enterPageWebViewUrl:(id)url title:(NSString *)title;
/**
 *  查看大图
 */
- (void)viewLargerVersionImage:(id)image;
/**
 *  查看大图
 */
- (void)viewLargerVersionImages:(NSArray *)imageArray imageView:(UIImageView *)imageView index:(int)index;
/**
 *  进入首页
 */
- (void)enterHomePage;

/**
 *  打开web页面
 */
- (void)openWebPageUrl:(id)url;

@end

