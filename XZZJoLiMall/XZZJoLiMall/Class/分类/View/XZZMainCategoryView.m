//
//  XZZMainCategoryView.m
//  XZZJoLiMall
//
//  Created by 龙少 on 2019/1/11.
//  Copyright © 2019年 龙少. All rights reserved.
//

#import "XZZMainCategoryView.h"


@interface XZZMainCategoryView ()<UITableViewDelegate, UITableViewDataSource>

/**
 * 选中的分类信息
 */
@property (nonatomic, strong)XZZCategory * selectedCategory;

/**
 * tableview
 */
@property (nonatomic, strong)UITableView * tableView;


@end


@implementation XZZMainCategoryView


- (void)setCategoryArray:(NSArray<XZZCategory *> *)categoryArray
{
    if (categoryArray.count > 0) {
        _categoryArray = categoryArray;
    }
    if (!self.selectedCategory) {
        self.selectedCategory = [categoryArray firstObject];
    }
    [self.tableView reloadData];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        WS(wSelf)
        UITableView * tableView = [UITableView allocInit];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorColor = [UIColor clearColor];
        tableView.backgroundColor = Category_background;
        [self addSubview:tableView];
        self.tableView = tableView;
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(wSelf);
        }];
    }
    return _tableView;
}

- (void)setSelectedCategory:(XZZCategory *)selectedCategory
{
    _selectedCategory = selectedCategory;
    if ([self.delegate respondsToSelector:@selector(selectiveClassificationInfor:source:)]) {
        [self.delegate selectiveClassificationInfor:selectedCategory source:self];
    }
}


#pragma mark ----- tableView代理方法
#pragma mark ----- 设置区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark ----- 设置行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryArray.count;
}
#pragma mark ----- 设置cell信息
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XZZMainCategoryCell * cell = [XZZMainCategoryCell codeCellWithTableView:tableView];
    XZZCategory * category = self.categoryArray[indexPath.row];
    cell.category = category;
    cell.isSelected = [category.ID isEqual:self.selectedCategory.ID];
    return cell;
}
#pragma mark ----- 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark ----- 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d 行", __func__, __LINE__);
    XZZMainCategoryCell * cell = (XZZMainCategoryCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.selectedCategory = cell.category;
    [tableView reloadData];
}
#pragma mark ----- tableView代理结束



@end


@interface XZZMainCategoryCell ()

/**
 * 展示名字 label
 */
@property (nonatomic, strong)UILabel * nameLabel;

/**
 * 前缀视图
 */
@property (nonatomic, strong)UIView * dividerView;


@end

@implementation XZZMainCategoryCell

- (void)addView{
    WS(wSelf)
    self.dividerView = [UIView allocInit];
    self.dividerView.backgroundColor = Category_main_selected_label_color;
    [self addSubview:self.dividerView];
    [self.dividerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(wSelf);
        make.width.equalTo(@3);
    }];
    
    self.nameLabel = [UILabel allocInit];
    self.nameLabel.font = Category_main_label_font;
    self.nameLabel.numberOfLines = 2;
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(wSelf);
        make.left.equalTo(@15);
    }];
    
}

- (void)setCategory:(XZZCategory *)category
{
    _category = category;
    if (!self.nameLabel) {
        [self addView];
    }
    self.nameLabel.text = category.name;
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.backgroundColor = [UIColor whiteColor];
        self.dividerView.hidden = NO;
        self.nameLabel.textColor = Category_main_selected_label_color;
    }else{
        self.backgroundColor = Category_background;
        self.dividerView.hidden = YES;
        self.nameLabel.textColor = Category_main_noSelected_label_color;
    }
}


@end
