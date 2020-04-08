//
//  XSHouseEnum.h
//  XSHouseLease
//
//  Created by xs on 2020/4/8.
//  Copyright © 2020 fang. All rights reserved.
//

#ifndef XSHouseEnum_h
#define XSHouseEnum_h


typedef NS_ENUM(NSInteger,XSBHouseType) {
    XSBHouseType_New = 2, // 新房
    XSBHouseType_old = 1 , // 二手房
    XSBHouseType_Rent = 3  // 出租
};

// 租房列表类型
typedef NS_ENUM(NSInteger,XSBHouseInfoSource) {
    XSBHouseInfoSource_Search = 0, // 搜索
    XSBHouseInfoSource_MyPublish, // 发布
    XSBHouseInfoSource_MyWatch , // 关注
    XSBHouseInfoSource_MyPush, // 推送，猜你喜欢
};


// 租房出租状态
typedef NS_ENUM(NSInteger,XSBHouseRentStatus) {
    XSBHouseRentStatus_notrent = 0, // 0未出租
    XSBHouseRentStatus_rent , // 1是已出租
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


// 列表点击事件
typedef NS_ENUM(NSInteger, XShouseOperation) {
    XShouseOperation_click = 0,//点击事件
};

// value编辑状态
typedef NS_ENUM(NSInteger,XSBHouseKeyValueEditStatus) {
    XSBHouseKeyValueEdit = 0, // 无状态
    XSBHouseKeyValueEditBegin , // 开始编辑
};

typedef NS_ENUM(NSInteger,XSValueInputType) {
    XSValueInputType_textField = 0,
    XSValueInputType_listSelect,
    XSValueInputType_collectionview,
    XSValueInputType_textView,

};
typedef NS_ENUM(NSInteger,XSValueTextInputType) {
    XSValueTextInputType_Str = 0,
    XSValueTextInputType_Number,
    XSValueTextInputType_phone,

};
typedef NS_ENUM(NSInteger,XSValueSendType) {
    XSValueSendType_Int = 0,
    XSValueSendType_Str,
};




#endif /* XSHouseEnum_h */
