//
//  XSHouseInfoCell.m
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseInfoCell.h"

@implementation XSHouseInfoCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;;

}
+ (instancetype)cellWithtableView:(UITableView *)tableView{
    return [[self alloc]initWithtableView:tableView];
}
- (instancetype)initWithtableView:(UITableView *)tableView{
    XSHouseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    }
    return cell;
}

- (void)updateWithModel:(XSBHouseInfoModel *)model{
    self.model = model;
}

@end
