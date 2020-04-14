//
//  XSHouseDetailsController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseDetailsController.h"
#import "XSHouseInfoShowModel.h"
#import "XSHouseInfoShowCell.h"
#import "XSHouseMasterInfoView.h"

@interface XSHouseDetailsController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet XSHouseMasterInfoView *callView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *array;
@property(strong, nonatomic) XSHouseInfoShowModel *dataModel;

@property(strong, nonatomic) XSHouseDetailsDataModel *NewDetailsModel;


@end

@implementation XSHouseDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"房屋详情";

    self.array = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.backgroundColor = XSColor(246, 246, 246);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    WEAK_SELF;
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        STRONG_SELF;
        [self gethouseDetails];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    
    [self gethouseDetails];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"watch_Q"] style:UIBarButtonItemStyleDone target:self action:@selector(watch)];
 
}


- (void)gethouseDetails{
    WEAK_SELF;
    [self.subInfoInterface houseDetailsWithHouseType:self.houseType  house_id:self.houseid  callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
            [self.tableView.mj_header endRefreshing];
            if (error == nil) {
                if (responseModel.code.integerValue == SuccessCode) {
//                    if (self.houseType == XSBHouseType_New) {
//                        XSHouseDetailsDataModel *model = [XSHouseDetailsDataModel mj_objectWithKeyValues:responseModel.data];
//                        NSLog(@"111");
//                    }else{
//
//                    }
                    XSHouseInfoShowModel *model = [XSHouseInfoShowModel mj_objectWithKeyValues:responseModel.data];
                    model.houseType = self.houseType;
                    model.source = self.source;
                    [self assemblyCellDataArrayWithData:model];
   
                }
            }
    }];
}


// 组装数据
-(void)assemblyCellDataArrayWithData:(XSHouseInfoShowModel *)dataModel{
    self.dataModel = dataModel;

    self.callView.model = dataModel;
    if ([dataModel.house_id isEqual:[XSUserServer sharedInstance].userModel.ID]) {
//        [self.callView removeFromSuperview];
    }
    
    WEAK_SELF;
    self.dataModel.clickBlack = ^(XSHouseInfoModel *model, id data, XSBHouseKeyValueEditStatus editStatus) {
        STRONG_SELF;
        if (editStatus== XSBHouseKeyValueIntroduce ||
            editStatus == XSBHouseKeyValueInfoSMore ||
            editStatus == XSBHouseKeyValueInfoNMore ||
            editStatus == XSBHouseKeyValueInfoLDIX) {
            XSHouseIntroduceController *vc = [[XSHouseIntroduceController alloc]init];
            vc.dataModel = self.dataModel;
            vc.houseType = self.houseType;
            vc.infoType = editStatus;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
        }
    };
    [self.array removeAllObjects];
    NSError *error;
    NSString *file  = nil;
    if (self.houseType==XSBHouseType_old) {
        file  = @"XSSecondHouseDetailsInfo";
    }else if (self.houseType==XSBHouseType_New){
        file  = @"XSNewHouseDetailsInfo";
    }else{
        file  = @"XSRentHouseDetailsInfo";
    }

    NSString *path = [[NSBundle mainBundle]pathForResource:file ofType:@"json"];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *modelArray = [XSHouseInfoShowModel mj_objectArrayWithKeyValuesArray:dataArray];

    [self.array addObjectsFromArray:modelArray];
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XSHouseInfoCellModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    return dataModel.cellHeight?dataModel.cellHeight.floatValue:53.0;
}
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XSHouseInfoShowModel *model = [self.array safeObjectAtIndex:indexPath.row];
    
    XSHouseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellClass];
    if (!cell) {
         NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"XSHouseInfoShowCell" owner:self options:nil];
          cell = [array safeObjectAtIndex:[XSHouseInfoCell indexForClassName:model.cellClass]];
    }
    [cell updateWithModel:self.dataModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    XSHouseInfoShowModel *model = [self.array safeObjectAtIndex:indexPath.row];

}

- (void)watch{
    WEAK_SELF;
    [XSUserServer needLoginSuccess:^{
        STRONG_SELF;
        [self.subInfoInterface rentWatchHouseWithHouse_id:self.houseid houseType:self.houseType watch:YES callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            if (error == nil ) {
                if (responseModel.code.intValue == SuccessCode) {
                    [ProgressHUD showSuccess:@"关注成功"];
                }else{
                    [ProgressHUD showError:@"稍后再试"];
                }
            }
        }];
    } cancel:^{
        
    }];

}
@end
