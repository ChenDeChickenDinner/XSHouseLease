//
//  XSHouselishViewController.h
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSBaseViewController.h"
#import "XSPageViewController.h"
typedef void(^callBackHeight)(CGFloat height);

@interface XSHouselishViewController : XSListContentViewController
@property(nonatomic,assign) XSBHouseType houseType;
@property(nonatomic,assign) XSBHouseInfoSource source;
@property(nonatomic,assign) XSHouseSource resource;

@property(nonatomic,assign) NSInteger nubmer;
@property(nonatomic,strong) NSNumber *house_id;
@property (nonatomic ,strong) BRProvinceModel *cityModel;
@property (nonatomic ,strong) XSHouseEsModel *esModel;


@property(nonatomic,assign) BOOL module;
@property(nonatomic,assign) BOOL notHaveMenuView;


@property(nonatomic,copy) callBackHeight callBackHeight;

- (void)loadData;
@end



@interface XSHouseResourceListViewController : XSPageViewController
@property(nonatomic,assign) XSBHouseType houseType;
@property(nonatomic,assign) XSBHouseInfoSource source;
@property(nonatomic,assign) XSHouseSource resource;
@end

