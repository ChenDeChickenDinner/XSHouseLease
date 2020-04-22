//
//  XSHouseSubmitFirstViewController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseViewController.h"
#import "XShouseSubNetworkInterface.h"




typedef NS_ENUM(NSInteger,XSHouseSubmitStepsType) {
    XSHouseSubmitStepsType_First= 0,//第一步
    XSHouseSubmitStepsType_Second,
    XSHouseSubmitStepsType_Third,

};

@interface XSHouseSubmitFirstViewController : XSBaseViewController
@property (strong, nonatomic) XSHouseSubMitServer *subMitServer;

@end


