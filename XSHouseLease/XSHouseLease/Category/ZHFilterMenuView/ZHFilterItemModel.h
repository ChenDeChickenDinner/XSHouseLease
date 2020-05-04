//
//  ZHFilterItemModel.h
//  ZHFilterMenuView
//
//  Created by 周亚楠 on 2019/12/6.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHFilterItemModel : NSObject <NSCoding>

@property (nonatomic, assign) BOOL selected;             //标记选择状态
@property (nonatomic, copy) NSString *key;              //名称
@property (nonatomic, copy) NSString *name;              //名称
@property (nonatomic, copy) NSString *code;              //code
@property (nonatomic, copy) NSString *parentKey;        //父类code
@property (nonatomic, copy) NSString *parentName;        //父类code
@property (nonatomic, copy) NSString *parentCode;        //父类code
@property (nonatomic, copy) NSString *minPrice;          //输入框最低值
@property (nonatomic, copy) NSString *maxPrice;          //输入框最大值
@property (nonatomic, assign) BOOL isinteger;            

@property (nonatomic, strong) NSMutableArray<ZHFilterItemModel *> *itemArr;   //item数据（暂时无用，后续拓展多层级展示时可使用）
- (void)setModelItemSelectesNO;
-(instancetype)initWithName:(NSString *)name code:(NSString *)code key:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
