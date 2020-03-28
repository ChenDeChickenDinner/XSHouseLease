//
//  XSHouseIntroduceController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseIntroduceController.h"
#import "XSHouseSubTableViewCell.h"
#import "XSHouseSubTextViewCell.h"
#import "XSHouseSubCollectionviewBCell.h"
#import "XSHouseSubCollectionviewACell.h"
#import "XSHouseSubTextFieldTableViewCell.h"
#import "XSHouseSubListChooseTableViewCell.h"
#import "XSPhotoPickerView.h"
#import "XSHouseSubSuccessViewController.h"
@interface XSHouseIntroduceController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XSHouseIntroduceController
- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"房源详情";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
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
    Class cls = NSClassFromString(dataModel.cellClass);
    XSHouseSubTableViewCell *cell = nil;
    if ([cls isSubclassOfClass:[XSHouseSubTextFieldTableViewCell class]]) {
        cell = [XSHouseSubTextFieldTableViewCell cellWithtableView:tableView];
        
    }else if ([cls isSubclassOfClass:[XSHouseSubListChooseTableViewCell class]]){
        cell = [XSHouseSubListChooseTableViewCell cellWithtableView:tableView];
        
    }else if ([cls isSubclassOfClass:[XSHouseSubCollectionviewACell class]]){
        cell = [XSHouseSubCollectionviewACell cellWithtableView:tableView];
        
    }else if ([cls isSubclassOfClass:[XSHouseSubCollectionviewBCell class]]){
        cell = [XSHouseSubCollectionviewBCell cellWithtableView:tableView];
        
    }else if ([cls isSubclassOfClass:[XSHouseSubTextViewCell class]]){
        cell = [XSHouseSubTextViewCell cellWithtableView:tableView];
        
    }else{
        cell = [XSHouseSubTableViewCell cellWithtableView:tableView];
    }
    cell.dataModel =dataModel;
//    cell.keyValueModel = dataModel;
    [cell refreshData];
    return cell;
}
@end
