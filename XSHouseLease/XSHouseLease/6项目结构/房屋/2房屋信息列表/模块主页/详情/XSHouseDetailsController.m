//
//  XSHouseDetailsController.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseDetailsController.h"
#import "XSHouseRentInfoModel.h"

@interface XSHouseDetailsController ()



@end

@implementation XSHouseDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self gethouseDetails];
    
   
}

- (void)gethouseDetails{
    [self.subInfoInterface renthouseDetailsWithHouse_id:self.houseid callback:^(XSNetworkResponse * _Nullable responseModel, NSError * _Nullable error) {
        if (error == nil) {
            if (responseModel.code.integerValue == SuccessCode) {
                XSHouseRentInfoModel *model = [XSHouseRentInfoModel mj_objectWithKeyValues:responseModel.data];
                NSLog(@"房屋详情 = %@",[model mj_keyValues]);
            }
        }
        
    }];
}

@end
