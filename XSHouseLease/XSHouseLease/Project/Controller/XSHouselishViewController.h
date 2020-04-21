//
//  XSHouselishViewController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseViewController.h"
#import "XSPageViewController.h"

@interface XSHouselishViewController : XSListContentViewController
@property(nonatomic,assign) XSBHouseType houseType;
@property(nonatomic,assign) XSBHouseInfoSource source;
@property(nonatomic,assign) XSHouseSource resource;

@property(nonatomic,assign) BOOL alittle;
@property(nonatomic,strong) NSNumber *house_id;
@property(nonatomic,strong) NSMutableDictionary *searchDict;
- (void)loadData;
@end



@interface XSHouseResourceListViewController : XSPageViewController
@property(nonatomic,assign) XSBHouseType houseType;
@property(nonatomic,assign) XSBHouseInfoSource source;
@property(nonatomic,assign) XSHouseSource resource;
@end

