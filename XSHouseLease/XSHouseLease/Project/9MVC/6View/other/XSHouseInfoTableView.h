//
//  XSHouseInfoTableView.h
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSHouseInfoCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface XSHouseInfoTableView : UITableView
@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,assign) BOOL heardSearchView;
@end

NS_ASSUME_NONNULL_END
