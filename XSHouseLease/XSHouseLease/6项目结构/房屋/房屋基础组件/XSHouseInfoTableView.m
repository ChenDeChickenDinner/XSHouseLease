//
//  XSHouseInfoTableView.m
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseInfoTableView.h"

@interface XSHouseInfoTableView ()<UITableViewDelegate,UITableViewDataSource>
@end


@implementation XSHouseInfoTableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 100;
        self.backgroundColor = XSColor(246, 246, 246);
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
          self.mj_header.automaticallyChangeAlpha = YES;
          self.mj_footer.automaticallyChangeAlpha = YES;
    }
    return self;
}
- (NSArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return  _array;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}



- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XSBHouseInfoModel *model = [self.array safeObjectAtIndex:indexPath.row];
    
    XSHouseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellClass];
    if (!cell) {
         cell = [[NSBundle mainBundle] loadNibNamed:model.cellClass owner:self options:nil].lastObject;
    }
    [cell updateWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XSBHouseInfoModel *model = [self.array safeObjectAtIndex:indexPath.row];
    if (model.clickBlack) {
        model.clickBlack(model, XShouseOperation_click);
    }
}
@end
