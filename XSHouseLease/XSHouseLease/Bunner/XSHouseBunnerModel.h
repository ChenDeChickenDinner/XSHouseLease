//
//  XSHouseBunnerModel.h
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 广告轮播
@interface XSHouseBunnerModel : NSObject
@property(nonatomic,strong) NSNumber *ID;
@property(nonatomic,strong) NSNumber *order;
@property(nonatomic,strong) NSNumber *status;

@property(nonatomic,copy) NSString *imgUrl;
@property(nonatomic,copy) NSString *createDate;
@property(nonatomic,copy) NSString *updateDate;

@end

NS_ASSUME_NONNULL_END
