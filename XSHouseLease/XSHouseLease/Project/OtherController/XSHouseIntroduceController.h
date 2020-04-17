//
//  XSHouseIntroduceController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSHouseSubMitModel.h"


//键值展示
@interface XSHouseMoreInfoCellMdeol : NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *value;
@property(nonatomic,copy) NSString *cellClass;
@property(nonatomic,strong) NSNumber *cellHeight;
@property (strong, nonatomic) XSHouseKeyValueModuleModel *keyValueModuleModel;
@end


@interface XSHouseIntroduceController : UIViewController
@property (strong, nonatomic) XSHouseInfoShowModel *dataModel;
@property(nonatomic,assign) XSBHouseType houseType;
@property(nonatomic,assign) XSBHouseKeyValueEditStatus infoType;
@end


