//
//  XSMyPublishHosueController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSMyPublishHosueController.h"
#import "XSHouseInfoTableView.h"
#import "XSHouseRentInfoModel.h"
@interface XSMyPublishHosueController ()
@property (nonatomic,strong) XSHouseInfoTableView *tableView;

@end

@implementation XSMyPublishHosueController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        if (self.source == XSBHouseInfoSource_Search) {
            self.title = @"租房搜索";
       }else if (self.source == XSBHouseInfoSource_MyPublish){
           self.title = @"我发布的租房";
       }else if (self.source == XSBHouseInfoSource_MyWatch){
           self.title = @"我关注的租房";
       }else if (self.source == XSBHouseInfoSource_MyPush){
           self.title = @"猜你你喜欢的租房";
       }
    
    XSHouseInfoTableView *tableView = [[XSHouseInfoTableView alloc]init];
    WEAK_SELF;
    tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        STRONG_SELF;
        [self loadMyPublishHosue];
    }];
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
             STRONG_SELF;
        [self loadMyPublishHosue];
     }];
    tableView.mj_header.automaticallyChangeAlpha = YES;
    tableView.mj_footer.automaticallyChangeAlpha = YES;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView reloadData];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadMyPublishHosue];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;

}
- (void)loadMyPublishHosue{
    WEAK_SELF;
    NSMutableDictionary *search = [NSMutableDictionary dictionary];
    [search safeSetObject:@"1" forKey:@"cityId"];

    if (self.source == XSBHouseInfoSource_Search) {
        [self.subInfoInterface searchRenthousListWithKeyVales:search per_page:10 page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
              [self dataProcessingWithResponseModel:responseModel error:error];
        }];
    }else if (self.source == XSBHouseInfoSource_MyPublish){
        [self.subInfoInterface myPublishHosueWithPer_page:10 page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
            [self dataProcessingWithResponseModel:responseModel error:error];
        }];
    }else if (self.source == XSBHouseInfoSource_MyWatch){
        [self.subInfoInterface watchRenthousListWithKeyVales:search per_page:10 page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
              [self dataProcessingWithResponseModel:responseModel error:error];
        }];
    }else if (self.source == XSBHouseInfoSource_MyPush){
        [self.subInfoInterface watchlikeRenthousListWithPer_page:10 page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
              [self dataProcessingWithResponseModel:responseModel error:error];
        }];
    }


    


}
- (void)dataProcessingWithResponseModel:(XSNetworkResponse *)responseModel error:(NSError *)error{
          [self.tableView.mj_header endRefreshing];
           [self.tableView.mj_footer endRefreshing];
        if (error == nil) {
            if (responseModel.code.intValue == SuccessCode) {
                NSArray *array = [XSHouseRentInfoModel mj_objectArrayWithKeyValuesArray:responseModel.data];
                [self houseInfoClickSettingWithModelArray:array];
                self.tableView.array = array;
                [self.tableView reloadData];
            }
        }else{
            
        }
}
- (void)houseInfoClickSettingWithModelArray:(NSArray *)array{
    for (XSHouseRentInfoModel *model in array) {
        model.source = self.source;
        model.houseType = self.houseType;
        model.clickBlack = ^(XSBHouseInfoModel * _Nonnull model, XShouseOperation operation) {
            if ([model isKindOfClass:[XSHouseRentInfoModel class]]) {
                XSHouseRentInfoModel *newModel = (XSHouseRentInfoModel *)model;
                NSLog(@"house_id = %@",newModel.house_id);
            }
        };
    }
}
@end
