//
//  MyInfoViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "MyInfoViewController.h"
#import "XSLoginViewController.h"
#import "XSMyPublishHosueController.h"
#import "XSHouseModuleViewController.h"

@interface MyInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self observeNotification:NotificationLoginStatusChangedLogin];
    [self observeNotification:NotificationLoginStatusChangedLogout];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self refreshUIData];
    
}
- (IBAction)jumpToSomePlace:(UIButton *)sender {
    if (sender.tag == 6 || sender.tag == 7  || sender.tag == 8 ) {
        
    }else{
        [XSUserServer needLoginSuccess:^{
            NSLog(@"tag = %ld -------",sender.tag);
            XSMyPublishHosueController *vc = [[XSMyPublishHosueController alloc]init];

            if (sender.tag == 1) {
                vc.houseType = XSBHouseType_old;
                vc.source = XSBHouseInfoSource_MyWatch;
            }else if (sender.tag == 2){
                vc.houseType = XSBHouseType_New;
                vc.source = XSBHouseInfoSource_MyWatch;
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
