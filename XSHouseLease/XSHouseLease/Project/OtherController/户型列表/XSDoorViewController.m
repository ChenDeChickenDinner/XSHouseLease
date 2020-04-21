//
//  XSDoorViewController.m
//  XSHouseLease
//
//  Created by xs on 2020/4/15.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSDoorViewController.h"
#import "XSDoorTableViewCell.h"
#import "XSDoorCollectionViewCell.h"

@interface XSDoorListViewController : XSListContentViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSArray<XSHouseDetailsDataFormsModel *> *array;
@property (nonatomic, strong) UITableView *listTableView;
@property (strong, nonatomic) UICollectionView *collectionView ;
@property (nonatomic, assign)BOOL simple;

@end

@implementation XSDoorListViewController

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
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(205, 200);
    layout.minimumInteritemSpacing = 30;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.pagingEnabled = NO;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[XSDoorCollectionViewCell class] forCellWithReuseIdentifier:XSHouseDetailsBusinessInfoCellStr];
    [self.collectionView registerNib: [UINib nibWithNibName:NSStringFromClass([XSDoorCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"XSDoorCollectionViewCell"];
    
    if (self.simple) {
         [self.view addSubview:self.collectionView];
     }

    [self.collectionView reloadData];
    [self.listTableView reloadData];

}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.listTableView.frame = self.view.bounds;
    self.collectionView.frame = self.view.bounds;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XSHouseDetailsDataFormsModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    static NSString *ID = @"XSDoorTableViewCell";
    XSDoorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"XSDoorTableViewCell" owner:self options:nil].firstObject;
    }
    cell.dataModel = dataModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XSHouseDetailsDataFormsModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    XSDoorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XSDoorCollectionViewCell" forIndexPath:indexPath];
    cell.dataModel = dataModel;
    return cell;
}

@end

@interface XSDoorViewController ()
@property (nonatomic, copy) NSArray<NSArray *> *allArray;

@end

@implementation XSDoorViewController
- (void)setForms:(NSArray<XSHouseDetailsDataFormsModel *> *)forms{
    _forms = forms;
    

    NSMutableArray *mutableOriginalArray = [self.forms mutableCopy]; //深拷贝

    NSMutableArray *newArray = [NSMutableArray array];
    [newArray addObject:[self.forms mutableCopy]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
      for (XSHouseDetailsDataFormsModel *newModel  in forms) {
          id value = [dict objectForKey:newModel.formTypeRoom.stringValue];
          if (value == nil) {
              NSMutableArray *array = [NSMutableArray array];
              for (XSHouseDetailsDataFormsModel *copyModel in mutableOriginalArray) {
                  if (copyModel.formTypeRoom.integerValue == newModel.formTypeRoom.integerValue) {
                      [array addObject:copyModel];
                  }
              }
              if (array.count > 0) {
                  [newArray addObject:array];
              }
              [dict setValue:@(1) forKey:newModel.formTypeRoom.stringValue];
          }
    
      }



    
    self.allArray = newArray;
}
- ( NSArray<NSString *>*)getTitlese{

    NSMutableArray *titleArray = [NSMutableArray array];
    for (int i = 0; i< self.allArray.count; i++) {
        NSArray *array = [self.allArray safeObjectAtIndex:i];
        XSHouseDetailsDataFormsModel *model = array.firstObject;
        NSString *str = nil;
        if (i==0) {
            str = [NSString stringWithFormat:@"全部(%ld)",array.count];
        }else{
            str = [NSString stringWithFormat:@"%@居(%ld)",model.formTypeRoom,array.count];
        }
        [titleArray addObject:str];
    }

    return titleArray;
}
- (NSArray<id<JXCategoryListContentViewDelegate>>*)getListVc{
    NSMutableArray *vcArray = [NSMutableArray array];
    for (NSArray *array in self.allArray) {
        XSDoorListViewController *vc  = [[XSDoorListViewController alloc]init];
        vc.simple = self.simple;
        vc.array = array;
        [vcArray addObject:vc];
    }
    return vcArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"楼盘动态列表";
}
- (void)loadData{
//    [self.collectionView reloadData];
}
@end
