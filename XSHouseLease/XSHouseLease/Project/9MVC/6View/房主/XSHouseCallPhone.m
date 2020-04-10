//
//  XSHouseCellPhone.m
//  XSHouseLease
//
//  Created by heartbeats on 2020/3/28.
//  Copyright © 2020 fang. All rights reserved.
//

#import "XSHouseCallPhone.h"

@interface XSHouseCallPhone ()
@property (weak, nonatomic) IBOutlet UIView *houseUserInfoView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *cellPhone;
@property (weak, nonatomic) IBOutlet UIButton *callIm;
@property(nonatomic,strong)XSHouseInfoShowModel *model;

@end


@implementation XSHouseCallPhone

- (void)awakeFromNib{
    [super awakeFromNib];
    
}
+ (instancetype)callPhoneViewWithFrame:(CGRect)frame house_id:(NSNumber *)house_id{
    NSNumber *userId =  [XSUserServer sharedInstance].userModel.ID;
    if ([house_id isEqualToNumber:userId]) {
        return nil;
    }
    XSHouseCallPhone *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
    view.frame = frame;
    return view;
}
- (void)upDataWithDataModel:(XSHouseInfoShowModel *)dataModel{
      self.model = dataModel;
      [self.image sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"userIcon"]];
      self.name.text = dataModel.callName;
}
@end
