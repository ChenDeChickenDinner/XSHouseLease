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
#import "XSHouseDetailsController.h"
#import "XSHouseSubmitFirstViewController.h"

@interface XSMyPublishHosueController ()
@property (nonatomic,strong) XSHouseInfoTableView *tableView;

@end

@implementation XSMyPublishHosueController
- (NSMutableDictionary *)searchDict{
    if (!_searchDict) {
        _searchDict = [NSMutableDictionary dictionary];
    }
    return _searchDict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.alittle) {
        self.tableView.scrollEnabled = NO;
    }
        if (self.source == XSBHouseInfoSource_Search) {
            if (!self.title)self.title = @"租房搜索";
       }else if (self.source == XSBHouseInfoSource_MyPublish){
           self.title = @"我发布的租房";
       }else if (self.source == XSBHouseInfoSource_MyWatch){
           self.title = @"我关注的租房";
       }else if (self.source == XSBHouseInfoSource_MyPush){
           self.title = @"更多推荐";
       }
    
    XSHouseInfoTableView *tableView = [[XSHouseInfoTableView alloc]init];
    WEAK_SELF;
    if (self.source != XSBHouseInfoSource_MyPush) {
        tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            STRONG_SELF;
            [self loadData];
        }];
//        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                 STRONG_SELF;
//            [self loadData];
//         }];
    }

    tableView.mj_header.automaticallyChangeAlpha = YES;
    tableView.mj_footer.automaticallyChangeAlpha = YES;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView reloadData];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;

}
#define number 30
- (void)loadData{
    WEAK_SELF;
    [self.searchDict safeSetObject:@"1" forKey:@"cityId"];

    if (self.source == XSBHouseInfoSource_Search) {
        [self.subInfoInterface searchRenthousListWithKeyVales:self.searchDict per_page:number page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
              [self dataProcessingWithResponseModel:responseModel error:error];
        }];
    }else if (self.source == XSBHouseInfoSource_MyPublish){
        [self.subInfoInterface myPublishHosueWithPer_page:number page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
            [self dataProcessingWithResponseModel:responseModel error:error];
        }];
    }else if (self.source == XSBHouseInfoSource_MyWatch){
        [self.subInfoInterface watchRenthousListWithKeyVales:self.searchDict per_page:number page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
              [self dataProcessingWithResponseModel:responseModel error:error];
        }];
    }else if (self.source == XSBHouseInfoSource_MyPush){
        
        [self.subInfoInterface searchRenthousListWithKeyVales:self.searchDict per_page:number page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
              [self dataProcessingWithResponseModel:responseModel error:error];
        }];
//        [self.subInfoInterface watchlikeRenthousListWithhouse_id:self.house_id per_page:10 page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
//            STRONG_SELF;
//            [self dataProcessingWithResponseModel:responseModel error:error];
//        }];
    }


    


}
- (void)dataProcessingWithResponseModel:(XSNetworkResponse *)responseModel error:(NSError *)error{
          [self.tableView.mj_header endRefreshing];
           [self.tableView.mj_footer endRefreshing];
        if (error == nil) {
            [self.tableView.array removeAllObjects];
            if (responseModel.code.intValue == SuccessCode) {
                NSMutableArray *array = [XSHouseRentInfoModel mj_objectArrayWithKeyValuesArray:responseModel.data];
                [self houseInfoClickSettingWithModelArray:array];
               if (self.alittle) {
                    for (int i = 0; i<= 2; i++) {
                        [self.tableView.array  addObject:[array safeObjectAtIndex:i]];
                    }
              
                }else{
                    self.tableView.array = array;

                }
                [self.tableView reloadData];
            }
        }else{
            
        }
}
- (void)houseInfoClickSettingWithModelArray:(NSArray *)array{
    WEAK_SELF;
    for (XSHouseRentInfoModel *model in array) {
        model.source = self.source;
        model.houseType = self.houseType;
        model.clickBlack = ^(XSBHouseInfoModel * _Nonnull model, XShouseOperation operation) {
            
            STRONG_SELF;
            if ([model isKindOfClass:[XSHouseRentInfoModel class]]) {
                XSHouseRentInfoModel *newModel = (XSHouseRentInfoModel *)model;
                NSLog(@"house_id = %@",newModel.house_id);
                XSHouseDetailsController *vc = [[XSHouseDetailsController alloc]init];
                vc.houseid = newModel.house_id.stringValue;
                [[NSObject getTopViewController].navigationController pushViewController:vc animated:YES];
            }
        };
        model.clickEditStatu = ^(NSNumber * _Nonnull status, NSNumber * _Nonnull houseID) {
            STRONG_SELF;
            [self editHouseStatusWith:status houseId:houseID];
        };
    }
}

- (void)editHouseStatusWith:(NSNumber *)status houseId:(NSNumber *)houseId{
    if (status.integerValue == XSBHouseSubStatus_edit) {
//        [ProgressHUD showSuccess:@"努力开发中"];
        [self gethouseDetailsWithhouseid:houseId];
    }else{
        WEAK_SELF;
        [self.subInfoInterface editHouseStatusWithHouse_id:houseId.stringValue houseType:XSBHouseType_Rent status:status.integerValue callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
             if (error == nil) {
                 if (responseModel.code.integerValue == SuccessCode) {
                     [self loadData];
                     [ProgressHUD showSuccess:@"操作成功"];
                 }else{
                     [ProgressHUD showError:error.description];
                 }
             }
         }];
    }
 
}


- (void)gethouseDetailsWithhouseid:(NSNumber *)houseid{
    WEAK_SELF;
    [ProgressHUD show];
    [self.subInfoInterface renthouseDetailsWithHouse_id:houseid.stringValue callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        [ProgressHUD dismiss];
            if (error == nil) {
            if (responseModel.code.integerValue == SuccessCode) {
                XSHouseRentInfoModel *model = [XSHouseRentInfoModel mj_objectWithKeyValues:responseModel.data];
//                NSLog(@"房屋详情 = %@",[model mj_keyValues]);
                XSHouseSubmitFirstViewController *vc = [[XSHouseSubmitFirstViewController alloc]init];
                vc.renhousetInfoModel = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
    }];
}
@end
