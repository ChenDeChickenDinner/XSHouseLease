//
//  XSBaseObject.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/22.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XShouseOperation) {
    XShouseOperation_click = 0,//点击事件
};

typedef NS_ENUM(NSInteger,XSBHouseInfoSource) {
    XSBHouseInfoSource_Search = 0, // 搜索
    XSBHouseInfoSource_MyPublish, // 发布
    XSBHouseInfoSource_MyWatch , // 关注
    XSBHouseInfoSource_MyPush, // 推送，猜你喜欢

};
typedef NS_ENUM(NSInteger,XSBHouseType) {
    XSBHouseType_New = 2, // 新房
    XSBHouseType_old = 1 , // 二手房
    XSBHouseType_Rent = 3  // 出租
};

//1待审核2审核失败3取消发布4下架5暂停6发布(恢复上架)
typedef NS_ENUM(NSInteger,XSBHouseSubStatus) {
    XSBHouseSubStatus_edit = 0, // 编辑
    XSBHouseSubStatus_DSH = 1, //
    XSBHouseSubStatus_SHSB = 2 , //
    XSBHouseSubStatus_QXFB = 3, //
    XSBHouseSubStatus_XJ = 4, //
    XSBHouseSubStatus_ZT = 5, //
    XSBHouseSubStatus_FB = 6 //
};
 // 公共 0未出租1是已出租
typedef NS_ENUM(NSInteger,XSBHouseRentStatus) {
    XSBHouseRentStatus_notrent = 0, // 新房
    XSBHouseRentStatus_rent , // 二手房
};
typedef NS_ENUM(NSInteger,XSBHouseKeyValueEditStatus) {
    XSBHouseKeyValueEdit = 0, // 无状态
    XSBHouseKeyValueEditBegin , // 开始编辑
};
typedef void(^clickEditStatus)(NSNumber *status,NSNumber *houseID);
typedef void(^searchBlack)(NSString *searhKey);
typedef void(^valuechangeStatus)(NSString *key,XSBHouseKeyValueEditStatus editStatus);

@interface XSBaseObject : NSObject

@end

NS_ASSUME_NONNULL_END
