//
//  MyInfoViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/16.
//  Copyright © 2020 fang. All rights reserved.
//

#import "MyInfoViewController.h"
#import "XSLoginViewController.h"

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
    NSLog(@"tag = %ld -------",sender.tag);
}


- (void)refreshUIData{
    self.phoneLable.text = [XSUserServer sharedInstance].userModel.phone;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
