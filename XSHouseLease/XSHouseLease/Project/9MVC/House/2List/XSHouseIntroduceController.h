//
//  XSHouseIntroduceController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSHouseSubMitModel.h"

@interface XSKeyValue : XSHouseInfoCellModel
@property(nonatomic,copy) NSString *key;
@property(nonatomic,copy) NSString *value;
@end



@interface XSHouseIntroduceController : UIViewController
@property (strong, nonatomic) NSMutableArray<XSKeyValue *> *array;
@property (strong, nonatomic) XSHouseInfoShowModel *dataModel;
@property(nonatomic,assign) XSBHouseType houseType;

@end


