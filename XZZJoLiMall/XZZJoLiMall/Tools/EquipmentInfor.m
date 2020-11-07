//
//  XZZEquipmentInfor.m
//  测试缓存
//
//  Created by 龙少 on 2018/12/12.
//  Copyright © 2018年 龙少. All rights reserved.
//

#import "EquipmentInfor.h"

#import "CHKeychain.h"

#import <sys/utsname.h>


@interface XZZEquipmentInfor ()

/**
 * <#expression#>
 */
@property (nonatomic, strong)CLLocationManager * locationmanager;


@end

@implementation XZZEquipmentInfor


// 返回时否是手机
+ (BOOL)deviceIsPhone{
    
    BOOL _isIdiomPhone = YES;// 默认是手机
    UIDevice *currentDevice = [UIDevice currentDevice];
    
    // 项目里只用到了手机和pad所以就判断两项
    // 设备是手机
    if (currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        
        _isIdiomPhone = YES;
    }
    // 设备室pad
    else if (currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad){
        
        _isIdiomPhone = NO;
    }
    
    return _isIdiomPhone;
}


static XZZEquipmentInfor * equipmentInfor = nil;

+ (XZZEquipmentInfor *)shareEquipmentInfor
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        equipmentInfor = [[self alloc] init] ;
//      NSLog(@"%@", [[UIDevice currentDevice] systemVersion]);
//        [equipmentInfor getLocation];
        [equipmentInfor getMyIp];
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *model = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
        equipmentInfor.equipmentModel = [equipmentInfor currentModel:model];
        equipmentInfor.systemVersion = [[UIDevice currentDevice] systemVersion];
        
    });
    return equipmentInfor;
}

- (void)getMyIp
{
    
    [XZZDataDownload userGetUserIpHttpBlock:^(id data, BOOL successful, NSError *error) {
        if (successful) {
            self.ip = data;
        }else{
//            [self getMyIp];
        }
    }];
}

