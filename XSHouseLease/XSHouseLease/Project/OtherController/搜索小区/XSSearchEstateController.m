//
//  XSSearchEstateController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/4/12.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSSearchEstateController.h"
#import "XShouseSubNetworkInterface.h"

@interface XSSearchEstateController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XSRegionSearchView *searcView;
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) NSMutableDictionary *dict;

@end

@implementation XSSearchEstateController
- (void)setCityModel:(BRProvinceModel *)cityModel{
    _cityModel = cityModel;
    [self.dict safeSetObject:cityModel.name forKey:@"city"];
    [self.dict safeSetObject:cityModel.code forKey:@"cityId"];
}
- (NSMutableDictionary *)dict{
    if (!_dict) {
        _dict = [NSMutableDictionary dictionary];
        [_dict safeSetObject:_cityModel.name forKey:@"city"];
        [_dict safeSetObject:_cityModel.code forKey:@"cityId"];

    }
    return _dict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray array];
    WEAK_SELF;
    XSRegionSearchView *searcView = [[XSRegionSearchView alloc]init];
    searcView.search = YES;
    searcView.searchBlack = ^(NSString *searhKey) {
        STRONG_SELF;
        if (searhKey.length > 0) {
            [self loadDataWithkeywords:searhKey];
        }
    };
    self.searcView = searcView;
    self.navigationItem.titleView = searcView;
    UITableView *tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(diss)];
    
    [self.view addSubview:tableView];
    [self.tableView reloadData];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.searcView.frame = CGRectMake(0, 0, SCREEN_SIZE.width - 90, 35);
    self.tableView.frame = self.view.bounds;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.searcView beganEditing];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)loadDataWithkeywords:(NSString *)keywords{
    self.dict = nil;
    [self.dict safeSetObject:keywords forKey:@"keywords"];
    [self.subInfoInterface searchEstateWithDict:self.dict callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        if (error == nil && responseModel.code.integerValue == SuccessCode) {
            [self.array removeAllObjects];
            NSMutableArray *array = [XSHouseEsModel mj_objectArrayWithKeyValuesArray:responseModel.data];
            [self.array addObjectsFromArray:array];
            [self.tableView reloadData];
        }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.0;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    XSHouseEsModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    static NSString *ID = @"XSHouseEsModel";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.text = dataModel.name;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XSHouseEsModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    if (self.searchBlock) {
        self.searchBlock(dataModel);
        [self.navigationController popViewControllerAnimated:YES];
     }
    
    return;
    WEAK_SELF;
    [self dismissViewControllerAnimated:YES completion:^{
        STRONG_SELF;
        if (self.searchBlock) {
            self.searchBlock(dataModel);
        }
    }];

}
- (void)diss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
