////
////  XSImagesViewController.m
////  XSHouseLease
////
////  Created by xs on 2020/4/16.
////  Copyright © 2020 fang. All rights reserved.
////
//
//#import "XSImagesViewController.h"
//#import "XSImagesTableViewCell.h"
//
//@interface XSImageListViewController :XSListContentViewController<UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic, copy) NSArray<XSHouseDetailsDataImgsModel *> *array;
//@property (nonatomic, strong) UITableView *listTableView;
//@end
//
//@implementation XSImageListViewController
//- (void)viewDidLoad {
//   [super viewDidLoad];
//
//   UITableView *listTableView = [[UITableView alloc]init];
//   listTableView.delegate = self;
//   listTableView.dataSource = self;
//   listTableView.rowHeight = UITableViewAutomaticDimension;
//   listTableView.estimatedRowHeight = 100;
//   listTableView.backgroundColor = XSColor(246, 246, 246);
//   listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//   self.listTableView = listTableView;
//
//    [self.view addSubview:listTableView];
//
//    [self.listTableView reloadData];
//
//}
//- (void)viewWillLayoutSubviews{
//    [super viewWillLayoutSubviews];
//    self.listTableView.frame = self.view.bounds;
//
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.array.count;
//}
//
//- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    XSHouseDetailsDataImgsModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
//    static NSString *ID = @"XSImagesTableViewCell";
//    XSImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[NSBundle mainBundle] loadNibNamed:@"XSImagesTableViewCell" owner:self options:nil].firstObject;
//    }
//    cell.dataModel = dataModel;
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//}
//@end
//@interface XSImagesViewController ()
//
//@end
//
//@implementation XSImagesViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//
//}
//
//
//
//
//@end
