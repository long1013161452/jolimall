//
//  XZZSelectGeographicInforViewController.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/2/22.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZSelectGeographicInforViewController.h"
#import "XZZCountryInfor.h"

@interface XZZSelectGeographicInforViewController ()<UITableViewDataSource, UITableViewDelegate>

/**
 * <#expression#>
 */
@property (nonatomic, strong)UITableView * tableView;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSArray * titleArray;

/**
 * <#expression#>
 */
@property (nonatomic, strong)NSDictionary * dataDic;

@end

@implementation XZZSelectGeographicInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    WS(wSelf)
    self.tableView = [UITableView allocInit];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.sectionIndexColor = [UIColor blackColor];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf.view);
    }];
}

- (void)setInforArray:(NSArray *)inforArray
{
    id infor = [inforArray firstObject];
    NSMutableDictionary * dic = @{}.mutableCopy;
    NSMutableArray * array = @[].mutableCopy;
    
    if ([infor isKindOfClass:[XZZCountryInfor class]]) {
        [array addObject:@"❉"];
        self.nameVC = @"选择国家";
        NSMutableArray * coutriesInforArray = @[].mutableCopy;
        [dic setObject:coutriesInforArray forKey:@"❉"];
        for (int i = 0; i < 4; i++) {
            [coutriesInforArray addObject:inforArray[i]];
        }
    }
    
    inforArray = [inforArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString * nicenameOne = @"";
        NSString * nicenameTwo = @"";
        if ([obj1 isKindOfClass:[XZZCountryInfor class]]) {
            nicenameOne = ((XZZCountryInfor *)obj1).countryEnName;
            nicenameTwo = ((XZZCountryInfor *)obj2).countryEnName;
        }else if ([obj1 isKindOfClass:[XZZProvinceInfor class]]){
            nicenameOne = ((XZZProvinceInfor *)obj1).provinceName;
            nicenameTwo = ((XZZProvinceInfor *)obj2).provinceName;
        }else if ([obj1 isKindOfClass:[XZZCityInfor class]]){
            nicenameOne = ((XZZCityInfor *)obj1).cityName;
            nicenameTwo = ((XZZCityInfor *)obj2).cityName;
        }
        return [nicenameOne compare:nicenameTwo]; //升序
    }];

    if ([infor isKindOfClass:[XZZProvinceInfor class]]) {
        self.myTitle = @"State/Province/Region";
        self.nameVC = @"选择省/州";
        for (XZZProvinceInfor * provinceInfor in inforArray) {
            NSString * str = [self firstCharactorWithString:provinceInfor.provinceName];
            NSMutableArray * provinceSourceArrayTwo = dic[str];
            if (!provinceSourceArrayTwo) {
                [array addObject:str];
                provinceSourceArrayTwo = @[].mutableCopy;
                [dic setObject:provinceSourceArrayTwo forKey:str];
            }
            [provinceSourceArrayTwo addObject:provinceInfor];
        }
    }
    if ([infor isKindOfClass:[XZZCityInfor class]]) {
        self.navigationItem.title = @"City";
        self.nameVC = @"选择城市";
        for (XZZCityInfor * cityInfor in inforArray) {
            NSString * str = [self firstCharactorWithString:cityInfor.cityName];
            NSMutableArray * citySourceArray = dic[str];
            if (!citySourceArray) {
                [array addObject:str];
                citySourceArray = @[].mutableCopy;
                [dic setObject:citySourceArray forKey:str];
            }
            [citySourceArray addObject:cityInfor];
        }
    }
    if ([infor isKindOfClass:[XZZCountryInfor class]]) {
        self.navigationItem.title = @"Country/Region";

        for (XZZCountryInfor * countiesInfor in inforArray) {
            NSString * str = [self firstCharactorWithString:countiesInfor.countryEnName];
            NSMutableArray * countiesInforArrayTwo = dic[str];
            if (!countiesInforArrayTwo) {
                [array addObject:str];
                countiesInforArrayTwo = @[].mutableCopy;
                [dic setObject:countiesInforArrayTwo forKey:str];
            }
            [countiesInforArrayTwo addObject:countiesInfor];
        }
    }
    
    self.dataDic = dic;
    self.titleArray = array;
    
    
}

//获取某个字符串或者汉字的首字母.

- (NSString *)firstCharactorWithString:(NSString *)string

{
    NSLog(@"===========%@", string);
    if (!string) {
        return @"";
    }
    NSMutableString *str = [NSMutableString stringWithString:string];
    
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSString *pinYin = [str capitalizedString];
    
    return [pinYin substringToIndex:1];
    
}


#pragma mark ----- tableView代理方法
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * array = self.dataDic[self.titleArray[section]];
    return array.count;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = self.dataDic[self.titleArray[indexPath.section]];
    NSString * name = @"";
    
    id infor = array[indexPath.row];
    
    if ([infor isKindOfClass:[XZZProvinceInfor class]]) {
        XZZProvinceInfor * provinceInfor = (XZZProvinceInfor *)infor;
        if (provinceInfor.provinceCode) {
            name = [NSString stringWithFormat:@"%@(%@)", provinceInfor.provinceName, provinceInfor.provinceCode];
        }else{
            name = ((XZZProvinceInfor *)infor).provinceName;
        }
    }else if ([infor isKindOfClass:[XZZCityInfor class]]) {
        name = ((XZZCityInfor *)infor).cityName;
    }else if ([infor isKindOfClass:[XZZCountryInfor class]]) {
        name = ((XZZCountryInfor *)infor).countryEnName;
    }
    
    
    
    UITableViewCell * cell = [UITableViewCell codeCellWithTableView:tableView];
    cell.textLabel.text = name;
    cell.textLabel.font = textFont(13);
    return cell;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.titleArray;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSArray * array = self.dataDic[self.titleArray[section]];
    id infor = [array firstObject];
    
    if ([infor isKindOfClass:[XZZCountryInfor class]] && section == 0) {
        return @"Common Country/Region";
    }
    return self.titleArray[section];
}


#pragma mark ----- 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = self.dataDic[self.titleArray[indexPath.section]];
    
    id infor = array[indexPath.row];
    
    !self.selectInfor?:self.selectInfor(infor);
    [self back];
    
    NSLog(@"%s %d 行", __func__, __LINE__);
}
#pragma mark ----- tableView代理结束



@end
