//
//  XSHouseDetailsController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseDetailsController.h"
#import "XSHouseRentInfoModel.h"
#import "XSHouseDetailsInfoCellModel.h"
#import "XSHouseInfoCell.h"

@interface XSHouseDetailsController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation XSHouseDetailsController

- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"房屋详情";

    UITableView *tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.backgroundColor = XSColor(246, 246, 246);
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
    WEAK_SELF;
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        STRONG_SELF;
        [self gethouseDetails];
    }];
    

    [self gethouseDetails];
   
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}
- (void)gethouseDetails{
    WEAK_SELF;
    [self.subInfoInterface renthouseDetailsWithHouse_id:self.houseid callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        [self.tableView.mj_header endRefreshing];
        if (error == nil) {
            if (responseModel.code.integerValue == SuccessCode) {
                XSHouseRentInfoModel *model = [XSHouseRentInfoModel mj_objectWithKeyValues:responseModel.data];
                NSLog(@"房屋详情 = %@",[model mj_keyValues]);
                [self assemblyCellDataArrayWithData:model];
            }
        }
        
    }];
}
// 组装数据
-(void)assemblyCellDataArrayWithData:(XSHouseRentInfoModel *)dataModel{
    [self.array removeAllObjects];
    
    NSError *error;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"XSHouseDetailsInfo" ofType:@"json"];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *modelArray = [XSHouseDetailsInfoCellModel mj_objectArrayWithKeyValuesArray:dataArray];
    for (XSHouseDetailsInfoCellModel *model in modelArray) {
        model.dataModel = dataModel;
    }
    [self.array addObjectsFromArray:modelArray];
    
    [self.tableView reloadData];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}



- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XSHouseDetailsInfoCellModel *model = [self.array safeObjectAtIndex:indexPath.row];
    
    XSHouseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellClass];
    if (!cell) {
         cell = [[NSBundle mainBundle] loadNibNamed:model.cellClass owner:self options:nil].lastObject;
    }
    [cell updateWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XSHouseDetailsInfoCellModel *model = [self.array safeObjectAtIndex:indexPath.row];
    if (model.clickBlack) {
        model.clickBlack(model, XShouseOperation_click);
    }
}
@end
