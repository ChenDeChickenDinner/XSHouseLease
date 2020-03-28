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
           [allList hx_requestImageWithOriginal:isOriginal completion:^(NSArray<UIImage *> * _Nullable imageArray, NSArray<HXPhotoModel *> * _Nullable errorArray) {
               
               [self uploadImage:imageArray.firstObject callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
                   if (error == nil) {
                       if (responseModel.code.integerValue == SuccessCode) {
                           [self alertWithMessage:responseModel.message];
                       }
                   }else{
                       [self alertWithMessage:error.domain];
                   }
               }];
                     NSSLog(@"\nimage: %@\nerror: %@",imageArray,errorArray);
                 }];
       };
    self.pickerView = pickerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.myTableView.scrollEnabled = NO;
    if (self.submitType == XSHouseSubmitType_Rent) {
        self.title = @"我要出租";
    }else if (self.submitType == XSHouseSubmitType_Sell){
        self.title = @"免费发布房源";
    }
        
     if (self.submitStepsType == XSHouseSubmitStepsType_First) {
          [self.array addObjectsFromArray:self.firstArray];
         [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
      }else if (self.submitStepsType == XSHouseSubmitStepsType_Second){
//          [self.array addObjectsFromArray:self.secondArray];
          [self loadRentEnums];
          [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];

      }else if (self.submitStepsType == XSHouseSubmitStepsType_Third){
          [self pickerViewInit];
          self.myTableView.tableHeaderView = self.pickerView;
          [self.array addObjectsFromArray:self.thirdArray];
          [self.nextBtn setTitle:@"完成" forState:UIControlStateNormal];
      }
    
    
    [self refreshUIData];
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
    [cell refreshData];
    return cell;
}


- (IBAction)nextStepClick:(UIButton *)sender {
        XSHouseSubmitFirstViewController *next = [[XSHouseSubmitFirstViewController alloc]init];
        if (self.submitStepsType == XSHouseSubmitStepsType_First) {
            next.submitStepsType = XSHouseSubmitStepsType_Second;
            [self.navigationController pushViewController:next animated:YES];
        }else if (self.submitStepsType == XSHouseSubmitStepsType_Second){
            next.submitStepsType = XSHouseSubmitStepsType_Third;
            [self.navigationController pushViewController:next animated:YES];
        }else if (self.submitStepsType == XSHouseSubmitStepsType_Third){
//            [self submitRenthouseSave];
            
            XSHouseSubSuccessViewController *success = [[XSHouseSubSuccessViewController alloc]init];
            success.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:success animated:YES completion:^{

            }];
        }
}


- (void)submitRenthouseSave{
    WEAK_SELF;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *dict= [XSHouseFixedData sharedInstance].subRentParameterDict;
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
