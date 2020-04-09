//
//  XSHouseSubMitServer.h
//  XSHouseLease
//
//  Created by xs on 2020/4/9.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSBaseServer.h"
#import "XSHouseSubMitModel.h"


@interface XSHouseSubMitDynamicServer : XSBaseServer
+ (XSHouseSubMitDynamicServer *)sharedInstance;
@property (strong, nonatomic) NSArray<XSHouseInfoCellModel *> *secondDynamicArray;

@end

@interface XSHouseSubMitServer : XSBaseServer

+ (XSHouseSubMitServer *)sharedInstance;

@property (strong, nonatomic) NSMutableArray<XSHouseInfoCellModel *> *firstArray;
@property (strong, nonatomic) NSMutableArray<XSHouseInfoCellModel *> *secondArray;
@property (strong, nonatomic) NSMutableArray<XSHouseInfoCellModel *> *thirdArray;
@property (strong, nonatomic)  NSMutableArray *imageUrlArray;
@property (strong, nonatomic)  NSMutableArray *imageUrlServerArray;
@property (strong, nonatomic) NSMutableDictionary *subRentParameterDict;


- (void)resetData;
- (void)subRentParameterDictUpdateWithKey:(NSString *)key value:(id)value;
@property (strong, nonatomic) XSHouseRentInfoModel *renhousetInfoModel;

@end