- (NSString *)currentModel:(NSString *)phoneModel {
    
    if ([phoneModel isEqualToString:@"iPhone3,1"] || [phoneModel isEqualToString:@"iPhone3,2"])
        return @"iPhone 4";
    if ([phoneModel isEqualToString:@"iPhone4,1"])
        return @"iPhone 4S";
    if ([phoneModel isEqualToString:@"iPhone5,1"] || [phoneModel isEqualToString:@"iPhone5,2"])
        return @"iPhone 5";
    if ([phoneModel isEqualToString:@"iPhone5,3"] || [phoneModel isEqualToString:@"iPhone5,4"])
        return @"iPhone 5C";
    if ([phoneModel isEqualToString:@"iPhone6,1"] || [phoneModel isEqualToString:@"iPhone6,2"])
        return @"iPhone 5S";
    if ([phoneModel isEqualToString:@"iPhone7,1"])
        return @"iPhone 6 Plus";
    if ([phoneModel isEqualToString:@"iPhone7,2"])
        return @"iPhone 6";
    if ([phoneModel isEqualToString:@"iPhone8,1"])
        return @"iPhone 6s";
    if ([phoneModel isEqualToString:@"iPhone8,2"])
        return @"iPhone 6s Plus";
    if ([phoneModel isEqualToString:@"iPhone8,4"])
        return @"iPhone SE";
    if ([phoneModel isEqualToString:@"iPhone9,1"])
        return @"iPhone 7";
    if ([phoneModel isEqualToString:@"iPhone9,2"])
        return @"iPhone 7 Plus";
    if ([phoneModel isEqualToString:@"iPhone10,1"] || [phoneModel isEqualToString:@"iPhone10,4"])
        return @"iPhone 8";
    if ([phoneModel isEqualToString:@"iPhone10,2"] || [phoneModel isEqualToString:@"iPhone10,5"])
        return @"iPhone 8 Plus";
    if ([phoneModel isEqualToString:@"iPhone10,3"] || [phoneModel isEqualToString:@"iPhone10,6"])
        return @"iPhone X";
    if([phoneModel isEqualToString:@"iPhone11,2"])
        return @"iPhone XS";
    if([phoneModel isEqualToString:@"iPhone11,4"] || [phoneModel isEqualToString:@"iPhone11,6"])
        return @"iPhone XS Max";
    if([phoneModel isEqualToString:@"iPhone11,8"])
        return @"iPhone XR";
    if ([phoneModel isEqualToString:@"iPhone12,1"])
        return @"iPhone 11";
    if ([phoneModel isEqualToString:@"iPhone12,3"])
        return @"iPhone 11 Pro";
    if ([phoneModel isEqualToString:@"iPhone12,5"])
        return @"iPhone 11 Pro Max";
    
    
    
    
    if ([phoneModel isEqualToString:@"iPad1,1"])
        return @"iPad";
    if ([phoneModel isEqualToString:@"iPad2,1"] || [phoneModel isEqualToString:@"iPad2,2"] || [phoneModel isEqualToString:@"iPad2,3"] || [phoneModel isEqualToString:@"iPad2,4"])
        return @"iPad 2";
    if ([phoneModel isEqualToString:@"iPad3,1"] || [phoneModel isEqualToString:@"iPad3,2"] || [phoneModel isEqualToString:@"iPad3,3"])
        return @"iPad 3";
    if ([phoneModel isEqualToString:@"iPad3,4"] || [phoneModel isEqualToString:@"iPad3,5"] || [phoneModel isEqualToString:@"iPad3,6"])
        return @"iPad 4";
    if ([phoneModel isEqualToString:@"iPad4,1"] || [phoneModel isEqualToString:@"iPad4,2"] || [phoneModel isEqualToString:@"iPad4,3"])
        return @"iPad Air";
    if ([phoneModel isEqualToString:@"iPad5,3"] || [phoneModel isEqualToString:@"iPad5,4"])
        return @"iPad Air 2";
    if ([phoneModel isEqualToString:@"iPad6,3"] || [phoneModel isEqualToString:@"iPad6,4"])
        return @"iPad Pro 9.7-inch";
    if ([phoneModel isEqualToString:@"iPad6,7"] || [phoneModel isEqualToString:@"iPad6,8"])
        return @"iPad Pro 12.9-inch";
    if ([phoneModel isEqualToString:@"iPad6,11"] || [phoneModel isEqualToString:@"iPad6,12"])
        return @"iPad 5";
    if ([phoneModel isEqualToString:@"iPad7,1"] || [phoneModel isEqualToString:@"iPad7,2"])
        return @"iPad Pro 12.9-inch 2";
    if ([phoneModel isEqualToString:@"iPad7,3"] || [phoneModel isEqualToString:@"iPad7,4"])
        return @"iPad Pro 10.5-inch";
    
    if ([phoneModel isEqualToString:@"iPad2,5"] || [phoneModel isEqualToString:@"iPad2,6"] || [phoneModel isEqualToString:@"iPad2,7"])
        return @"iPad mini";
    if ([phoneModel isEqualToString:@"iPad4,4"] || [phoneModel isEqualToString:@"iPad4,5"] || [phoneModel isEqualToString:@"iPad4,6"])
        return @"iPad mini 2";
    if ([phoneModel isEqualToString:@"iPad4,7"] || [phoneModel isEqualToString:@"iPad4,8"] || [phoneModel isEqualToString:@"iPad4,9"])
        return @"iPad mini 3";
    if ([phoneModel isEqualToString:@"iPad5,1"] || [phoneModel isEqualToString:@"iPad5,2"])
        return @"iPad mini 4";
    
    if ([phoneModel isEqualToString:@"iPod1,1"])
        return @"iTouch";
    if ([phoneModel isEqualToString:@"iPod2,1"])
        return @"iTouch2";
    if ([phoneModel isEqualToString:@"iPod3,1"])
        return @"iTouch3";
    if ([phoneModel isEqualToString:@"iPod4,1"])
        return @"iTouch4";
    if ([phoneModel isEqualToString:@"iPod5,1"])
        return @"iTouch5";
    if ([phoneModel isEqualToString:@"iPod7,1"])
        return @"iTouch6";
    
    if ([phoneModel isEqualToString:@"i386"] || [phoneModel isEqualToString:@"x86_64"])
        return @"iPhone Simulator";
    
    return @"ios_unknown";
}

#pragma mark ---- 开启定位信息
-(void)getLocation
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationmanager = [[CLLocationManager alloc]init];
        self.locationmanager.delegate = self;
        [self.locationmanager requestAlwaysAuthorization];
        self.currentCity = [NSString new];
        [self.locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationmanager.distanceFilter = 5000.0;
        [self.locationmanager startUpdatingLocation];
    }
}

#pragma mark --- CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    
    
}

