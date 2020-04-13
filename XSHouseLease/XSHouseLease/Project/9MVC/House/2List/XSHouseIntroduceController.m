//
//  XSHouseIntroduceController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseIntroduceController.h"
#import "XSHouseSubTableViewCell.h"
#import "XSPhotoPickerView.h"
#import "XSHouseSubSuccessViewController.h"
@interface XSHouseIntroduceController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<XSKeyValue *> *array;
@property (weak, nonatomic) IBOutlet XSHouseMasterInfoCell *callView;

@end

@implementation XSHouseIntroduceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"房源详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    XSKeyValue *model1 = [[XSKeyValue alloc]init];
    model1.key = @"核心卖点";
    model1.value = self.dataModel.coreIntroduced;
    model1.cellClass = @"XSHouseSubTextViewCell";
    model1.cellHeight = [NSNumber numberWithInt:90];
    
    XSKeyValue *model11 = [[XSKeyValue alloc]init];
    model11.key = @"户型介绍";
    model11.value = self.dataModel.modelIntroduced;
    model11.cellClass = @"XSHouseSubTextViewCell";
    model11.cellHeight = [NSNumber numberWithInt:90];
    
    XSKeyValue *model2 = [[XSKeyValue alloc]init];
    model2.key = @"交通出行";
    model2.value = self.dataModel.transportation;
    model2.cellClass = @"XSHouseSubTextViewCell";
    model2.cellHeight = [NSNumber numberWithInt:90];
    
    XSKeyValue *model3 = [[XSKeyValue alloc]init];
    model3.key = @"小区介绍";
    model3.value = self.dataModel.estateIntroduced;
    model3.cellClass = @"XSHouseSubTextViewCell";
    model3.cellHeight = [NSNumber numberWithInt:90];

    NSMutableArray *array = [NSMutableArray array];
    [array addObject:model1];
    if (self.houseType == XSBHouseType_old) {
        [array addObject:model11];

    }
    [array addObject:model2];
    [array addObject:model3];
    self.array = array;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XSHouseInfoCellModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];

    return dataModel.cellHeight?dataModel.cellHeight.floatValue:53.0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XSHouseInfoCellModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    XSHouseSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dataModel.cellClass];
        if (!cell) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XSHouseSubTableViewCell class]) owner:self options:nil];
            cell = [array safeObjectAtIndex:[XSHouseSubTableViewCell indexForClassName:dataModel.cellClass]];
        }
      cell.dataModel =dataModel;
      [cell refreshData];
      return cell;
}
@end

