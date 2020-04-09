//
//  XSHouseSubmitFirstViewController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseViewController.h"
#import "XShouseSubNetworkInterface.h"



typedef NS_ENUM(NSInteger,XSHouseSubmitType) {
    XSHouseSubmitType_Rent= 0,//出租
    XSHouseSubmitType_Sell,
};
typedef NS_ENUM(NSInteger,XSHouseSubmitStepsType) {
    XSHouseSubmitStepsType_First= 0,//第一步
    XSHouseSubmitStepsType_Second,
    XSHouseSubmitStepsType_Third,

};

@interface XSHouseSubmitFirstViewController : XSBaseViewController

@property(nonatomic,assign) XSHouseSubmitType submitType;
@property(nonatomic,assign) XSHouseSubmitStepsType submitStepsType;
@property (strong, nonatomic) NSMutableArray<XSHouseInfoCellModel *> *array;
@end


