//
//  XZZDefine.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/4.
//  Copyright © 2019年 龙少. All rights reserved.
//


/**
 *  存储基本信息   例如按钮颜色等
 */
#ifndef XZZDefine_h
#define XZZDefine_h

#import "XZZBasicData.h"
/**
 *  销售价格颜色
 */
#define Selling_price_color kColor(0x191919)
/**
 *  销售价格字体
 */
#define Selling_price_font [XZZBasicData SellingPriceFont]
/**
 *  虚价字体颜色
 */
#define original_price_color kColor(0x999999)
/**
 *  虚价字体
 */
#define original_price_font textFont(12)
/**
 *  图片的宽高比例
 */
#define image_width_height_proportion (3.0 / 4.0)

/**
 *  图片的高宽比例
 */
#define image_height_width_proportion (4.0 / 3.0)
/**
 *  价格高度
 */
#define price_height 36
/**
 *  价格高度
 */
#define price_height_Two 26
/**
 *  虚价高度
 */
#define original_price_height 12

/**
 *  分割线宽度
 */
#define divider_view_width 0.5
/**
 *  收藏按钮   宽高
 */
#define collection_Button_Width 28
/**
 *  商品列表  商品间隔
 */
#define goodsList_goods_interval 8



/**
 *  分类背景
 */
#define Category_background kColor(0xf7f7f7)
/**
 *  分类主分类的颜色   选中的时候
 */
#define Category_main_selected_label_color kColor(0xF41C19)
/**
 *  分类主分类的颜色   未选中的时候
 */
#define Category_main_noSelected_label_color kColor(0x505050)
/**
 *  分类主分类字体大小
 */
#define Category_main_label_font textFont(14)
/**
 *  三分类一排展示几个
 */
#define Category_Subclass_count 3
/**
 *  二级分类的字体
 */
#define Category_Subclass_font textFont_bold(14)
/**
 *  二级分类的字体颜色
 */
#define Category_Subclass_color kColor(0x000000)
/**
 *  二级分类的all字体颜色
 */
#define Category_Subclass_all_color kColor(0x505050)

/**
 *  首页模板间隔
 */
#define home_Template_interval 8

/**
 *  分页的小点  本页的颜色
 */
#define current_Page_Dot_Color kColor(0xF41C19)
/**
 *  分页的小点  非本页的颜色
 */
#define page_Dot_Color kColor(0xC5C5C5)
/**
 *  按钮背景颜色
 */
#define button_back_color kColor(0xFF4444)


/**
 *  首页模板标题大小
 */
#define home_page_template_title_font_size textFont_bold(15)




#pragma mark ---- APP里面使用的字体
/**
 * 字号22  粗体
 */
#define font_bold_22 [XZZBasicData fontBold22]
/**
 * 字号20  粗体
 */
#define font_bold_20 [XZZBasicData fontBold20]
/**
 * 字号16  粗体
 */
#define font_bold_16 [XZZBasicData fontBold16]
/**
 * 字号16
 */
#define font_16 [XZZBasicData font16]
/**
 * 字号14  粗体
 */
#define font_bold_14 [XZZBasicData fontBold14]
/**
 * 字号14
 */
#define font_14 [XZZBasicData font14]
/**
 * 字号12
 */
#define font_12 [XZZBasicData font12]
/**
 * 字号10
 */
#define font_10 [XZZBasicData font10]

/**
 * 字号 8
 */
#define font_8 [XZZBasicData font8]

#pragma mark ---- APP里面使用的颜色
/**
 * 主色  100
 */
#define main_Color_d73e3e_100 [XZZBasicData mainColor100]
/**
 * 主色  90
 */
#define main_Color_d73e3e_90 [XZZBasicData mainColor90]
/**
 * 主色  80
 */
#define main_Color_d73e3e_80 [XZZBasicData mainColor80]
/**
 * 主色  70
 */
#define main_Color_d73e3e_70 [XZZBasicData mainColor70]
/**
 * 主色  60
 */
#define main_Color_d73e3e_60 [XZZBasicData mainColor60]
/**
 * 主色  50
 */
#define main_Color_d73e3e_50 [XZZBasicData mainColor50]
/**
 * 主色  40
 */
#define main_Color_d73e3e_40 [XZZBasicData mainColor40]
/**
 * 主色  30
 */
#define main_Color_d73e3e_30 [XZZBasicData mainColor30]
/**
 * 主色  20
 */
#define main_Color_d73e3e_20 [XZZBasicData mainColor20]
/**
 * 主色  10
 */
#define main_Color_d73e3e_10 [XZZBasicData mainColor10]

/**
 * 辅色
 */
#define complementary_Color_ff8a44 [XZZBasicData complementaryColor]
/**
 * 重要色
 */
#define important_Color_191919 [XZZBasicData importantColor]
/**
 * 一般色  666666
 */
#define general_Color_666666 [XZZBasicData generalColor666666]
/**
 * 一般色  999999
 */
#define general_Color_999999 [XZZBasicData generalColor999999]
/**
 * 一般色  cccccc
 */
#define general_Color_CCCCCC [XZZBasicData generalColorCCCCCC]
/**
 * 其他色  f8f8f8
 */
#define other_Color_F8F8F8 [XZZBasicData otherColorF8F8F8]
/**
 * 其他色  ffffff
 */
#define other_Color_FFFFFF [XZZBasicData otherColorFFFFFF]





/** 展示商品展示角标信息*/
typedef NS_ENUM (int, XZZGoodsViewDisplayAngle) {
    ///在活动列表页面展示使用  展示新的左侧角标
    XZZGoodsViewDisplayActivityGoodsList = 1,
    ///在列表页面进行展示  展示右侧新角标  跟之前的商品角标
    XZZGoodsViewDisplayGoodsList = 2,
    ///   在推荐中使用   只展示之前的商品角标
    XZZGoodsViewDisplayRecommendedGoodsList = 0
};


/** 展示商品展示角标信息*/
typedef NS_ENUM (int, XZZSecondsKillState) {
    ///进行中
    XZZSecondsKillStateOngoing = 1,
    ///未开始
    XZZSecondsKillStateNot = 2,
    ///已结束
    XZZSecondsKillStateEnd = 0
};

/** 展示商品展示角标信息*/
typedef NS_ENUM (int, XZZSecondsKillGoodsLocation) {
    ///第一个商品
    XZZSecondsKillGoodsFirst = 0,
    ///中间的商品
    XZZSecondsKillGoodsMiddle = 1,
    ///最后一个商品
    XZZSecondsKillGoodsLast = 2
};



#endif /* XZZDefine_h */









