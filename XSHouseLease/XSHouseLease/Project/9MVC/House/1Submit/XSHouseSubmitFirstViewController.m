//
//  XSHouseSubmitFirstViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubmitFirstViewController.h"
#import "XSHouseSubTableViewCell.h"
#import "XSPhotoPickerView.h"
#import "XSHouseSubSuccessViewController.h"
#import "AFNetworking.h"

@interface XSHouseSubmitFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet XSRoundedBtn1View *nextBtn;
@property(nonatomic,assign) XSHouseSubmitStepsType submitStepsType;
@property (strong, nonatomic) NSMutableArray<XSHouseInfoCellModel *> *array;
@end

@implementation XSHouseSubmitFirstViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.array = [NSMutableArray array];

    if (self.submitType == XSHouseSubmitType_Rent) {
      self.title = @"我要出租";
    }else if (self.submitType == XSHouseSubmitType_Sell){
      self.title = @"免费发布房源";
    }

    if (self.submitStepsType == XSHouseSubmitStepsType_First) {
        self.subMitServer = [[XSHouseSubMitServer alloc]init];
        self.subMitServer.submitType = self.submitType;

        [self.array addObjectsFromArray:self.subMitServer.firstArray];
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }else if (self.submitStepsType == XSHouseSubmitStepsType_Second){
        [self.array addObjectsFromArray:self.subMitServer.secondArray];
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }else if (self.submitStepsType == XSHouseSubmitStepsType_Third){
        [self.array addObjectsFromArray:self.subMitServer.thirdArray];
        [self.nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    
    [self.myTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XSHouseInfoCellModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    return dataModel.cellHeight?dataModel.cellHeight.floatValue:53.0;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
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


- (IBAction)nextStepClick:(UIButton *)sender {
    XSHouseSubmitFirstViewController *next = [[XSHouseSubmitFirstViewController alloc]init];
    next.subMitServer = self.subMitServer;
    if (self.submitStepsType == XSHouseSubmitStepsType_First) {
        next.submitStepsType = XSHouseSubmitStepsType_Second;
        [self.navigationController pushViewController:next animated:YES];
    }else if (self.submitStepsType == XSHouseSubmitStepsType_Second){
        next.submitStepsType = XSHouseSubmitStepsType_Third;
        [self.navigationController pushViewController:next animated:YES];
    }else if (self.submitStepsType == XSHouseSubmitStepsType_Third){
        [self submitRenthouseSave];
    }
}


- (void)submitRenthouseSave{
    NSLog(@"------%@",self.subMitServer.subRentParameterDict);
    return;
    WEAK_SELF;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.subInfoInterface renthouseSaveWithDict:self.subMitServer.subRentParameterDict callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        [MBProgressHUD  hideHUDForView:self.view animated:YES];
        if (error == nil) {
            if (responseModel.code.integerValue == SuccessCode) {
                   XSHouseSubSuccessViewController *success = [[XSHouseSubSuccessViewController alloc]init];
                    success.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:success animated:YES completion:nil];
            }else{
                [self alertWithMessage:responseModel.message];
            }
        }else{
           [self alertWithMessage:error.domain];
        }
    }];
}


@end
