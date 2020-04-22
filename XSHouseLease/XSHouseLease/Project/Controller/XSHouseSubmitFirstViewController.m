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
#import "XSWKWebViewController.h"

@interface XSHouseSubmitFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet XSRoundedBtn1View *nextBtn;
@property(nonatomic,assign) XSHouseSubmitStepsType submitStepsType;
@property (strong, nonatomic) NSMutableArray<XSHouseInfoCellModel *> *array;
@property (assign, nonatomic) BOOL updataimage;
@property (assign, nonatomic) BOOL updataDoorimage;
@property (weak, nonatomic) IBOutlet UIView *agreementView;
@property (weak, nonatomic) IBOutlet UIButton *agreedBtn;

@end

@implementation XSHouseSubmitFirstViewController
- (XSHouseSubMitServer *)subMitServer{
    if (!_subMitServer) {
        _subMitServer = [[XSHouseSubMitServer alloc]init];
    }
    return _subMitServer;
}
- (IBAction)agreementLook:(id)sender {
    XSWKWebViewController *vc = [[XSWKWebViewController alloc]init];
    vc.title = @"房源发布协议";
    vc.url = @"https://test.fangdinghui.cn:1113/pages/agreement/agreement";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)agreementClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.array = [NSMutableArray array];

    if (self.subMitServer.houseType == XSBHouseType_Rent) {
      self.title = @"我要出租";
    }else{
      self.title = @"免费发布房源";
    }

    if (self.submitStepsType == XSHouseSubmitStepsType_First) {
        [self.array addObjectsFromArray:self.subMitServer.firstArray];
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }else if (self.submitStepsType == XSHouseSubmitStepsType_Second){
        [self.agreementView removeFromSuperview];
        [self.array addObjectsFromArray:self.subMitServer.secondArray];
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }else if (self.submitStepsType == XSHouseSubmitStepsType_Third){
        [self.agreementView removeFromSuperview];
        [self.array addObjectsFromArray:self.subMitServer.thirdArray];
        [self.nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    [self cellOperationBlock];
    [self.myTableView reloadData];
}
- (void)cellOperationBlock{
    for (XSHouseInfoCellModel *cellModel in self.array) {
        cellModel.valuechangeStatus = ^(XSHouseInfoCellModel *model,id data,XSBHouseKeyValueEditStatus editStatus) {
            if (editStatus == XSBHouseKeyValueImagesChange) {
                if ([model.title isEqualToString:@"房源图片上传"]) {
                    [self.subMitServer.imageUrlArray removeAllObjects];
                    [self.subMitServer.imageUrlServerArray removeAllObjects];
                    self.updataimage = NO;
                }else{
                    [self.subMitServer.imageDoorUrlArray removeAllObjects];
                    [self.subMitServer.imageDoorUrlServerArray removeAllObjects];
                    self.updataDoorimage = NO;
                }
               }else if (editStatus == XSBHouseKeyValueImagesSend){
                NSURL *imageURL = (NSURL *)data;
                [self.subMitServer.imageUrlArray addObject:imageURL];
            }else if (editStatus == XSBHouseKeyValueImagesDoorSend){
                NSURL *imageURL = (NSURL *)data;
                [self.subMitServer.imageDoorUrlArray addObject:imageURL];
            }else if (editStatus == XSBHouseKeyValueEsSend){
                XSHouseEsModel *es = (XSHouseEsModel *)data;
                [self.subMitServer subRentParameterDictUpdateWithKey:@"es" value:[es mj_keyValues]];
            }else if (editStatus == XSBHouseKeyValueCity){
                NSDictionary *dict = (NSDictionary *)data;
                for (NSString *key in dict.allKeys) {
                    [self.subMitServer subRentParameterDictUpdateWithKey:key value:[dict objectForKey:key]];
                }
            }
            [self.myTableView reloadData];

        };
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (self.subMitServer.imageUrlArray.count > 0 && self.subMitServer.imageUrlServerArray.count <= 0 &&self.updataimage == NO) {
        NSLog(@"-----------loadAllImage1");
        [self loadAllImage];
    }
    
    if (self.subMitServer.imageDoorUrlArray.count > 0 && self.subMitServer.imageDoorUrlServerArray.count <= 0 &&self.updataDoorimage == NO) {
          NSLog(@"-----------loadAllImage2");
          [self loadAllImage2];
      }
}
- (void)loadAllImage{
    self.updataimage = YES;
    [self.subMitServer.imageUrlServerArray removeAllObjects];
    WEAK_SELF;
    for (int i = 0; i<self.subMitServer.imageUrlArray.count; i++) {
        NSURL *url = [self.subMitServer.imageUrlArray safeObjectAtIndex:i];
        [NSThread sleepForTimeInterval:0.25];
        [self.subInfoInterface uploadImage:[UIImage imageNamed:@""] imageUrl:url callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
               if (error == nil && responseModel.code.integerValue == SuccessCode) {
                   [self.subMitServer.imageUrlServerArray addObject:responseModel.data];
               }
            if (i == self.subMitServer.imageUrlArray.count -1) {
                self.updataimage = NO;
                [self.subMitServer subRentParameterDictUpdateWithKey:@"contentImg" value:self.subMitServer.imageUrlServerArray];
                [self.subMitServer subRentParameterDictUpdateWithKey:@"firstImg" value:self.subMitServer.imageUrlServerArray.firstObject];

            }
        }];
    }

}
- (void)loadAllImage2{
    self.updataDoorimage = YES;
    [self.subMitServer.imageDoorUrlServerArray removeAllObjects];
    WEAK_SELF;
    for (int i = 0; i<self.subMitServer.imageDoorUrlArray.count; i++) {
        NSURL *url = [self.subMitServer.imageDoorUrlArray safeObjectAtIndex:i];
        [NSThread sleepForTimeInterval:0.25];
        [self.subInfoInterface uploadImage:[UIImage imageNamed:@""] imageUrl:url callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
               if (error == nil && responseModel.code.integerValue == SuccessCode) {
                   [self.subMitServer.imageDoorUrlServerArray addObject:responseModel.data];
               }
            if (i == self.subMitServer.imageDoorUrlArray.count -1) {
                self.updataDoorimage = NO;
                [self.subMitServer subRentParameterDictUpdateWithKey:@"modelImg" value:self.subMitServer.imageDoorUrlServerArray.firstObject];

            }
        }];
    }

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
    cell.subDict = self.subMitServer.subRentParameterDict;
    [cell refreshData];
    return cell;
}


- (IBAction)nextStepClick:(UIButton *)sender {
    XSHouseSubmitFirstViewController *next = [[XSHouseSubmitFirstViewController alloc]init];
    next.subMitServer = self.subMitServer;
    if (self.submitStepsType == XSHouseSubmitStepsType_First) {
        if (!self.agreedBtn.selected) {
            [ProgressHUD showError:@"请阅读并同意《房源发布协议》" Interaction:YES];
            return;
        }
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
//    return;
    WEAK_SELF;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.subInfoInterface renthouseSaveWithDict:self.subMitServer.subRentParameterDict houseType:self.subMitServer.houseType callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
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
