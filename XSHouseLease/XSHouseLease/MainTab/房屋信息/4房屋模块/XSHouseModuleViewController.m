//
//  XSHouseModuleViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseModuleViewController.h"
#import "XSCollectionView.h"

@interface XSHouseModuleViewController ()
@property (nonatomic,strong)XSRegionSearchView *searcView;
@property (strong, nonatomic) XSCollectionView *collectionView;
@property (strong, nonatomic) UIView *lineView;

@end

@implementation XSHouseModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStyleDone target:self action:@selector(callMessage)];
    
    XSRegionSearchView *searcView = [[XSRegionSearchView alloc]init];
    self.searcView = searcView;

    
    XSCollectionView *collectionView = [[XSCollectionView alloc]init];
    collectionView.array = [XSHouseFixedData sharedInstance].renthouseConditionArray;
    self.collectionView = collectionView;

    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = XSColor(246, 243, 245);
    self.lineView = lineView;
    
    self.navigationItem.titleView = searcView;
    [self.view addSubview:collectionView];
    [self.view addSubview:lineView];

}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.searcView.frame = CGRectMake(0, 0, SCREEN_SIZE.width - 110, 40);
    self.collectionView.frame = CGRectMake(0, 0, self.view.width, 230);
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.view.width, 20);

}
- (void)callMessage{
    
}

@end
