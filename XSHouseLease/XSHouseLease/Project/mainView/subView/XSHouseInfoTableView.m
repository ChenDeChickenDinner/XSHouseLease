//
//  XSHouseInfoTableView.m
//  XSHouseLease
//
//  Created by xs on 2020/3/27.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseInfoTableView.h"
@interface XSSearchConditionalView : UIView

@end

@implementation XSSearchConditionalView
- (IBAction)click:(id)sender {
//    [ProgressHUD showSuccess:@"努力开发中"];
    [ProgressHUD showSuccess:@"努力开发中"];
}



@end


@implementation XSClickBtn

- (void)layoutSubviews{
    [super layoutSubviews];
 [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.size.width, 0,self.imageView.size.width)];

 [self setImageEdgeInsets:UIEdgeInsetsMake(0,self.titleLabel.bounds.size.width, 0, -(self.titleLabel.bounds.size.width + 5))];
}
- (void)awakeFromNib{
    [super awakeFromNib];

}
@end

@interface XSHouseInfoTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) XSSearchConditionalView *searchConditionalview;

@end


@implementation XSHouseInfoTableView
 - (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 100;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
          self.mj_header.automaticallyChangeAlpha = YES;
          self.mj_footer.automaticallyChangeAlpha = YES;
    }
    return self;
}

- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return  _array;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.heardSearchView) {
      return 65;
    }else{
      return 0;
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.heardSearchView) {
        XSSearchConditionalView *view  = [[NSBundle mainBundle] loadNibNamed:@"XSSearchConditionalView" owner:self options:nil].lastObject;
        return view;
    }else{
        return nil;
    }
}
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    XSHouseInfoShowModel *model = [self.array safeObjectAtIndex:indexPath.row];
    
    XSHouseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellClass];
    if (!cell) {
         cell = [[NSBundle mainBundle] loadNibNamed:model.cellClass owner:self options:nil].lastObject;
    }
    [cell updateWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    XSHouseInfoShowModel *model = [self.array safeObjectAtIndex:indexPath.row];
//    if (model.clickBlack) {
//        model.clickBlack(model, XShouseOperation_click);
//    }
}
@end
