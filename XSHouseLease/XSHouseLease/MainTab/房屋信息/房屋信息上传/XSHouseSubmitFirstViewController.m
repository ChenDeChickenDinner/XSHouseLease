//
//  XSHouseSubmitFirstViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubmitFirstViewController.h"
#import "XSHouseInfoModel.h"
#import "XSHouseSubTableViewCell.h"
#import "XSHouseSubTextViewCell.h"
#import "XSHouseSubCollectionviewBCell.h"
#import "XSHouseSubCollectionviewACell.h"
#import "XSHouseSubTextFieldTableViewCell.h"
#import "XSHouseSubListChooseTableViewCell.h"

@interface XSHouseSubmitFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray<XSHouseInfoCellModel *> *array;
@end

@implementation XSHouseSubmitFirstViewController
- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.scrollEnabled = NO;
    if (self.submitType == XSHouseSubmitType_Rent) {
        self.title = @"我要出租";
    }else if (self.submitType == XSHouseSubmitType_Sell){
        self.title = @"免费发布房源";
    }
        
     if (self.submitStepsType == XSHouseSubmitStepsType_First) {
          
      }else if (self.submitStepsType == XSHouseSubmitStepsType_Second){
          
      }else if (self.submitStepsType == XSHouseSubmitStepsType_Third){
          
      }
    
    
    NSError *error;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"XSHouseInfo" ofType:@"json"];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingMutableLeaves error:&error];
    NSArray *modelArray = [XSHouseInfoCellModel mj_objectArrayWithKeyValuesArray:dataArray];
    [self.array addObjectsFromArray:modelArray];
    
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