#pragma mark --- 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self.locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    self.strlatitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    self.strlongitude = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    
    //反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self.currentCity = placeMark.locality;
            if (!self.currentCity) {
                self.currentCity = @"无法定位当前城市";
            }
            
            /*看需求定义一个全局变量来接收赋值*/
            NSLog(@"----%@",placeMark.country);//当前国家
            NSLog(@"%@",placeMark.locality);//当前的城市
            NSLog(@"%@",placeMark.subLocality);//当前的位置
            NSLog(@"%@",placeMark.thoroughfare);//当前街道
            NSLog(@"%@",placeMark.name);//具体地址
            self.currentCountries = placeMark.country;
            self.currentProvince = placeMark.administrativeArea;
            self.currentCity = placeMark.locality;
            self.currentArea = placeMark.subLocality;

            self.currentAddressInfor = [NSString stringWithFormat:@"%@%@%@%@%@", placeMark.country.length ? placeMark.country : @"", placeMark.administrativeArea.length ? placeMark.administrativeArea : @"", placeMark.locality.length ? placeMark.locality : @"", placeMark.subLocality.length ? placeMark.subLocality : @"", placeMark.name.length ? placeMark.name : @""];
            
            NSLog(@"-------%@", self.currentAddressInfor);
            
            NSLog(@"1-%@", placeMark.name);// 详细位置
            NSLog(@"2-%@", placeMark.thoroughfare);// 详细位置
            NSLog(@"3-%@", placeMark.subThoroughfare);// 详细位置
            NSLog(@"4-%@", placeMark.locality);// 详细位置
            NSLog(@"5-%@", placeMark.subLocality);// 详细位置
            NSLog(@"6-%@", placeMark.administrativeArea);// 详细位置
            NSLog(@"7-%@", placeMark.subAdministrativeArea);// 详细位置
            NSLog(@"8-%@", placeMark.postalCode);// 详细位置
            NSLog(@"9-%@", placeMark.ISOcountryCode);// 详细位置
            NSLog(@"10-%@", placeMark.country);// 详细位置
            NSLog(@"11-%@", placeMark.inlandWater);// 详细位置
            NSLog(@"12-%@", placeMark.ocean);// 详细位置
            NSLog(@"13-%@", placeMark.areasOfInterest);// 详细位置
            

            

            
        }
        [manager stopUpdatingLocation];
    }];
    
}

#pragma mark ----*  处理属性为空
/**
 *  处理属性为空
 */
- (NSString *)uuid
{
    if (!_uuid) {
        NSString * uuid = [CHKeychain load:@"JoLiMall-uuid" class:[NSString class]];
        if (!uuid) {
            uuid = [[NSUUID UUID] UUIDString];
            [CHKeychain save:@"JoLiMall-uuid" data:uuid];
        }
        self.uuid = uuid;
    }
    
    return _uuid;
}

- (NSString *)equipmentModel
{
    if (!_equipmentModel) {
        return @"";
    }
    return _equipmentModel;
}

- (NSString *)systemVersion
{
    if (!_systemVersion) {
        return @"";
    }
    return _systemVersion;
}

- (NSString *)currentAddressInfor
{
    if (!_currentAddressInfor) {
        return @"";
    }
    return _currentAddressInfor;
}

- (NSString *)strlongitude
{
    if (!_strlongitude) {
        return @"0";
    }
    return _strlongitude;
}

- (NSString *)strlatitude
{
    if (!_strlatitude) {
        return @"0";
    }
    return _strlatitude;
}

- (NSString *)currentCity
{
    if (!_currentCity) {
        return @"";
    }
    return _currentCity;
}

- (NSString *)currentProvince
{
    if (!_currentProvince) {
        return @"";
    }
    return _currentProvince;
}

- (NSString *)currentArea
{
    if (!_currentArea) {
        return @"";
    }
    return _currentArea;
}

- (NSString *)currentCountries
{
    if (!_currentCountries) {
        return @"";
    }
    return _currentCountries;
}

- (NSString *)ip
{
    if (!_ip.length) {
        return @"";
    }
    return _ip;
}




- (NSString *)app_Version
{
    if (!_app_Version) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // 当前应用名称
        // 当前应用软件版本  比如：1.0.1
        _app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }
    return _app_Version;

}

- (NSString *)AppName
{
    if (!_AppName) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        self.AppName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        if (!_AppName.length <= 0) {
            return @"Jolimall";
        }
    }
    return _AppName;
}

@end
