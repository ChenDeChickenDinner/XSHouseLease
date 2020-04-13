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
#import "XSHouseMasterInfoView.h"

@interface XSHouseIntroduceController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet XSHouseMasterInfoView *callView;
@property (strong, nonatomic) NSMutableArray<XSHouseMoreInfoCellMdeol *> *array;
@property(nonatomic,copy) NSString *cellClass;
@end

@implementation XSHouseIntroduceController
- (NSMutableArray<XSHouseMoreInfoCellMdeol *> *)array{
    if (!_array) {
        _array = [NSMutableArray array];
        if (self.infoType == XSBHouseMorenInfo_FYXQ) {
            XSHouseMoreInfoCellMdeol *model1 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model1.title = @"核心卖点";
            model1.value = self.dataModel.coreIntroduced;
            model1.cellClass = @"XSHouseSubTextViewCell";
            model1.cellHeight = [NSNumber numberWithInt:90];
            
            XSHouseMoreInfoCellMdeol *model11 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model11.title = @"户型介绍";
            model11.value = self.dataModel.modelIntroduced;
            model11.cellClass = @"XSHouseSubTextViewCell";
            model11.cellHeight = [NSNumber numberWithInt:90];
            
            XSHouseMoreInfoCellMdeol *model2 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model2.title = @"交通出行";
            model2.value = self.dataModel.transportation;
            model2.cellClass = @"XSHouseSubTextViewCell";
            model2.cellHeight = [NSNumber numberWithInt:90];
            
            XSHouseMoreInfoCellMdeol *model3 = [[XSHouseMoreInfoCellMdeol alloc]init];
            model3.title = @"小区介绍";
            model3.value = self.dataModel.estateIntroduced;
            model3.cellClass = @"XSHouseSubTextViewCell";
            model3.cellHeight = [NSNumber numberWithInt:90];

            [_array addObject:model1];
            if (self.houseType == XSBHouseType_old)[_array addObject:model11];
            [_array addObject:model2];
            [_array addObject:model3];
        }
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.infoType == XSBHouseMorenInfo_FYXQ) {
        self.title = @"房源详情";
    }
    self.callView.model = self.dataModel;;
    if ([self.dataModel.house_id isEqual:[XSUserServer sharedInstance].userModel.ID]) {
//        [self.callView removeFromSuperview];
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XSHouseMoreInfoCellMdeol *dataModel = [self.array safeObjectAtIndex:indexPath.row];

    return dataModel.cellHeight?dataModel.cellHeight.floatValue:53.0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XSHouseMoreInfoCellMdeol *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    if ([dataModel.cellClass isEqualToString:@"XSHouseSubTextViewCell"]) {
        XSHouseSubTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dataModel.cellClass];
            if (!cell) {
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XSHouseSubTableViewCell class]) owner:self options:nil];
                cell = [array safeObjectAtIndex:[XSHouseSubTableViewCell indexForClassName:dataModel.cellClass]];
            }
          cell.keyValueModel = dataModel;
          return cell;
    }else{
        
    }
    return nil;
}
@end

@implementation XSHouseMoreInfoCellMdeol



@end
