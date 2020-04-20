//
//  MyInfoViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "MyInfoViewController.h"
#import "XSLoginViewController.h"
#import "XSHouselishViewController.h"
#import "XSHouseModuleViewController.h"

@interface MyInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (strong, nonatomic) XSMyHouseStatistical *dataModel;

@property(nonatomic,weak)IBOutlet UILabel *publishRentNum;
@property(nonatomic,weak)IBOutlet UILabel *publishSecondNum;
@property(nonatomic,weak)IBOutlet UILabel *watchNewNum;
@property(nonatomic,weak)IBOutlet UILabel *watchRentNum;
@property(nonatomic,weak)IBOutlet UILabel *watchSecondNum;
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self observeNotification:NotificationLoginStatusChangedLogin];
    [self observeNotification:NotificationLoginStatusChangedLogout];


    [self loadData];
}
- (void)loadData{
    
    WEAK_SELF;
    [self.subInfoInterface statisticsWithCallback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        if (error == nil) {
            STRONG_SELF;
            if (responseModel.code.integerValue == SuccessCode) {
              self.dataModel =  [XSMyHouseStatistical mj_objectWithKeyValues:responseModel.data];
                self.publishRentNum.text = [NSString stringWithFormat:@"出租(%@)",self.dataModel.publishRentNum];
                self.publishSecondNum.text = [NSString stringWithFormat:@"出售(%@)",self.dataModel.publishSecondNum];
                self.watchNewNum.text = [NSString stringWithFormat:@"新房(%@)",self.dataModel.watchNewNum];
                self.watchRentNum.text = [NSString stringWithFormat:@"租房(%@)",self.dataModel.watchRentNum];
                self.watchSecondNum.text = [NSString stringWithFormat:@"二手房(%@)",self.dataModel.watchSecondNum];
            }
        }
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];

    [self refreshUIData];
    
}
- (IBAction)jumpToSomePlace:(UIButton *)sender {
    if (sender.tag == 6 || sender.tag == 7  || sender.tag == 8 ) {
        
    }else{
        [XSUserServer needLoginSuccess:^{
            NSLog(@"tag = %ld -------",sender.tag);
            XSHouseResourceListViewController *vc = [[XSHouseResourceListViewController alloc]init];

            if (sender.tag == 1) {
                vc.houseType = XSBHouseType_old;
                vc.source = XSBHouseInfoSource_MyWatch;
            }else if (sender.tag == 2){
                XSHouselishViewController *vc = [[XSHouselishViewController alloc]init];
                vc.houseType = XSBHouseType_New;
                vc.source = XSBHouseInfoSource_MyWatch;
                [self.navigationController pushViewController:vc animated:YES];
                return ;
            }else if (sender.tag == 3){
                vc.houseType = XSBHouseType_Rent;
                vc.source = XSBHouseInfoSource_MyWatch;

            }else if (sender.tag == 4){
                vc.houseType = XSBHouseType_old;
                vc.source = XSBHouseInfoSource_MyPublish;
            }else if (sender.tag == 5){
                vc.houseType = XSBHouseType_Rent;
                vc.source = XSBHouseInfoSource_MyPublish;
            }else if (sender.tag == 6){
                
            }else if (sender.tag == 7){
                
            }else if (sender.tag == 8){
                
            }
            [self.navigationController pushViewController:vc animated:YES];

        } cancel:^{
            
        }];

    }

}


- (void)refreshUIData{
    
    if ([XSUserServer sharedInstance].isLogin) {
        self.phoneLable.text = [XSUserServer sharedInstance].userModel.phone;
    }else{
        self.phoneLable.text = @"请登录";
    }
}
- (void)handleNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:NotificationLoginStatusChangedLogin] || [notification.name isEqualToString:NotificationLoginStatusChangedLogout]) {
        
    }
}

- (IBAction)userInfoClick:(id)sender {
      XSLoginViewController *login = [[XSLoginViewController alloc]init];
       login.modalPresentationStyle = UIModalPresentationFullScreen;
       [self presentViewController:login animated:YES completion:^{
           
       }];
}



@end

@implementation XSMyHouseStatistical



@end

