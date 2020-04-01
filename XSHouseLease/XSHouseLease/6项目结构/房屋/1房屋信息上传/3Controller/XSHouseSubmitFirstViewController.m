//
//  XSHouseSubmitFirstViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubmitFirstViewController.h"
#import "XSHouseSubTableViewCell.h"
#import "XSHouseSubTextViewCell.h"
#import "XSHouseSubCollectionviewBCell.h"
#import "XSHouseSubCollectionviewACell.h"
#import "XSHouseSubTextFieldTableViewCell.h"
#import "XSHouseSubListChooseTableViewCell.h"
#import "XSPhotoPickerView.h"
#import "XSHouseSubSuccessViewController.h"
#import "XSHouseSubFootView.h"
#import "AFNetworking.h"

@interface XSHouseSubmitFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet XSRoundedBtn1View *nextBtn;

@property (strong, nonatomic)  XSPhotoPickerView *pickerView;


@end

@implementation XSHouseSubmitFirstViewController

- (void)pickerViewInit{
    WEAK_SELF;
    XSPhotoPickerView *pickerView = [[XSPhotoPickerView alloc]initWithFrame:CGRectMake(0, 0, self.myTableView.width, 280)];
     pickerView.changeCompleteBlock = ^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photos, NSArray<HXPhotoModel *> *videos, BOOL isOriginal) {
         STRONG_SELF;
         [self.imageUrlArray removeAllObjects];
         for (HXPhotoModel *photoModel in photos) {
             [photoModel requestImageURLStartRequestICloud:nil progressHandler:nil success:^(NSURL * _Nullable imageURL, HXPhotoModel * _Nullable model, NSDictionary * _Nullable info) {
                 NSSLog(@"imageURL: %@\n",imageURL );
                 [self.imageUrlArray addObject:imageURL];
             } failed:^(NSDictionary * _Nullable info, HXPhotoModel * _Nullable model) {
                 
             }];
         }

       };
    self.pickerView = pickerView;
}

- (void)loadAllImage{
   
    if ( [self.operationManager.tasks count] > 0) {
        [self.operationManager.tasks makeObjectsPerformSelector:@selector(cancel)];
        NSLog(@"-----------取消所以网络请求");
    }
    NSLog(@"-----------清空存储在本地的服务器地址");
    [self.imageUrlServerArray removeAllObjects];
    WEAK_SELF;
    for (NSURL *url in self.imageUrlArray) {
        [NSThread sleepForTimeInterval:0.25];
        NSLog(@"-----------开始上传");
        [self.subInfoInterface uploadImage:[UIImage imageNamed:@""] imageUrl:url callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
            STRONG_SELF;
               if (error == nil && responseModel.code.integerValue == SuccessCode) {
                   NSLog(@"-----------上传成功");
                   [self.imageUrlServerArray addObject:responseModel.data];
                   NSLog(@"-----------当前数组：%@",self.imageUrlServerArray);

//                   [self saveImageUrl:responseModel.data];
               }
        }];
    }

}
- (void)saveImageUrl:(NSString *)iamgeUrl{
//    NSMutableArray *newArray = [NSMutableArray array];
//    NSArray *oldArray = [[XSHouseFixedData sharedInstance].subRentParameterDict safeObjectForKey:@"contentImg"];
//    [newArray addObjectsFromArray:[oldArray copy]];
//    if (oldArray.count) {
//        for (NSString *url in oldArray) {
//            if (![iamgeUrl isEqualToString:url]) {
//                [newArray addObject:iamgeUrl];
//            }
//        }
//    }else{
//        [newArray addObject:iamgeUrl];
//    }

}

