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
#import "XSHouseInfoShowModel.h"
#import "XSMyPublishHosueController.h"
#import "XSHouseDetailsController.h"
#import "XSMyPublishHosueController.h"

@class XSItemCollectionViewCell;
@interface XSHouseModuleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)XSRegionSearchView *searcView;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) XSMyPublishHosueController *listVc;

@property (strong, nonatomic) NSMutableArray<XSHouseModuleModel *> *array;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) UICollectionView *collectionView;


@end

@implementation XSHouseModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    XSRegionSearchView *searcView = [[XSRegionSearchView alloc]init];
    searcView.searchBlack = ^(NSString *searhKey) {
        
    };
    self.searcView = searcView;
    self.navigationItem.titleView = searcView;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(KScreenWidth/4, 105);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[XSItemCollectionViewCell class] forCellWithReuseIdentifier:XSItemCollectionViewCellStr];
    self.collectionView = collectionView;
    

    UIView *lineView = [[NSBundle mainBundle] loadNibNamed:@"XSSearchConditionalView" owner:self options:nil].lastObject;
     lineView.backgroundColor = XSColor(246, 243, 245);
     self.lineView = lineView;
 
    XSMyPublishHosueController *listVc = [[XSMyPublishHosueController alloc]init];
    listVc.houseType = self.houseType;
    listVc.source = self.source;
    self.listVc = listVc;

    
    [self.view addSubview:collectionView];
    [self.view addSubview:lineView];
    [self.view addSubview:listVc.view];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStyleDone target:self action:@selector(callMessage)];
    
    if (self.houseType == XSBHouseType_New) {
        self.array =  [XSPublicServer sharedInstance].newhouseConditionArray;
    }else if (self.houseType == XSBHouseType_Rent){
        self.array =  [XSPublicServer sharedInstance].renthouseConditionArray;
    }
    [self.collectionView reloadData];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.searcView.frame = CGRectMake(0, 0, SCREEN_SIZE.width - 110, 35);
    self.collectionView.frame = CGRectMake(0, 0, self.view.width, self.houseType==XSBHouseType_Rent?210:105);
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.view.width, 65);
    self.listVc.view.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), self.view.width, self.view.height- CGRectGetMaxY(self.lineView.frame));
 
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XSHouseModuleModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    XSItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XSItemCollectionViewCellStr forIndexPath:indexPath];
    cell.model = dataModel;
    return cell;
}

// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XSHouseModuleModel *dataModel = [self.array safeObjectAtIndex:indexPath.row];
    NSMutableDictionary *dict =  [NSMutableDictionary dictionary];
    [dict setValue:dataModel.value forKey:dataModel.key];
    XSMyPublishHosueController *vc = [[XSMyPublishHosueController alloc]init];
    vc.title = dataModel.name;
    vc.source = self.source;
    vc.houseType = self.houseType;
    vc.searchDict = dict;
    [self .navigationController pushViewController:vc animated:YES];
}



- (void)callMessage{
    
}

@end





@implementation XSItemCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        self.myImageView = imageView;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor hb_colorWithHexString:@"#171717" alpha:1];
         [self.contentView addSubview:label];
         self.titleLable = label;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.myImageView.frame = CGRectMake(0, 0, self.width, self.height - 10);
    self.titleLable.frame = CGRectMake(0, self.height - 18, self.width, 18);
}
- (void)setModel:(XSHouseModuleModel *)model{
    _model = model;
    if (model.iconName) {
        self.myImageView.image = [UIImage imageNamed:model.iconName];
    }else{
        [self.myImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    }
    self.titleLable.text = model.name;
}
@end