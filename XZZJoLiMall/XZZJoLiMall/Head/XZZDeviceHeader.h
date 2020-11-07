//
//  XZZDeviceHeader.h
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/4.
//  Copyright © 2019年 龙少. All rights reserved.
//



/**
 *  一些配置信息
 */
#ifndef XZZDeviceHeader_h
#define XZZDeviceHeader_h




//分割线颜色
#define DIVIDER_COLOR kColor(0xe8e8e8)
//背景色
#define BACK_COLOR kColor(0xf8f8f8)


//block中的弱引用和强引用
#define WS(wSelf)          __weak typeof(self) wSelf = self;
#define weakView(WV, view)          __weak typeof(view) WV = view;
#define weakObjc(WJ, objc)          __weak typeof(objc) WJ = objc;
#define SS(sSelf)          __strong typeof(wSelf) sSelf = wSelf;
/**
 *  打开次数
 */
#define open_number_times ((AppDelegate *)([UIApplication sharedApplication].delegate)).openNumber

///**
// *  当前时间
// */
//#define current_Time ((AppDelegate *)([UIApplication sharedApplication].delegate)).currentTime

/**
 *  下方安全高度
 */
#define bottomHeight 34
/**
 *  状态栏高度
 */
#define StatusRect [[UIApplication sharedApplication] statusBarFrame]
//获取屏幕的bounds
#define ScreenSize [[UIScreen mainScreen] bounds]
//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备物理宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width


///-----------字体font------------------------------------------------------
#define textFont(font)  [UIFont systemFontOfSize:font]
///-----------字体font   加粗-----------------------------
#define textFont_bold(font) [UIFont boldSystemFontOfSize:font]
//// 图片
#define imageName(name) [UIImage imageNamed:name]

//字符串和数字的判空处理
#define isEmpytLabelOrField(str) str==nil?@"":[str isEqual:[NSNull null]]?@"":str //@"null"
#define isEmpytNumberStr(str) str==nil?@"0":[str isEqual:[NSNull null]]?@"0":str


#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\n%s文件中第%d行-->打印信息==>: %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif



// 机型
#define kDevice_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


/**
 *  创建UIColor对象  使用的是0xffffff这样的颜色格式   用法：kColor(0xaaaaaa)
 *  @param rgbValue 颜色值
 *  @return 返回UIColor对象
 */
#define kColor(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0x0000FF)) / 255.0 alpha:1.0]
//! 参数格式为：222,222,222
/**
 *  创建UIColor对象   三基色方式   用法：kColorWithRGB(100,100,100,1)
 *
 *  @param r 红色(0~255)
 *  @param g 绿色(0~255)
 *  @param b 蓝色(0~255)
 *  @param a 透明度(0~1)
 *
 *  @return 返回创建好的UIColor对象
 */
#define kColorWithRGB(r, g, b, a) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:a]
/**
 *  创建UIColor对象  使用的是#ffffff或0xffffff 0Xffffff 这样的字符串颜色格式   用法：kColor(@”0xaaaaaa“)
 *  @param rgbValue 颜色值
 *  @return 返回UIColor对象
 */
#define kColorStr(rgbValue) [UIColor colorFromHexCode:rgbValue]

/**
 * 随机色
 */
#define suiji_Color kColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1)



#endif /* XZZDeviceHeader_h */
