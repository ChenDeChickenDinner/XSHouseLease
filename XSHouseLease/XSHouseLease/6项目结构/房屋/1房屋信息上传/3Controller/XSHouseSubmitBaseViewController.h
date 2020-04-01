//
//  XSHouseSubmitBaseViewController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/23.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseViewController.h"
#import "XSHouseSubAllMode.h"
#import "XShouseSubNetworkInterface.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,XSHouseSubmitType) {
    XSHouseSubmitType_Rent= 0,//出租
    XSHouseSubmitType_Sell,
};
typedef NS_ENUM(NSInteger,XSHouseSubmitStepsType) {
    XSHouseSubmitStepsType_First= 0,//第一步
    XSHouseSubmitStepsType_Second,
    XSHouseSubmitStepsType_Third,

};
@interface XSHouseSubmitBaseViewController : XSBaseViewController
@property(nonatomic,assign) XSHouseSubmitType submitType;
@property(nonatomic,assign) XSHouseSubmitStepsType submitStepsType;
@property (strong, nonatomic) NSMutableArray<XSHouseInfoCellModel *> *firstArray;
@property (strong, nonatomic) NSMutableArray<XSHouseInfoCellModel *> *secondArray;
@property (strong, nonatomic) NSMutableArray<XSHouseInfoCellModel *> *thirdArray;
@property (strong, nonatomic) NSMutableArray<XSHouseInfoCellModel *> *array;

@property (strong, nonatomic) XSHouseRentInfoModel *renhousetInfoModel;
- (void)loadRentEnumsCallback:(HBCompletionBlock)callback arrayBlack:(void (^)(NSArray *newArray))arrayBlack;
- (void)keyValueUpdatekWitOldhDict:(NSDictionary *)dict  array:(NSArray<XSHouseInfoCellModel *> *)array;
@end

NS_ASSUME_NONNULL_END
