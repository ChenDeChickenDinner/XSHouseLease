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
@property (strong, nonatomic)  XSPhotoPickerView *pickerView;
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
//    [[XSHouseSubMitServer sharedInstance] resetData];

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
        self.myTableView.tableHeaderView = self.pickerView;
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

- (void)pickerViewInit{
    WEAK_SELF;
    XSPhotoPickerView *pickerView = [[XSPhotoPickerView alloc]initWithFrame:CGRectMake(0, 0, self.myTableView.width, 280)];

     pickerView.changeCompleteBlock = ^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photos, NSArray<HXPhotoModel *> *videos, BOOL isOriginal) {
         STRONG_SELF;
         [self.subMitServer.imageUrlArray removeAllObjects];
         for (HXPhotoModel *photoModel in photos) {
             [photoModel requestImageURLStartRequestICloud:nil progressHandler:nil success:^(NSURL * _Nullable imageURL, HXPhotoModel * _Nullable model, NSDictionary * _Nullable info) {
                 NSSLog(@"imageURL: %@\n",imageURL );
                 [self.subMitServer.imageUrlArray addObject:imageURL];
             } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {

             }];
         }

       };
    self.pickerView = pickerView;
}



- (void)keyValueChangeBlackSetting{
    WEAK_SELF;
    for (XSHouseInfoCellModel *cell in self.subMitServer.thirdArray) {
        for (XSKeyValueModel *valueModel in cell.arrayValue) {
            valueModel.valuechangeStatus = ^(NSString * _Nonnull key, XSBHouseKeyValueEditStatus editStatus) {
                STRONG_SELF;
                if ([key isEqualToString:@"title"] && editStatus == XSBHouseKeyValueEditBegin) {
                    NSLog(@"--------%@-------,发生了%ld",key,(long)editStatus);
                       if (self.subMitServer.imageUrlArray.count > 0) {
                        [self loadAllImage];
                        NSLog(@"-----------开始上传图片");
                    }
                }
            };
        }
    }
}
- (void)loadAllImage{
   
    if ( [self.operationManager.tasks count] > 0) {
        [self.operationManager.tasks makeObjectsPerformSelector:@selector(cancel)];
        NSLog(@"-----------取消所以网络请求");
    }
    NSLog(@"-----------清空存储在本地的服务器地址");
    [self.subMitServer.imageUrlServerArray removeAllObjects];
    WEAK_SELF;
    for (NSURL *url in self.subMitServer.imageUrlArray) {
        [NSThread sleepForTimeInterval:0.25];
        NSLog(@"-----------开始上传");
        [self.subInfoInterface uploadImage:[UIImage imageNamed:@""] imageUrl:url callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
               if (error == nil && responseModel.code.integerValue == SuccessCode) {
                   NSLog(@"-----------上传成功");
                   [self.subMitServer.imageUrlServerArray addObject:responseModel.data];
                   NSLog(@"-----------当前数组：%@",self.subMitServer.imageUrlServerArray);

               }
        }];
    }

}
@end
