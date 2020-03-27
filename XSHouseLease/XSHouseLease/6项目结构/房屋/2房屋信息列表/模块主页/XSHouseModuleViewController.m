//
//  XSHouseModuleViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseModuleViewController.h"
#import "XSCollectionView.h"
#import "XSHouseInfoTableView.h"
#import "XSHouseRentInfoModel.h"

@interface XSHouseModuleViewController ()
@property (nonatomic,strong)XSRegionSearchView *searcView;
@property (strong, nonatomic) XSCollectionView *collectionView;
@property (strong, nonatomic) UIView *lineView;
@property (nonatomic,strong) XSHouseInfoTableView *tableView;

@end

@implementation XSHouseModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStyleDone target:self action:@selector(callMessage)];
    
    XSRegionSearchView *searcView = [[XSRegionSearchView alloc]init];
    self.searcView = searcView;

    
    XSCollectionView *collectionView = [[XSCollectionView alloc]init];
    collectionView.array = [XSHouseFixedData sharedInstance].renthouseConditionArray;
    self.collectionView = collectionView;

    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = XSColor(246, 243, 245);
    self.lineView = lineView;
    
    XSHouseInfoTableView *tableView = [[XSHouseInfoTableView alloc]init];
    self.tableView = tableView;

    
    self.navigationItem.titleView = searcView;
    [self.view addSubview:collectionView];
    [self.view addSubview:lineView];
    [self.view addSubview:tableView];

    
    
    [self searchRentHouse];
}
- (void)searchRentHouse{
    WEAK_SELF;
    [self.subInfoInterface searchRenthousListWithKeyVales:nil per_page:10 page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        if (error == nil) {
            if (responseModel.code.intValue == SuccessCode) {
                NSArray *array = [XSHouseRentInfoModel mj_objectArrayWithKeyValuesArray:responseModel.data];
                [self houseInfoClickSettingWithModelArray:array];
                self.tableView.array = array;
                [self.tableView reloadData];
            }
        }else{
            
        }
    }];
}
- (void)houseInfoClickSettingWithModelArray:(NSArray *)array{
    for (XSHouseRentInfoModel *model in array) {
        model.source = XSBHouseInfoSource_Search;
        model.clickBlack = ^(XSBHouseInfoModel * _Nonnull model, XShouseOperation operation) {
            if ([model isKindOfClass:[XSHouseRentInfoModel class]]) {
                XSHouseRentInfoModel *newModel = (XSHouseRentInfoModel *)model;
                NSLog(@"house_id = %@",newModel.house_id);
                
            }
        };

    }
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.searcView.frame = CGRectMake(0, 0, SCREEN_SIZE.width - 110, 40);
    self.collectionView.frame = CGRectMake(0, 0, self.view.width, 230);
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.view.width, 20);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), self.view.width, self.view.height- CGRectGetMaxY(self.lineView.frame));


}
- (void)callMessage{
    
}

@end
