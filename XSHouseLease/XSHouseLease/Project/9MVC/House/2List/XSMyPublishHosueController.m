//
//  XSMyPublishHosueController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSMyPublishHosueController.h"
#import "XSHouseInfoTableView.h"
#import "XSHouseInfoShowModel.h"
#import "XSHouseDetailsController.h"
#import "XSHouseSubmitFirstViewController.h"
#define number 20
@interface XSMyPublishHosueController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *array;

@end

@implementation XSMyPublishHosueController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray array];

    if (self.title == nil) {
        if (self.source == XSBHouseInfoSource_MyPublish){
            if (self.houseType == XSBHouseType_Rent) {
                self.title = @"我发布的租房";
            }else if (self.houseType == XSBHouseType_old){
                self.title = @"我发布的二手房";
            }
        }else if (self.source == XSBHouseInfoSource_MyWatch){
            if (self.houseType == XSBHouseType_Rent) {
                self.title = @"我关注的租房";
            }else if (self.houseType == XSBHouseType_old){
                self.title = @"我关注的二手房";
            }else if (self.houseType == XSBHouseType_New){
                self.title = @"我关注的新房";
            }
        }else{
            self.title = @"猜你喜欢";
        }
    }

    
    self.tableView = [[UITableView alloc]init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;

    WEAK_SELF;
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        STRONG_SELF;
        [self loadData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    }];

    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    [self loadData];

}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma mark -数据请求
- (void)loadData{
    if (self.alittle) {
        self.tableView.mj_header  = nil;
        self.tableView.mj_footer  = nil;
        self.tableView.scrollEnabled = NO;
    }
    WEAK_SELF;
    [self.subInfoInterface houseLisetWith:self.houseType source:self.source house_id:self.house_id?self.house_id.stringValue:@"" KeyVales:[NSMutableDictionary dictionary] per_page:number page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        [self dataProcessingWithResponseModel:responseModel error:error];
    }];


}
#pragma mark -数据处理
- (void)dataProcessingWithResponseModel:(XSNetworkResponse *)responseModel error:(NSError *)error{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (error == nil) {
        [self.array removeAllObjects];
        if (responseModel.code.intValue == SuccessCode) {
            NSMutableArray *array = [XSHouseInfoShowModel mj_objectArrayWithKeyValuesArray:responseModel.data];
            [self houseInfoClickSettingWithModelArray:array];
            if (self.alittle && array.count >=3) {
                [self.array addObject:array[0]];
                [self.array addObject:array[1]];
                [self.array addObject:array[2]];
            }else{
                [self.array addObjectsFromArray:array];
            }
       
            [self.tableView reloadData];
        }
    }
}
#pragma mark -房屋操作预埋Block
- (void)houseInfoClickSettingWithModelArray:(NSArray *)array{
    WEAK_SELF;
    for (XSHouseInfoShowModel *model in array) {
        model.source = self.source;
        model.houseType = self.houseType;
        model.clickEditStatu = ^(NSNumber * _Nonnull status, NSNumber * _Nonnull houseID) {
            STRONG_SELF;
            [self editHouseStatusWith:status houseId:houseID];
        };
    }
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XSHouseInfoShowModel *model = [self.array safeObjectAtIndex:indexPath.row];
    static NSString *ID = @"XSHouseRentInfoCell";
    XSHouseRentInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
           cell = [[NSBundle mainBundle] loadNibNamed:@"XSHouseInfoShowCell" owner:self options:nil].firstObject;
          NSLog(@"0000");
    }
    [cell updateWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        XSHouseInfoShowModel *model = [self.array safeObjectAtIndex:indexPath.row];
    if (self.houseType == XSBHouseType_New) {
        
    }else{
        XSHouseDetailsController *vc = [[XSHouseDetailsController alloc]init];
        vc.houseType = self.houseType;
        vc.source = self.source;
        vc.houseid = model.house_id;
        [[NSObject getTopViewController].navigationController pushViewController:vc animated:YES];
    }
  
}

#pragma mark -房屋重新编辑/状态更变
- (void)editHouseStatusWith:(NSNumber *)status houseId:(NSNumber *)houseId{
    if (status.integerValue == XSBHouseSubStatus_edit) {
        [self gethouseDetailsWithhouseid:houseId];
    }else{
        WEAK_SELF;
        [self.subInfoInterface editHouseStatusWithHouse_id:houseId houseType:XSBHouseType_Rent status:status.integerValue callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
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

#pragma mark -重新编辑
- (void)gethouseDetailsWithhouseid:(NSNumber *)houseid{
    if (houseid == nil) {
        return;
    }
    WEAK_SELF;
    [ProgressHUD show];
    [self.subInfoInterface houseDetailsWithHouseType:self.houseType  house_id:houseid?houseid.stringValue:nil  callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
         [ProgressHUD dismiss];
          if (error == nil) {
              if (responseModel.code.integerValue == SuccessCode) {
                  XSHouseInfoShowModel *model = [XSHouseInfoShowModel mj_objectWithKeyValues:responseModel.data];
                  XSHouseSubmitFirstViewController *vc = [[XSHouseSubmitFirstViewController alloc]init];
                  vc.subMitServer.renhousetInfoModel = model;
                  [self.navigationController pushViewController:vc animated:YES];
              }
         }
    }];
    
}
@end