- (void)AutomaticAssignment:(NSArray *)array{
    for (XSHouseInfoCellModel *cell in array) {
        for (XSKeyValueModel *valueModel in cell.arrayValue) {
            for (XSValue *model in valueModel.values) {
                model.value = model.value;
                model.valueStr = model.valueStr;
            }
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.submitType == XSHouseSubmitType_Rent) {
        self.title = @"我要出租";
    }else if (self.submitType == XSHouseSubmitType_Sell){
        self.title = @"免费发布房源";
    }
        
 
    
     if (self.submitStepsType == XSHouseSubmitStepsType_First) {
         XSHouseSubFootView *tableFooterView = [XSHouseSubFootView houseSubFootView];
          tableFooterView.frame = CGRectMake(0, 0, self.myTableView.width, 160);
          self.myTableView.tableFooterView = tableFooterView;
          [self.array addObjectsFromArray:self.firstArray];
         [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
            [self AutomaticAssignment:self.firstArray];
      }else if (self.submitStepsType == XSHouseSubmitStepsType_Second){
               [self loadRentEnumsCallback:nil arrayBlack:^(NSArray *newArray) {
                    [self.array removeAllObjects];
                    [self.secondArray addObjectsFromArray:newArray];
                    [self.array addObjectsFromArray:self.secondArray];
                      if (self.renhousetInfoModel) {
                       NSDictionary *dict = [self.renhousetInfoModel mj_keyValues];
                       [self keyValueUpdatekWitOldhDict:dict array:self.array];
                   }
                    [self refreshUIData];
               }];
          [self.array addObjectsFromArray:self.secondArray];

          [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
          [self AutomaticAssignment:self.secondArray];


      }else if (self.submitStepsType == XSHouseSubmitStepsType_Third){
          [self pickerViewInit];
          self.myTableView.tableHeaderView = self.pickerView;
          [self.array addObjectsFromArray:self.thirdArray];
          [self.nextBtn setTitle:@"完成" forState:UIControlStateNormal];
          [self AutomaticAssignment:self.thirdArray];

      }
    if (self.renhousetInfoModel) {
     NSDictionary *dict = [self.renhousetInfoModel mj_keyValues];
     [self keyValueUpdatekWitOldhDict:dict array:self.array];
     [self refreshUIData];
 }
    [self keyValueChangeBlackSetting];
    
    [self refreshUIData];
}
- (void)keyValueChangeBlackSetting{
    WEAK_SELF;
    for (XSHouseInfoCellModel *cell in self.thirdArray) {
        for (XSKeyValueModel *valueModel in cell.arrayValue) {
            valueModel.valuechangeStatus = ^(NSString * _Nonnull key, XSBHouseKeyValueEditStatus editStatus) {
                STRONG_SELF;
                if ([key isEqualToString:@"title"] && editStatus == XSBHouseKeyValueEditBegin) {
                    NSLog(@"--------%@-------,发生了%ld",key,(long)editStatus);
                       if (self.imageUrlArray.count > 0) {
                        [self loadAllImage];
                        NSLog(@"-----------开始上传图片");
                    }
                }
            };
        }
    }
}
- (void)refreshUIData{
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
    [cell refreshData];
    return cell;
}


- (IBAction)nextStepClick:(UIButton *)sender {
        XSHouseSubmitFirstViewController *next = [[XSHouseSubmitFirstViewController alloc]init];
       next.renhousetInfoModel = self.renhousetInfoModel;
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

    [[XSHouseFixedData sharedInstance].subRentParameterDict safeSetObject:[self.imageUrlServerArray mutableCopy] forKey:@"contentImg"];
    [[XSHouseFixedData sharedInstance].subRentParameterDict safeSetObject:[self.imageUrlServerArray.firstObject copy] forKey:@"firstImg"];
    NSLog(@"subRentParameterDict = %@", [XSHouseFixedData sharedInstance].subRentParameterDict);
//    return;
    WEAK_SELF;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *dict= [XSHouseFixedData sharedInstance].subRentParameterDict;
    [self.subInfoInterface renthouseSaveWithDict:dict callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        [MBProgressHUD  hideHUDForView:self.view animated:YES];
        if (error == nil) {
            if (responseModel.code.integerValue == SuccessCode) {
                   XSHouseSubSuccessViewController *success = [[XSHouseSubSuccessViewController alloc]init];
                    success.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:success animated:YES completion:^{
                     
                    }];
            }else{
                [self alertWithMessage:responseModel.message];
            }
        }else{
           [self alertWithMessage:error.domain];
        }
    }];
}

















- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    return CGSizeMake(20, 20);
//}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    return YES;
}

- (void)updateFocusIfNeeded {
    
}

@end
