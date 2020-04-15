//
//  XSPageViewController.m
//  XSHouseLease
//
//  Created by xs on 2020/4/15.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSPageViewController.h"


@implementation XSListContentViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
}
- (UIView *)listView {
    return self.view;
}
@end



@interface XSPageViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property(nonatomic,strong) JXCategoryTitleView *categoryView;
@property(nonatomic,strong) JXCategoryListContainerView *listContainerView;

@property(nonatomic,strong) NSArray<NSString *> *titles;
@property(nonatomic,strong) NSArray<id<JXCategoryListContentViewDelegate>> *listVc;

@end

@implementation XSPageViewController
- ( NSArray<NSString *>*)getTitlese{
    return nil;
}
- (NSArray<id<JXCategoryListContentViewDelegate>>*)getListVc{
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titles = [self getTitlese];
    self.listVc = [self getListVc];
    
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.titleColorGradientEnabled = YES;
    [self.view addSubview:self.categoryView];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor redColor];
    lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[lineView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];

    
    [self.view addSubview:self.listContainerView];
    //关联到categoryView
    self.categoryView.listContainer = self.listContainerView;
    
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
   self.listContainerView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), self.view.width, self.view.height - CGRectGetMaxY(self.categoryView.frame));
}
//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    
}
//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.listVc.count;
}
//根据下标index返回对应遵从`JXCategoryListContentViewDelegate`协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return [self.listVc safeObjectAtIndex:index];
}
@end
