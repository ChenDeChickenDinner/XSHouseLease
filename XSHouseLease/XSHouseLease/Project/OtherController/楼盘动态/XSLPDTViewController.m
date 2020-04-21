//
//  XSLPDTViewController.m
//  XSHouseLease
//
//  Created by xs on 2020/4/15.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSLPDTViewController.h"
#import "XSLPDTTableViewCell.h"

@interface XSLPDTListViewController : XSListContentViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray<XSHouseDetailsDataDynamicsModel *> *array;
@property (nonatomic, strong) UITableView *listTableView;
@end

@implementation XSLPDTListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *listTableView = [[UITableView alloc]init];
    listTableView.backgroundColor = [UIColor clearColor];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    listTableView.rowHeight = UITableViewAutomaticDimension;
    listTableView.estimatedRowHeight = 100;
    listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listTableView = listTableView;
    [self.view addSubview:listTableView];
    [self.listTableView reloadData];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.listTableView.frame = self.view.bounds;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XSHouseDetailsDataDynamicsModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    static NSString *ID = @"XSLPDTTableViewCell";
    XSLPDTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"XSLPDTTableViewCell" owner:self options:nil].firstObject;
    }
    cell.dataModel = dataModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end


@interface XSLPDTViewController ()

@end

@implementation XSLPDTViewController
- ( NSArray<NSString *>*)getTitlese{
    NSMutableArray<XSHouseDetailsDataDynamicsModel *> *array = [NSMutableArray array];
    for (XSHouseDetailsDataDynamicsModel *model in self.dynamics) {
        if (model.contentType.intValue == 1) {
            [array addObject:model];
        }
    }
   NSString *str1 =  [NSString stringWithFormat:@"全部动态(%ld)",self.dynamics.count];
   NSString *str2 =  [NSString stringWithFormat:@"销控信息(%ld)",array.count];
    return @[str1,str2];
}
- (NSArray<id<JXCategoryListContentViewDelegate>>*)getListVc{
    XSLPDTListViewController *vc1  = [[XSLPDTListViewController alloc]init];
    vc1.array = self.dynamics;
    
    XSLPDTListViewController *vc2  = [[XSLPDTListViewController alloc]init];
    NSMutableArray<XSHouseDetailsDataDynamicsModel *> *array = [NSMutableArray array];
    for (XSHouseDetailsDataDynamicsModel *model in self.dynamics) {
        if (model.contentType.intValue == 1) {
            [array addObject:model];
        }
    }
    vc2.array = array;

    return @[vc1,vc2];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"楼盘动态列表";

}

@end


