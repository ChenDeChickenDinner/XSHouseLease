//
//  XSHouseRentStatusView.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/29.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseRentStatusView.h"
@interface XSHouseRentStatusModel :NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) UIColor *titleColor;
@property (nonatomic, strong) NSNumber *status; // 利用tag展示
@end
@implementation XSHouseRentStatusModel
+ (instancetype)initWithTitle:(NSString *)title status:(XSBHouseSubStatus)status titleColor:(UIColor *)titleColor{
    XSHouseRentStatusModel *model = [[XSHouseRentStatusModel alloc]init];
    model.title = title;
    model.titleColor = titleColor;
    model.status = [NSNumber numberWithInteger:status];
    return model;
}
@end

@interface XSHouseRentStatusView ()
@property(nonatomic,strong) NSMutableArray *modelArray;
@property(nonatomic,strong) NSMutableArray *viewArray;

@end

@implementation XSHouseRentStatusView
- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}
- (NSMutableArray *)viewArray{
    if (!_viewArray) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}
- (void)setStatus:(NSNumber *)status{
    _status = status;
    
    [self.modelArray removeAllObjects];

    for (UIView *view in self.viewArray) {
        [view removeFromSuperview];
    }
    [self.viewArray removeAllObjects];

    [self resetModelArray];
    
    [self addStatusSubView];
}
- (void)resetModelArray{

   UIColor *editcolor =  [UIColor hb_colorWithHexString:@"#1A9FF0" alpha:1];
    UIColor *huisecolor =  [UIColor hb_colorWithHexString:@"#878787" alpha:1];
    XSHouseRentStatusModel *editModel = [XSHouseRentStatusModel initWithTitle:@"编辑房源" status:XSBHouseSubStatus_edit titleColor:editcolor];
    XSHouseRentStatusModel *ztModel = [XSHouseRentStatusModel initWithTitle:@"暂停出租" status:XSBHouseSubStatus_ZT titleColor:huisecolor];
    XSHouseRentStatusModel *qxfbModel = [XSHouseRentStatusModel initWithTitle:@"取消上架" status:XSBHouseSubStatus_QXFB titleColor:huisecolor];
        XSHouseRentStatusModel *fbModel = [XSHouseRentStatusModel initWithTitle:@"恢复上架" status:XSBHouseSubStatus_FB titleColor:huisecolor];
    XSHouseRentStatusModel *cxfbModel = [XSHouseRentStatusModel initWithTitle:@"重新上架" status:XSBHouseSubStatus_DSH titleColor:huisecolor];
    switch (_status.integerValue) {
        case XSBHouseSubStatus_DSH:
            {
                [self.modelArray addObject:editModel];
            }
        break;
        case XSBHouseSubStatus_SHSB:
            {
                [self.modelArray addObject:editModel];

            }
        break;
        case XSBHouseSubStatus_QXFB:
            {
                [self.modelArray addObject:editModel];
                [self.modelArray addObject:cxfbModel];

            }
        break;
        case XSBHouseSubStatus_XJ:
            {
                [self.modelArray addObject:editModel];

            }
        break;
        case XSBHouseSubStatus_ZT:
            {
                [self.modelArray addObject:editModel];
                [self.modelArray addObject:fbModel];

            }
        break;
        case XSBHouseSubStatus_FB:
            {
                [self.modelArray addObject:ztModel];
                [self.modelArray addObject:qxfbModel];

            }
        break;
        default:
            break;
    }
}

#define btnWidth 65
#define btnJX 10

- (void)addStatusSubView{
    
    for (int i =0; i < self.modelArray.count; i++) {
        XSHouseRentStatusModel *model = [self.modelArray safeObjectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = model.status.integerValue;
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:model.title forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = model.titleColor.CGColor;
        [btn addTarget:self action:@selector(clickEditStatus:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(btnWidth * i + btnJX , 0, btnWidth, self.height);
        [self addSubview:btn];
    }
}
- (void)clickEditStatus:(UIButton *)btn{
    if (self.clickEditStatus) {
        self.clickEditStatus([NSNumber numberWithInteger:btn.tag]);
    }
}
@end
