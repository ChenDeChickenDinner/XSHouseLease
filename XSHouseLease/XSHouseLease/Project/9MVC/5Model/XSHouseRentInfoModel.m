//
//  XSHouseRentInfoModel.m
//  房鼎汇
//
//  Created by indulgeIn on 2020/03/27.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "XSHouseRentInfoModel.h"
#import "XSHouseSubCollectionviewBCell.h"







@implementation XSBHouseInfoModel
@end


@implementation XSHouseRentInfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"house_id":@"id"};
}
- (instancetype)init{
    self  =[super init];
    if (self) {
        self.cellClass = @"XSHouseRentInfoCell";
    }
    return self;
}
@end



@implementation XSHouseDetailsInfoCellModel

@end




