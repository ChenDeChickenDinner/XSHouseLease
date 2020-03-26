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
@property (weak, nonatomic) XSCollectionView *collectionView;

@end

@implementation XSHouseModuleViewController
- (XSRegionSearchView *)searcView{
    if (_searcView == nil) {
        _searcView = [[XSRegionSearchView alloc]init];
        _searcView.frame = CGRectMake(0, 0, SCREEN_SIZE.width - 110, 40);
    }
    return _searcView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = self.searcView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"message"] style:UIBarButtonItemStyleDone target:self action:@selector(callMessage)];
    
     XSCollectionView *collectionView = [[XSCollectionView alloc]init];
      collectionView.array = [XSHouseFixedData sharedInstance].renthouseConditionArray;
      [self.view addSubview:collectionView];
      self.collectionView = collectionView;
    

}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.view.width, 210);

}
- (void)callMessage{
    
}

@end
