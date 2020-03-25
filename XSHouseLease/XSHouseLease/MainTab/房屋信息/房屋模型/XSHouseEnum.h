//
//  XSHouseEnum.h
//  房鼎汇
//
//  Created by indulgeIn on 2020/03/23.
//  Copyright © 2020 indulgeIn. All rights reserved.
//

#import "XSBaseObject.h"

NS_ASSUME_NONNULL_BEGIN


@interface XSHouseEnumDataEnumRes : XSBaseObject

//value值
@property (nonatomic, strong) NSNumber *value;

//value描述
@property (nonatomic, copy) NSString *name;
@end


@interface XSHouseEnumData : XSBaseObject

//选项值
@property (nonatomic, copy) NSString *key;
//选项描述
@property (nonatomic, copy) NSString *name;

//选项顺序位置
@property (nonatomic, strong) NSNumber *type;


//可选项选项
@property (nonatomic, copy) NSArray<XSHouseEnumDataEnumRes *> *enumRes;

@end

// 获取租房
@interface XSHouseEnum : XSBaseObject

//
@property (nonatomic, copy) NSString *code;
//
@property (nonatomic, copy) NSString *message;

//
@property (nonatomic, copy) NSArray<XSHouseEnumData *> *data;


@end


NS_ASSUME_NONNULL_END
