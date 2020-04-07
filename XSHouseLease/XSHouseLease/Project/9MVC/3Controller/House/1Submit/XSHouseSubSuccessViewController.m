//
//  XSHouseSubSuccessViewController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/26.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseSubSuccessViewController.h"

@interface XSHouseSubSuccessViewController ()

@end

@implementation XSHouseSubSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)diss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSObject getTopViewController].navigationController popToRootViewControllerAnimated:YES];
    }];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
