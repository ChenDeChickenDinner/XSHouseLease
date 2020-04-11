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
    collectionView.array = [XSPublicServer sharedInstance].renthouseConditionArray;
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
    self.tableView = tableView;

    
    self.navigationItem.titleView = searcView;
//    [self.view addSubview:collectionView];
//    [self.view addSubview:lineView];
    [self.view addSubview:tableView];

    
    // 1.根据当前城市推荐
    [self searchRentHouse];


}




- (void)searchRentHouse{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict safeSetObject:[XSUserServer sharedInstance].cityModel.code forKey:@"cityId"];
    WEAK_SELF;
    [self.subInfoInterface searchRenthousListWithKeyVales:dict per_page:10 page_index:0 callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        STRONG_SELF;
        if (error == nil) {
            if (responseModel.code.intValue == SuccessCode) {
                NSArray *array = [XSHouseInfoShowModel mj_objectArrayWithKeyValuesArray:responseModel.data];
                [self houseInfoClickSettingWithModelArray:array];
//                self.tableView.array = array;
                [self.tableView reloadData];
            }
        }else{
            
        }
    }];
}
- (void)houseInfoClickSettingWithModelArray:(NSArray *)array{
    for (XSHouseInfoShowModel *model in array) {
        model.source = XSBHouseInfoSource_Search;
        model.clickBlack = ^(XSHouseInfoShowModel * _Nonnull model, XShouseOperation operation) {
                XSHouseDetailsController *vc = [[XSHouseDetailsController alloc]init];
                vc.houseid = model.house_id.stringValue;
                [self.navigationController pushViewController:vc animated:YES];
        };

    }
}

- (void)callMessage{
    
}

@end





@implementation XSItemCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加自己需要个子视图控件
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        self.myImageView = imageView;

        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
//        label.layer.masksToBounds = YES;;
//        label.layer.cornerRadius = 5;
//        label.layer.borderWidth = 0.5;
        label.textColor = [UIColor hb_colorWithHexString:@"#171717" alpha:1];
         [self.contentView addSubview:label];
         self.titleLable = label;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor orangeColor];
    
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
