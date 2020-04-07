//
//  XSHouseModuleViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseModuleViewController.h"
#import "XSCollectionView.h"
#import "XSHouseInfoTableView.h"
#import "XSHouseRentInfoModel.h"
#import "XSMyPublishHosueController.h"
#import "XSHouseDetailsController.h"


@interface XSHouseModuleViewController ()
@property (nonatomic,strong)XSRegionSearchView *searcView;
@property (strong, nonatomic) XSCollectionView *collectionView;
@property (strong, nonatomic) UIView *lineView;
@property (nonatomic,strong) XSHouseInfoTableView *tableView;
@end

@implementation XSHouseModuleViewController
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.searcView.frame = CGRectMake(0, 0, SCREEN_SIZE.width - 110, 35);
//    self.collectionView.frame = CGRectMake(0, 0, self.view.width, 230);
//    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.view.width, 65);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), self.view.width, self.view.height- CGRectGetMaxY(self.lineView.frame));
//    self.searchConditionalview.frame = CGRectMake(0, 25, self.view.width, 40);
 
}
- (void)viewDidLoad {
    [super viewDidLoad];


    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStyleDone target:self action:@selector(callMessage)];
    
    XSRegionSearchView *searcView = [[XSRegionSearchView alloc]init];
    searcView.searchBlack = ^(NSString *searhKey) {
        
    };
    self.searcView = searcView;

    
    XSCollectionView *collectionView = [[XSCollectionView alloc]init];
    collectionView.frame = CGRectMake(0, 0, 0, 230);
    collectionView.array = [XSHouseFixedData sharedInstance].renthouseConditionArray;
    self.collectionView = collectionView;

    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = XSColor(246, 243, 245);
    
//    XSSearchConditionalView *searchConditionalview = [self addSearchConditionalView];
//    self.searchConditionalview = searchConditionalview;
//    [lineView addSubview:searchConditionalview];
//
    self.lineView = lineView;
    
    XSHouseInfoTableView *tableView = [[XSHouseInfoTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.tableHeaderView = collectionView;
    tableView.heardSearchView = YES;
    self.tableView = tableView;

    
    self.navigationItem.titleView = searcView;
//    [self.view addSubview:collectionView];
//    [self.view addSubview:lineView];
    [self.view addSubview:tableView];

    
    // 1.根据当前城市推荐
    [self searchRentHouse];
    // 2.获取t配置的搜索key
    [self renthouseConditionWithCallback];

}

-(void)renthouseConditionWithCallback{
    
    WEAK_SELF;
    [self.subInfoInterface renthouseConditionWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        if (error == nil && responseModel.code.integerValue == SuccessCode) {
            NSMutableArray *modelArray = [XSHouseModuleModel mj_objectArrayWithKeyValuesArray:responseModel.data];
            for (XSHouseModuleModel *model in modelArray) {
                model.clickBlack = ^(XSHouseModuleModel * _Nonnull model) {
                    
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    [dict safeSetObject:[XSUserServer sharedInstance].cityModel.code forKey:@"cityId"];
                    [dict safeSetObject:model.value forKey:model.key];
                    XSMyPublishHosueController *vc = [[XSMyPublishHosueController alloc]init];
                    vc.title = model.name;
                    vc.source = XSBHouseInfoSource_Search;
                    vc.houseType = XSBHouseType_Rent;
                    vc.searchDict = dict;
                    [self.navigationController pushViewController:vc animated:YES];
                };
            }
             self.collectionView.array = modelArray;
        }
//        [XSHouseFixedData sharedInstance].renthouseConditionArray = modelArray;
    }];
}


- (void)searchRentHouse{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict safeSetObject:[XSUserServer sharedInstance].cityModel.code forKey:@"cityId"];
    WEAK_SELF;
    [self.subInfoInterface searchRenthousListWithKeyVales:dict per_page:10 page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        if (error == nil) {
            if (responseModel.code.intValue == SuccessCode) {
                NSArray *array = [XSHouseRentInfoModel mj_objectArrayWithKeyValuesArray:responseModel.data];
                [self houseInfoClickSettingWithModelArray:array];
                self.tableView.array = array;
                [self.tableView reloadData];
            }
        }else{
            
        }
    }];
}
- (void)houseInfoClickSettingWithModelArray:(NSArray *)array{
    for (XSHouseRentInfoModel *model in array) {
        model.source = XSBHouseInfoSource_Search;
        model.clickBlack = ^(XSBHouseInfoModel * _Nonnull model, XShouseOperation operation) {
            if ([model isKindOfClass:[XSHouseRentInfoModel class]]) {
                XSHouseRentInfoModel *newModel = (XSHouseRentInfoModel *)model;
                NSLog(@"house_id = %@",newModel.house_id);
                XSHouseDetailsController *vc = [[XSHouseDetailsController alloc]init];
                 vc.houseid = newModel.house_id.stringValue;
                 [self.navigationController pushViewController:vc animated:YES];
            }
        };

    }
}

- (void)callMessage{
    
}

@end


