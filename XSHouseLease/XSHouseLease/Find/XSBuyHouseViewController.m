//
//  XSBuyHouseViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/5/4.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBuyHouseViewController.h"

@interface XSBuyHouseViewController ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property(nonatomic,strong) JXCategoryTitleView *categoryView;
@property(nonatomic,strong) JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong) NSMutableArray<id<JXCategoryListContentViewDelegate>> *listVc;
@end

@implementation XSBuyHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, 250, 25)];
    self.categoryView.delegate = self;
    self.categoryView.titles = [self getTitlese];
    self.categoryView.titleFont = [UIFont systemFontOfSize:18];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelStrokeWidthEnabled = YES;
    self.categoryView.titleColor = [UIColor hx_colorWithHexStr:@"#929292"];
    self.categoryView.titleSelectedColor = [UIColor hx_colorWithHexStr:@"#E82B2B"];
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.backgroundColor = [UIColor clearColor];
    self.categoryView.listContainer = self.listContainerView;
    
    self.navigationItem.titleView = self.categoryView;
    [self.view addSubview:self.listContainerView];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.listContainerView.frame = self.view.bounds;

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
- ( NSArray<NSString *>*)getTitlese{
    return @[@"二手房",@"新房",@"租房"];;
}
- (NSMutableArray<id<JXCategoryListContentViewDelegate>>*)listVc{
    if (!_listVc) {
//        WEAK_SELF;
        _listVc = [NSMutableArray array];
        for (int i = 0; i < [self getTitlese].count; i++) {
            XSHouselishViewController *vc  = [[XSHouselishViewController alloc]init];
            vc.source  = XSBHouseInfoSource_keyPush;
            vc.resource  = self.resource;
            if (i == 0) {
                vc.houseType  = XSBHouseType_old;
            }else if (i == 1){
                vc.houseType  = XSBHouseType_New;
            }else{
                vc.houseType  = XSBHouseType_Rent;
            }
            [_listVc addObject:vc];
        }
    }

    return _listVc;
}
@end
