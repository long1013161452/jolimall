//
//  XZZSubclassCategoryView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZSubclassCategoryView.h"

/**
 *  分类图片宽高比
 */
#define category_image_height_width_proportion (1.0 / 1.0)

#pragma mark ----*  展示二级三级分类
/**
 *
 *  展示二级三级分类
 */

@interface XZZSubclassCategoryView ()<UITableViewDelegate, UITableViewDataSource>

/**
 * tableveiw
 */
@property (nonatomic, strong)UITableView * tableView;

@end


@implementation XZZSubclassCategoryView


- (void)setCategory:(XZZCategory *)category
{
    _category = category;
    [self.tableView reloadData];
}

#pragma mark ----*  懒加载   tableview
/**
 *  懒加载   tableview
 */
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView * tableView = [UITableView allocInit];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorColor = [UIColor clearColor];
        [self addSubview:tableView];
        self.tableView = tableView;
        WS(wSelf);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(wSelf);
        }];
    }
    return _tableView;
}


#pragma mark ----- tableView代理方法
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.category.children.count;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XZZCategory * category = self.category.children[section];
    return (category.children.count + Category_Subclass_count - 1) / Category_Subclass_count;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XZZSubclassCategoryCell * cell = [XZZSubclassCategoryCell codeCellWithTableView:tableView];
    NSInteger count = Category_Subclass_count * indexPath.row;
    NSMutableArray * array = @[].mutableCopy;
    XZZCategory * category = self.category.children[indexPath.section];
    for (int i = 0; i < Category_Subclass_count; i++) {
        if (count < category.children.count) {
            [array addObject:category.children[count]];
        }
        count++;
    }
    cell.categoryArray = array;
    cell.delegate = self.delegate;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [XZZSubclassCategoryCell getHeight];
}

#pragma mark ---- 设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
#pragma mark ---- 设置区头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XZZSubclassCategoryHeaderView * headerView = [XZZSubclassCategoryHeaderView allocInit];
    headerView.category = self.category.children[section];
    headerView.delegate = self.delegate;
    return headerView;
}

#pragma mark ----- tableView代理结束
@end

#pragma mark ---- *  展示分类信息   头部
/**
 *  展示分类信息   头部
 */
@implementation XZZSubclassCategoryHeaderView

- (void)setCategory:(XZZCategory *)category
{
    _category = category;
    [self addView];
    
}

- (void)addView{
    
    self.backgroundColor = Category_background;
    WS(wSelf)
    UILabel * nameLabel = [UILabel allocInit];
    nameLabel.font = Category_Subclass_font;
    nameLabel.textColor = Category_Subclass_color;
    nameLabel.text = self.category.name;
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(wSelf);
        make.left.equalTo(@10);
    }];
    
    UILabel * allLabel = [UILabel allocInit];
    allLabel.textColor = Category_Subclass_all_color;
    allLabel.font = textFont(12);
    allLabel.text = @"ALL>";
    [self addSubview:allLabel];
    
    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(wSelf);
        make.right.equalTo(wSelf).offset(-15);
    }];
    UIButton * button = [UIButton allocInit];
    [button addTarget:self action:@selector(clickOnCategoryButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(wSelf);
    }];
}

- (void)clickOnCategoryButton:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(selectiveClassificationInfor:source:)]) {
        [self.delegate selectiveClassificationInfor:self.category source:@"2"];
    }
}

@end

#pragma mark ----*  展示一排分类信息   三个分类
/**
 *  展示一排分类信息   三个分类
 */
@implementation XZZSubclassCategoryCell

+ (CGFloat)getHeight
{
    CGFloat viewWidth = ScreenWidth / 4.0 * 3;
    CGFloat width = (viewWidth - (goodsList_goods_interval * 4)) / 3;
    CGFloat height = width * category_image_height_width_proportion + 35;
    return height + goodsList_goods_interval * 2;
}

- (void)setCategoryArray:(NSArray<XZZCategory *> *)categoryArray
{
    _categoryArray = categoryArray;
    [self removeAllSubviews];
    [self addView];
}

- (void)addView{
    CGFloat viewWidth = ScreenWidth / 4.0 * 3;
    
    CGFloat width = (viewWidth - (goodsList_goods_interval * 4)) / 3;
    CGFloat height = width * category_image_height_width_proportion + 35;
    CGFloat left = goodsList_goods_interval;
    for (XZZCategory * category in self.categoryArray) {
        XZZDisplaySingleCategoryView * categoryView = [XZZDisplaySingleCategoryView allocInitWithFrame:CGRectMake(left, goodsList_goods_interval, width, height)];
        categoryView.category = category;
        [categoryView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnCategoryTap:)]];
        [self addSubview:categoryView];
        left = categoryView.right + goodsList_goods_interval;
    }
}

- (void)clickOnCategoryTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(selectiveClassificationInfor:source:)]) {
        XZZDisplaySingleCategoryView * view = (XZZDisplaySingleCategoryView *)tap.view;
        [self.delegate selectiveClassificationInfor:view.category source:@"3"];
    }
}

@end

#pragma mark ---- *  展示单个分类信息   三级
/**
 *   *  展示单个分类信息   三级
 */
@implementation XZZDisplaySingleCategoryView

- (void)setCategory:(XZZCategory *)category
{
    _category = category;
    [self addView];
}

- (void)addView{
    WS(wSelf)
    FLAnimatedImageView * imageView = [FLAnimatedImageView allocInit];
    [imageView addImageFromUrlStr:self.category.picture];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(wSelf);
        make.height.equalTo(imageView.mas_width).multipliedBy(category_image_height_width_proportion);
    }];
    
    UILabel * nameLabel = [UILabel allocInit];
    nameLabel.text = self.category.name;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = textFont(11);
    nameLabel.textColor = Category_main_noSelected_label_color;
    nameLabel.numberOfLines = 2;
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wSelf);
        make.top.equalTo(imageView.mas_bottom).offset(5);
    }];
    
}

@end
